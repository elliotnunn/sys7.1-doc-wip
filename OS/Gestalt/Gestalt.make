#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Elliot make this change
#				  9/2/94	SuperMario ROM source dump (header preserved below)
#

#
#	File:		Gestalt.make
#
#	Contains:	Makefile for Gestalt.
#
#	Written by:	Kurt Clark, Chas Spillar, and Tim Nichols
#
#	Copyright:	© 1992-1993 by Apple Computer, Inc., all rights reserved.
#
#	Change History (most recent first):
#
#		<SM2>	  4/8/93	CSS		Update dependencies so that changing include files will cause
#									things to build.



GestaltObjs		=					"{ObjDir}GestaltPatchHead.a.o"					∂
									"{ObjDir}GestaltLookup.c.o"						∂
									"{IfObjDir}Interface.o"							∂
									"{ObjDir}GestaltFunction.a.o"					∂
									"{ObjDir}GestaltExtensions.a.o"
									
"{LibDir}Gestalt.lib"			ƒ	{GestaltObjs}
	Lib {StdLibOpts} -o "{Targ}" {GestaltObjs}


"{RsrcDir}Gestalt.rsrc"			ƒ	"{LibDir}Gestalt.lib"
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 "{LibDir}Gestalt.lib"


"{ObjDir}GestaltFunction.a.o"	ƒ 	"{ObjDir}StandardEqu.d"		 					∂
									"{IntAIncludes}HardwarePrivateEqu.a"			∂
									"{IntAIncludes}UniversalEqu.a"					∂
									"{AIncludes}SANEMacs881.a"						∂
									"{IntAIncludes}MMUEqu.a"						∂
									"{AIncludes}GestaltEqu.a"						∂
									"{IntAIncludes}GestaltPrivateEqu.a" 			∂
									"{IntAIncludes}InternalOnlyEqu.a"				∂
									"{IntAIncludes}EDiskEqu.a"						∂
									"{IntAIncludes}BootEqu.a"						∂
									"{GestaltDir}GestaltFunction.a"
	Asm {StdAOpts} -o "{Targ}" "{GestaltDir}GestaltFunction.a"


"{ObjDir}GestaltPatchHead.a.o"	ƒ 	"{GestaltDir}GestaltPatchHead.a"
	Asm {StdAOpts} -o "{Targ}" "{GestaltDir}GestaltPatchHead.a"


"{ObjDir}GestaltExtensions.a.o"	ƒ 	"{ObjDir}StandardEqu.d"		 					∂
									"{IntAIncludes}HardwarePrivateEqu.a"			∂
									"{AIncludes}GestaltEqu.a"						∂
									"{IntAIncludes}GestaltPrivateEqu.a" 			∂
									"{IntAIncludes}SysPrivateEqu.a"					∂
									"{IntAIncludes}InternalOnlyEqu.a"				∂
									"{GestaltDir}GestaltExtensions.a"
	Asm {StdAOpts} -o "{Targ}" "{GestaltDir}GestaltExtensions.a"


"{ObjDir}GestaltLookup.c.o"		ƒ 	"{CIncludes}GestaltEqu.h" 						∂
									"{CIncludes}Types.h"							∂
									"{CIncludes}Errors.h"							∂
									"{CIncludes}Memory.h"							∂
									"{CIncludes}SysEqu.h"							∂
									"{IntCIncludes}ExpandMemPriv.h"					∂
									"{IntCIncludes}GestaltPrivateEqu.h"				∂
									"{GestaltDir}GestaltLookup.c"
	C {StdCOpts} -o "{Targ}" "{GestaltDir}GestaltLookup.c"

