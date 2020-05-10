/*
	CDG5SystemSegment.c

				# ugly shell script to convert 'CODE' resources to 'scod',
				# and to rewrite the jump table

				Set Bin "{1}"
				Set Base "{2}"

				Set Script "{Bin}.sedhack"; Delete -i -y "{Script}"
				Set Txt "{Bin}.codehack"

				Set i 0
				Loop
					Break if {i} > 16 # max segments hardcoded

					# j is the new 4-digit hex of i
					Set j `Evaluate -H {i} + {Base}`
					Set j `Echo {j} | StreamEdit -e '/0x/ Rep // ""'`
					Set j `Echo 0000{j} | StreamEdit -d -e '/≈(????)®1/ Print ®1'`

					# ii is the old 4-digit hex of i
					Set ii `Evaluate -H {i}`
					Set ii `Echo {ii} | StreamEdit -e '/0x/ Rep // ""'`
					Set ii `Echo 0000{ii} | StreamEdit -d -e '/≈(????)®1/ Print ®1'`

					Echo "/•data/ Rep /CODE/ ∂"scod∂"; Rep /∂∂({i},/ ∂"(0x{j},∂"" >> "{Script}"
					Echo "/{ii} A9F0/ Rep // ∂"{j} A9F0∂" -c 2" >> "{Script}"

					Evaluate i += 1
				End

				DeRez -skip scod "{Bin}" | StreamEdit -s "{Script}" -e '/•data/ Rep /∂"≈∂", / ""' > "{Txt}"
				Rez "{Txt}" -o "{Bin}"


pascal void GetResInfo(Handle theResource,short *theID,ResType *theType,
 Str255 name)



	Hacks to match MacOS (most recent first):

	<Sys7.1>	  8/3/92	Written from scratch
*/

#include <string.h>

#include <Resources.h>
#include <Strings.h>


#define DIE_IF(cond) if(cond) {fprintf(stderr, "CDG5SystemSegment.c:%d: fatal error\n", __LINE__); exit(1);}


/* MPW Tool interface. */
int main(int argc, char **argv)
{
	short refnum;
	long i, k;

	return 0;
}
