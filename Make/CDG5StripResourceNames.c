/*
	CDG5StripResourceNames.c

	Remove the very common "Main" segment name from every system resource.

	Hacks to match MacOS (most recent first):

	<Sys7.1>	  8/3/92	Written from scratch
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <Memory.h>
#include <Resources.h>
#include <Strings.h>


#define DIE_IF(cond) if(cond) {fprintf(stderr, "CDG5StripResourceNames.c:%d: fatal error\n", __LINE__); exit(1);}


/* MPW Tool interface. */
int main(int argc, char **argv)
{
	short refnum;

	Handle res;
	long i, j;
	unsigned long type;
	short id;
	short attrs;
	unsigned char name[256];

	DIE_IF(argc != 2);

	SetResLoad(0);
	refnum = OpenResFile(c2pstr(argv[1])); DIE_IF(refnum <= 0);

	for (i=Count1Types(); i>0; i--) {
		Get1IndType(&type, i);

		for (j=Count1Resources(type); j>0; j--) {
			res = Get1IndResource(type, j); DIE_IF(!res);
			GetResInfo(res, &id, &type, name);

			if (!strcmp(p2cstr(name), "Main")) {
				attrs = GetResAttrs(res);
				SetResAttrs(res, 0); /* Defeat 'protected' flag */
				SetResInfo(res, id, "\p");
				SetResAttrs(res, attrs);
				ChangedResource(res);
			}

			ReleaseResource(res);
		}
	}

	SetResLoad(1);

	return 0;
}
