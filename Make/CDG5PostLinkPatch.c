/*
	CDG5PostLinkPatch.c

	Source for an MPW tool that imposes the will of ForceMakePatchOrder.a on lpch 63.

	Hacks to match MacOS (most recent first):

	<Sys7.1>	  8/3/92	Written from scratch
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <Memory.h>
#include <Resources.h>
#include <Strings.h>


#define DIE_IF(cond) if(cond) {fprintf(stderr, "CDG5PostLinkPatch.c:%d: fatal error\n", __LINE__); exit(1);}


/* LinkedPatch.a */
int NumROMs(void);
int NumConditions(void);


/* We keep a long table of these for re-sorting. */
struct myPatch {
	unsigned long conds;
	unsigned int trap;
	unsigned int jt;
	char searchString[256];
	char *bubbleSortOrder;
};


/* Number of bytes required for NumConditions() bits. */
int NumConditionBytes(void)
{
	return (NumConditions() + 7) / 8;
}


/* Load lpch 63. */
Handle getTheResource(unsigned char *pstrPath)
{
	Handle res;
	short refnum;

	SetResLoad(0);
	refnum = OpenResFile(pstrPath); DIE_IF(refnum <= 0);
	SetResLoad(1);
	res = Get1Resource('lpch', (1 << NumROMs()) - 1);

	return res;
}


/* Find the offset of the packed MakePatch table at the very end of lpch 63 buffer. */
unsigned long getPatchTableOffset(unsigned char *ptr)
{
	unsigned char *oldPtr = ptr;

	/* Skip ROM address table and jump table sizes. */
	ptr += 4; 

	/* Skip code. */
	ptr += 4 + (ptr[0] << 24) + (ptr[1] << 16) + (ptr[2] << 8) + ptr[3]; 

	/* Skip the whole packed ROM table. */
	if (ptr[0] == 255 && ptr[1] == 255) {
		ptr += 2; /* FFFF means no table. */
	} else {
		ptr += 2; /* Skip that number regardless. */
		while (ptr[0] & 0x80 == 0) { /* Last 3-byte table entry has high bit set. */
			ptr += 3;
		}
		ptr += 3;
	}

	/* Skip the ROM exception table. */
	while (ptr[0] || ptr[1] || ptr[2]) {
		ptr += 3;
	}
	ptr += 3;

	/* Skip the packed jump table. */
	for (;;) {
		if (ptr[0] == 255) {
			ptr += 3;
		} else if (ptr[0] == 252) {
			ptr += 1;
			if (ptr[0] == 0) {
				ptr += 1;
				break;
			} else if (ptr[0] == 255) {
				ptr += 3;
			} else {
				ptr += 1;
			}
		} else {
			ptr += 1;
		}
	}

	return ptr - oldPtr;
}


/* Unpack the lpch 63 MakePatch table into an array of structs. */
struct myPatch *unpackPatchList(unsigned char *ptr)
{
	struct myPatch nextPatch;
	struct myPatch *list;
	unsigned long bufidx;
	unsigned long bufsize;

	memset(&nextPatch, 0, sizeof nextPatch); /* Miserable C89 */

	bufidx = 0;
	bufsize = 1;
	list = malloc(bufsize * sizeof *list); DIE_IF(!list);

	/* Finally made it to the packed patch table */
	for (;;) {
		int i;

		nextPatch.conds = 0;
		for (i=0; i<NumConditionBytes(); i++) {
			nextPatch.conds <<= 8;
			nextPatch.conds |= *ptr++;
		}

		for (;;) {
			unsigned int delta;

			if (ptr[0] == 255) {
				ptr += 1;
				delta = (ptr[0] << 8) + ptr[1];
				ptr += 2;
				if (!delta) {
					memset(list + bufidx, 0, sizeof *list);
					return list; /* Only way out */
				}
			} else if (ptr[0] == 254) {
				ptr += 1;
				break; /* End of condition set */
			} else {
				delta = ptr[0];
				ptr += 1;
			}
			nextPatch.jt += delta;

			nextPatch.trap = (ptr[0] << 8) + ptr[1];
			ptr += 2;

			if (bufidx + 2 > bufsize) {
				bufsize *= 2;
				list = realloc(list, bufsize * sizeof *list); DIE_IF(!list);
			}

			list[bufidx++] = nextPatch;
		}
	}
}


/* Pack the array of structs back into lpch 63, and return the length used. */
unsigned long packPatchList(unsigned char *ptr, struct myPatch *list)
{
	unsigned char *oldPtr = ptr;

	unsigned long jt;
	unsigned long conds;
	int i;

	conds = 0;
	jt = 0;

	while (list->conds) {
		unsigned long delta;

		if (list->conds != conds) {
			if (conds) { /* Not the first, need some info */
				*ptr++ = 254;
			}

			for (i=NumConditionBytes()-1; i>=0; i--) {
				*ptr++ = list->conds >> (8 * i);
			}
		}

		delta = list->jt - jt;

		if (delta <= 253) {
			*ptr++ = delta;
		} else {
			*ptr++ = 255;
			*ptr++ = delta >> 8;
			*ptr++ = delta;
		}

		*ptr++ = list->trap >> 8;
		*ptr++ = list->trap;

		conds = list->conds;
		jt = list->jt;

		list++;
	}

	*ptr++ = 255;
	*ptr++ = 0;
	*ptr++ = 0;

	return ptr - oldPtr;
}


/* Read the output of LinkPatch -l to put names to symbol JT offsets. */
char *readSymNameList(char *cstrPath)
{
	FILE *fp;
	unsigned int symnum;
	char symname[256];
	unsigned int bufsize;
	char *list;

	bufsize = 1;
	list = malloc(bufsize * 256); DIE_IF(!list);
	memset(list, 0, bufsize * 256);

	fp = fopen(cstrPath, "r"); DIE_IF(!fp);

	while (fscanf(fp, "%x %s\n", &symnum, symname) == 2)
	{
		while (symnum >= bufsize) {
			bufsize *= 2;
			list = realloc(list, bufsize * 256); DIE_IF(!list);
			memset(list + bufsize / 2 * 256, 0, bufsize / 2 * 256);
		}
		strcpy(list + symnum * 256, symname);
	}

	fclose(fp);

	return list;
}


/* Slurp ForceMakePatchOrder.a.o into a single null terminated string, which we will search as below. */
char *slurpAsStr(char *cstrPath)
{
	FILE *fp;
	unsigned long len, i;
	char *str;

	fp = fopen(cstrPath, "rb"); DIE_IF(!fp);

	fseek(fp, 0, SEEK_END);
	len = ftell(fp);
	fseek(fp, 0, SEEK_SET);
	str = malloc(len + 1); DIE_IF(!str);

	DIE_IF(fread(str, 1, len, fp) != len);
	fclose(fp);

	/* Just turn nulls into spaces, so we can search with strstr. */
	for (i=0; i<len; i++) {
		if (str[i] == 0) {
			str[i] = ' ';
		}
	}
	str[len] = 0;

	return str;
}


/* Generate the "PATCH$NAME$TRAPINT$CONDINT$" strings that we will search ForceMakePatchOrder.a.o for. */
void populateSearchStrs(struct myPatch *patchList, char *symNameList)
{
	while (patchList->conds != 0) {
		sprintf(patchList->searchString, "PATCH$%s$%d$%d$",
			symNameList + 256 * patchList->jt,
			patchList->trap,
			patchList->conds);
		patchList++;
	}
}


/* Sort contiguous patches pointing to the same routine, according to ForceMakePatchOrder.a. */
void sortPatchList(struct myPatch *list, char *orderStr)
{
	unsigned long i, cnt;
	int bubbleFlag;

	/* Important to have a count */
	cnt = 0; while (list[cnt].conds != 0) cnt++;

	/* Precompute sort keys */
	for (i=0; i<cnt; i++) {
		list[i].bubbleSortOrder = strstr(orderStr, list[i].searchString);
	}

	/* Do the bubble sort (wince) */
	do {
		bubbleFlag = 0;
		for (i=0; i<cnt-1; i++) {
			if (list[i].jt == list[i+1].jt) {
				if (list[i].bubbleSortOrder > list[i+1].bubbleSortOrder) {
					struct myPatch swap;
					swap = list[i];
					list[i] = list[i+1];
					list[i+1] = swap;
					bubbleFlag = 1;
				}
			}
		}
	} while (bubbleFlag);
}


/* Print the names of routines that have multiple patches, for disambiguation in ForceMakePatchOrder.a. */
void printProblemSymbols(struct myPatch *patchList, char *symNameList)
{
	unsigned long ctr = 0;

	while (patchList->conds != 0) {
		ctr++;

		if (patchList[0].jt != patchList[1].jt) {
			if (ctr > 1) {
				char *name = symNameList + 256 * patchList[0].jt;
				if (*name) { /* Fall back on hex JT offset if name not known. */
					printf("%d\t%s\n", ctr, name);
				} else {
					printf("%d\t%X\n", ctr, patchList[0].jt);
				}
			}

			ctr = 0;
		}

		patchList++;
	}
}


/* MPW Tool interface. */
int main(int argc, char **argv)
{
	Handle lpch63;
	unsigned long lpch63Offset;
	char *symNameList;
	char *patchOrderStr;
	struct myPatch *patchList;

	DIE_IF(argc != 4);

	lpch63 = getTheResource(c2pstr(argv[1]));
	lpch63Offset = getPatchTableOffset(*lpch63);

	/* Get some slop before we start allocating memory below */
	SetHandleSize(lpch63, GetHandleSize(lpch63) * 5 + 10); DIE_IF(MemError());
	HLock(lpch63);

	/* Do the real work */
	symNameList = readSymNameList(argv[2]);
	patchOrderStr = slurpAsStr(argv[3]);
	patchList = unpackPatchList(*lpch63 + lpch63Offset);
	printProblemSymbols(patchList, symNameList);
	populateSearchStrs(patchList, symNameList);
	sortPatchList(patchList, patchOrderStr);

	/* Delete the slop that we added */
	SetHandleSize(lpch63, lpch63Offset + packPatchList(*lpch63 + lpch63Offset, patchList));
	ChangedResource(lpch63);

	return 0;
}
