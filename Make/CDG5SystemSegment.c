/*
	CDG5SystemSegment.c

	The Process Manager is segmented like an application, but with 'scod' resources in the Segment
	Manager's special $BF00 [-16640:-16385] range. This tool postprocesses the linker output
	accordingly. It needs to be linked into a single segment to prevent the Segment Loader from
	running the wrong code. It uses Get1IndResource to circumvent the 'scod' patches on
	Get(1)Resource.

	Hacks to match MacOS (most recent first):

	<Sys7.1>	  8/3/92	Written from scratch
*/

#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#include <Resources.h>
#include <Memory.h>
#include <Strings.h>


#define DIE_IF(cond) if(cond) {fprintf(stderr, "CDG5SystemSegment.c:%d: fatal error\n", __LINE__); exit(1);}


/* MPW Tool interface. */
int main(int argc, char **argv)
{
	short refnum;
	short idDelta;
	Handle res;

	SetResLoad(0);

	DIE_IF(argc != 3);
	refnum = OpenResFile(c2pstr(argv[1])); DIE_IF(refnum <= 0);
	idDelta = atoi(argv[2]);

	/* Delete left-over scods, zeroing the 'protected' flag. */
	while (Count1Resources('scod') > 0) {
		res = Get1IndResource('scod', 1); DIE_IF(!res);
		SetResAttrs(res, 0);
		RmveResource(res);
	}

	/* Copy each CODE to a renumbered nameless scod. Delete originals. */
	while (Count1Resources('CODE') > 0) {
		unsigned long copytype;
		short copyid;
		unsigned char copyname[256];
		short copyattrs;
		long i, len;

		SetResLoad(1);
		res = Get1IndResource('CODE', 1); DIE_IF(!res);
		copyattrs = GetResAttrs(res);
		GetResInfo(res, &copyid, &copytype, copyname);
		DetachResource(res);

		/* Renumber the references in the jump table. */
		if (copyid == 0) {
			len = GetHandleSize(res);
			for (i=20; i<len; i+=8) {
				*(short *)(*res + i) += idDelta;
			}
		}

		AddResource(res, 'scod', copyid + idDelta, NULL);
		SetResAttrs(res, copyattrs);
		ChangedResource(res);
		ReleaseResource(res);

		SetResLoad(0);
		res = Get1IndResource('CODE', 1); DIE_IF(!res);
		RmveResource(res);
	}

	SetResLoad(1);

	return 0;
}
