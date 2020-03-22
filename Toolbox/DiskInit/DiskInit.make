#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Written from scratch to replace missing makefile
#

"{RsrcDir}DiskInit.rsrc"			ƒ	"{RIncludes}Types.r"						∂
										"{RIncludes}BalloonTypes.r"					∂
										"{ObjDir}DiskInit.a.rsrc"					∂
										"{ObjDir}DiskInitHFS.a.rsrc"				∂
										"{DiskInitDir}DiskInit.r"
	Rez {StdROpts} -o {Targ} "{DiskInitDir}DiskInit.r"

DiskInitObjs						=	"{ObjDir}DiskInit.a.o"						∂
										"{ObjDir}DiskInitBadBlock.c.o"				∂
										"{IfObjDir}Interface.o"						∂
										"{Libraries}Runtime.o"						∂

"{ObjDir}DiskInit.a.rsrc"			ƒ	{DiskInitObjs}
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o {Targ} {DiskInitObjs}

"{ObjDir}DiskInitHFS.a.rsrc"		ƒ	"{ObjDir}DiskInitHFS.a.o"
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o {Targ} "{ObjDir}DiskInitHFS.a.o"

"{ObjDir}DiskInit.a.o"				ƒ	"{ObjDir}StandardEqu.d"						∂
										"{IntAIncludes}HardwarePrivateEqu.a"		∂
										"{AIncludes}SonyEqu.a"						∂
										"{AIncludes}Packages.a"						∂
										"{AIncludes}Balloons.a"						∂
										"{DiskInitDir}DiskInit.a"
	Asm {StdAOpts} -d SonyNonPortable=1 -d onMac=TRUE -o {Targ} "{DiskInitDir}DiskInit.a"

"{ObjDir}DiskInitHFS.a.o"			ƒ	"{ObjDir}StandardEqu.d"						∂
										"{IntAIncludes}HardwarePrivateEqu.a"		∂
										"{AIncludes}SonyEqu.a"						∂
										"{DiskInitDir}DiskInitHFS.a"
	Asm {StdAOpts} -o {Targ} "{DiskInitDir}DiskInitHFS.a"

"{ObjDir}DiskInitBadBlock.c.o"		ƒ	"{CIncludes}Errors.h"						∂
										"{CIncludes}Files.h"						∂
										"{CIncludes}Devices.h"						∂
										"{CIncludes}Memory.h"						∂
										"{IntCIncludes}HFSDefs.h"					∂
										"{CIncludes}Disks.h"						∂
										"{DiskInitDir}DiskInitBadBlock.c"
	C {StdCOpts} -o {Targ} "{DiskInitDir}DiskInitBadBlock.c"
