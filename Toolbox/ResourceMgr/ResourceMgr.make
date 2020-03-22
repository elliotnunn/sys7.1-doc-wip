#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Leave ResourceMgr.a out of linked patches -- it is not needed, and its
#							SuperMario changes (an OPENRESFILE symbol) mess up the build.
#							Include ResourceMgrPatches.a in the linked patches.
#							Add some rules for the linked patches.
#				  9/2/94	SuperMario ROM source dump (header preserved below)
#

#
#	File:		ResourceMgr.make
#
#	Contains:	Makefile for the Resource Manager.
#
#	Written by:	Kurt Clark, Chas Spillar, and Tim Nichols
#
#	Copyright:	© 1992-1993 by Apple Computer, Inc., all rights reserved.
#
#	Change History (most recent first):
#
#	   <SM2>	 6/14/93	kc		Roll in Ludwig.
#	   <LW2>	  4/8/93	fau		Updated the dependencies for ResourceMgr.a.
#

ResourceMgrObjs				=			"{ObjDir}ResourceMgrExtensions.a.o"			∂
										"{ObjDir}ResourceMgrPatches.a.o"	# <Sys7.1>

				
"{LibDir}ResourceMgr.lib"			ƒ	{ResourceMgrObjs}
	Lib {StdLibOpts} -o "{Targ}" {ResourceMgrObjs}


"{ObjDir}ResourceMgr.a.o"			ƒ	"{ObjDir}StandardEqu.d"						∂
										"{AIncludes}HardwareEqu.a"					∂
										"{IntAIncludes}Decompression.a"				∂
										"{IntAIncludes}ResourceMgrPriv.a"			∂
										"{IntAIncludes}UniversalEqu.a"				∂
										"{IntAIncludes}InternalOnlyEqu.a"			∂
										"{IntAIncludes}SysPrivateEqu.a"				∂
										"{ResourceMgrDir}ResourceMgr.a"
	Asm {StdAOpts} -o "{Targ}" "{ResourceMgrDir}ResourceMgr.a"


"{ObjDir}ResourceMgrExtensions.a.o"	ƒ	"{AIncludes}SysEqu.a"						∂
										"{IntAIncludes}SysPrivateEqu.a"				∂
										"{AIncludes}SysErr.a"						∂
										"{AIncludes}ToolUtils.a"					∂
										"{AIncludes}Traps.a"						∂
										"{IntAIncludes}MFPrivate.a"					∂
										"{IntAIncludes}ResourceMgrPriv.a"			∂
										"{IntAIncludes}LinkedPatchMacros.a"						∂
										"{ResourceMgrDir}ResourceMgrExtensions.a"
	Asm {StdAOpts} -o "{Targ}" "{ResourceMgrDir}ResourceMgrExtensions.a"


# <Sys7.1>
"{ObjDir}ResourceMgrPatches.a.o"	ƒ	"{ResourceMgrDir}ResourceMgrPatches.a"
	Asm {StdAOpts} -o "{Targ}" "{ResourceMgrDir}ResourceMgrPatches.a"


# <Sys7.1>
"{ObjDir}ResourceOverridePatches.a.o"	ƒ	"{ResourceMgrDir}ResourceOverridePatches.a"
	Asm {StdAOpts} -o "{Targ}" "{ResourceMgrDir}ResourceOverridePatches.a"


# <Sys7.1>
"{ObjDir}OpenResFile.a.o"			ƒ	"{ResourceMgrDir}OpenResFile.a"
	Asm {StdAOpts} -o "{Targ}" "{ResourceMgrDir}OpenResFile.a"


