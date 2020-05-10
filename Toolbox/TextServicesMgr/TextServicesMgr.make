#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Elliot make this change
#				  9/2/94	SuperMario ROM source dump (header preserved below)
#

#
#	File:		TextServicesMgr.make
#
#	Contains:	Makefile for the Text Services Manager.
#
#	Written by:	Kurt Clark, Chas Spillar, and Tim Nichols
#
#	Copyright:	© 1992 by Apple Computer, Inc., all rights reserved.
#
#	Change History (most recent first):
#


TextServicesMgrObjs	=				"{ObjDir}TSMDispatch.a.o"					∂
									"{ObjDir}TSMFunctions.c.o"					∂
									"{ObjDir}TSMUtility.c.o"					∂
									"{ObjDir}TSMInternalUtils.c.o"


"{LibDir}TextServicesMgr.lib" 	ƒ	{TextServicesMgrObjs}
	Lib {StdLibOpts} -o "{Targ}"	{TextServicesMgrObjs}


"{ObjDir}TSMDispatch.a.o"	ƒ	"{TextServicesDir}TSMDispatch.a"
	Asm {StdAOpts} -o "{Targ}" "{TextServicesDir}TSMDispatch.a"


"{ObjDir}TSMExtension.a.o"	ƒ	"{ObjDir}StandardEqu.d"							∂
								"{AIncludes}TextServices.a"						∂
								"{IntAIncludes}TSMPrivate.a"					∂
								"{TextServicesDir}TSMExtension.a"
	Asm {StdAOpts} -o "{Targ}" "{TextServicesDir}TSMExtension.a"


{ObjDir}TSMFunctions.c.o	ƒ	"{TextServicesDir}TSMFunctions.c"				∂
								"{CIncludes}Components.h"						∂
								"{IntCIncludes}TSMPrivate.h"					∂
								"{CIncludes}TextServices.h"
	C {StdCOpts} -o "{Targ}" "{TextServicesDir}TSMFunctions.c"


"{ObjDir}TSMUtility.c.o"	ƒ	"{TextServicesDir}TSMUtility.c"					∂
								"{CIncludes}Script.h"							∂
								"{CIncludes}Components.h"						∂
								"{IntCIncludes}TSMPrivate.h"					∂
								"{CIncludes}TextServices.h"
	C {StdCOpts} -o "{Targ}" "{TextServicesDir}TSMUtility.c"


"{ObjDir}TSMInternalUtils.c.o"	ƒ	"{TextServicesDir}TSMInternalUtils.c"		∂
									"{CIncludes}Components.h"					∂
									"{IntCIncludes}TSMPrivate.h"				∂
									"{CIncludes}TextServices.h"
	C {StdCOpts} -o "{Targ}" "{TextServicesDir}TSMInternalUtils.c"

