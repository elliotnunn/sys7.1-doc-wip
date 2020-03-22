#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Split hypothetical library ModalDialogMenuPatches.lib off from
#							a reordered DialogMgr.lib, and put DialogMgrPatches.a back in
#				  9/2/94	SuperMario ROM source dump (header preserved below)
#
#							Clean diff against SuperMario
#

#
#	File:		DialogMgr.make
#
#	Contains:	Makefile for the Dialog Manager.
#
#	Written by:	Kurt Clark, Chas Spillar, and Tim Nichols
#
#	Copyright:	© 1992 by Apple Computer, Inc., all rights reserved.
#
#	Change History (most recent first):
#


DialogMgrObjects						=	"{ObjDir}DialogMgr.a.o"						∂
											"{ObjDir}DialogDispatch.a.o"				∂
											"{ObjDir}DialogMgrPatches.a.o"	# <Sys7.1>	∂
											"{ObjDir}DialogMgrExtensions.a.o"			∂
											"{ObjDir}DialogMgrExtensions.c.o"			∂


"{LibDir}DialogMgr.lib"				ƒ	{DialogMgrObjects}
	Lib {StdLibOpts} -o "{Targ}" {DialogMgrObjects}

	
# <Sys7.1>
ModalDialogMenuPatchObjs				=	"{ObjDir}ModalDialogMenuPatches.a.o"		∂
											"{ObjDir}ModalDialogMenuExtensions.a.o"		∂
											"{ObjDir}ModalDialogMenuExtensions.c.o"


# <Sys7.1>
"{LibDir}ModalDialogMenuPatches.lib"	ƒ	{ModalDialogMenuPatchObjs}
	Lib {StdLibOpts} -o "{Targ}" {ModalDialogMenuPatchObjs}


"{ObjDir}DialogMgr.a.o"					ƒ	"{ObjDir}StandardEqu.d"						∂
											"{IntAIncludes}ColorEqu.a"					∂
											"{IntAIncludes}DialogsPriv.a"				∂
											"{DialogDir}DialogMgr.a"
	Asm {StdAOpts} -o "{Targ}" "{DialogDir}DialogMgr.a"


"{ObjDir}DialogMgrExtensions.a.o"		ƒ	"{ObjDir}StandardEqu.d"						∂
											"{AIncludes}Processes.a"					∂
											"{DialogDir}DialogMgrExtensions.a"
	Asm {StdAOpts} -o "{Targ}" "{DialogDir}DialogMgrExtensions.a"


"{ObjDir}DialogMgrExtensions.c.o"		ƒ	"{CIncludes}Memory.h"						∂
											"{CIncludes}ToolUtils.h"					∂
											"{CIncludes}Script.h"						∂
											"{IntCIncludes}ScriptPriv.h"				∂
											"{IntCIncludes}DialogsPriv.h"				∂
											"{DialogDir}DialogMgrExtensions.c"
	C {StdCOpts} -o "{Targ}" "{DialogDir}DialogMgrExtensions.c"


"{ObjDir}ModalDialogMenuExtensions.a.o"	ƒ	"{ObjDir}StandardEqu.d"						∂
											"{IntAIncludes}BalloonsPriv.a"				∂
											"{IntAIncludes}ScriptPriv.a"				∂
											"{IntAIncludes}MenuMgrPriv.a"				∂
											"{DialogDir}ModalDialogMenuExtensions.a"
	Asm {StdAOpts} -i "{HelpMgrDir}" -o "{Targ}" "{DialogDir}ModalDialogMenuExtensions.a"


"{ObjDir}ModalDialogMenuExtensions.c.o" ƒ  "{CIncludes}Memory.h"						∂
											"{CIncludes}OSUtils.h"						∂
											"{CIncludes}TextUtils.h"					∂
											"{CIncludes}Menus.h"						∂
											"{IntCIncludes}MenuMgrPriv.h"				∂
											"{CIncludes}Windows.h"						∂
											"{CIncludes}Processes.h"					∂
											"{CIncludes}Dialogs.h"						∂
											"{IntCIncludes}DialogsPriv.h"				∂
											"{CIncludes}Events.h"						∂
											"{DialogDir}ModalDialogMenuExtensions.c"
	C {StdCOpts} -o "{Targ}" "{DialogDir}ModalDialogMenuExtensions.c"


"{ObjDir}DialogDispatch.a.o"	ƒ 	"{ObjDir}StandardEqu.d"							∂
									"{IntAIncludes}InternalMacros.a"				∂
									"{IntAIncludes}LinkedPatchMacros.a"				∂
									"{IntAIncludes}DialogsPriv.a"					∂
									"{DialogDir}DialogDispatch.a"
	Asm {StdAOpts} -o "{Targ}" "{DialogDir}DialogDispatch.a"


# <Sys7.1>
"{ObjDir}DialogMgrPatches.a.o"	ƒ 	"{DialogDir}DialogMgrPatches.a"
	Asm {StdAOpts} -o "{Targ}" "{DialogDir}DialogMgrPatches.a"


# <Sys7.1>
"{ObjDir}ModalDialogMenuPatches.a.o"	ƒ 	"{DialogDir}ModalDialogMenuPatches.a"
	Asm {StdAOpts} -o "{Targ}" "{DialogDir}ModalDialogMenuPatches.a"
