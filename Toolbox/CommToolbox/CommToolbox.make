#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Elliot make this change
#				  9/2/94	SuperMario ROM source dump (header preserved below)
#

#
#	File:		CommToolbox.make
#
#	Contains:	Makefile for the CommToolbox.
#
#	Written by:	Kurt Clark, Chas Spillar, and Tim Nichols
#
#	Copyright:	© 1992 by Apple Computer, Inc., all rights reserved.
#
#	Change History (most recent first):
#
#	   <SM3>	12/11/92	chp		Removed runtime library routines not needed when compiled for
#									68020 or better.
#	   <SM2>	 12/2/92	kc		Added " || Exit 1" to commands with a double dependency.


CommTerminalDir		=	{CommToolboxDir}TerminalMgr:
CommResourceDir		=	{CommToolboxDir}CommResourceMgr:
CommStartupDir		=	{CommToolboxDir}CommToolboxStartup:
CommUtilityDir		=	{CommToolboxDir}CommToolboxUtilities:
CommConnectionDir	=	{CommToolboxDir}ConnectionMgr:
CommFileTransferDir	=	{CommToolboxDir}FileTransferMgr:
CommNBPDir			=	{CommUtilityDir}StandardNBP:
CommChooseDir		=	{CommUtilityDir}Choose:


ConnectionMgrObjs		=	"{ObjDir}ConnectionMgr.a.o"							∂
							"{ObjDir}ConnectionMgr.c.o"							∂
							"{ObjDir}CommToolboxUtilityRoutines.c.o"			∂
							"{IfObjDir}interface.o"


TerminalMgrObjs			=	"{ObjDir}TerminalMgr.a.o"							∂
							"{ObjDir}TerminalMgr.c.o"							∂
							"{IfObjDir}interface.o"								∂
							"{ObjDir}CommToolboxUtilityRoutines.c.o"			∂


FileTransferMgrObjs		=	"{ObjDir}FileTransferMgr.a.o"						∂
							"{ObjDir}FileTransferMgr.c.o"						∂
							"{ObjDir}CommToolboxUtilityRoutines.c.o"			∂
							"{IfObjDir}interface.o"								


CommToolboxUtilitiesObjs =	"{ObjDir}CommToolboxUtilities.a.o"					∂
							"{ObjDir}CommToolboxUtilities.c.o"					∂
							"{ObjDir}CommToolboxCore.c.o"						∂
							"{IfObjDir}interface.o"								∂
							"{ObjDir}CommToolboxUtilityRoutines.c.o"			∂


CommResourceMgrObjs		=	"{ObjDir}CommResourceMgr.a.o"						∂
							"{ObjDir}CommResourceMgr.c.o"						∂
							"{ObjDir}CommResourceMgr.p.o"						∂
							"{ObjDir}CommResourceMgrUtilities.a.o"				∂
							"{IfObjDir}interface.o"								


DITLObjs				=	"{ObjDir}DITL.a.o"									∂
							"{ObjDir}DITL.p.o"									∂
							"{IfObjDir}interface.o"								


CommToolboxLDEFObjs		=	"{ObjDir}CommToolboxLDEF.a.o"						∂
							"{ObjDir}CommToolboxLDEF.p.o"						∂
							"{ObjDir}CommToolboxUtilityRoutines.c.o"			∂
							"{IfObjDir}interface.o"								

ChooseObjs				=	"{ObjDir}Choose.a.o"								∂
							"{ObjDir}Choose.p.o"								∂
							"{ObjDir}ChooseUtilities.a.o"						∂
							"{IfObjDir}interface.o"								∂
							"{ObjDir}CommToolboxUtilityRoutines.c.o"			∂


StandardNBPObjs			=	"{ObjDir}StandardNBP.a.o"							∂
							"{ObjDir}StandardNBP.p.o"							∂
							"{ObjDir}ListUtilities.p.o"							∂
							"{ObjDir}StandardNBPUtilities.a.o"					∂
							"{ObjDir}ZIPUtilities.p.o"							∂
							"{ObjDir}NBPUtilities.p.o"							∂
							"{ObjDir}CommToolboxUtilityRoutines.c.o"			∂
							"{IfObjDir}interface.o"								∂
							"{PLibraries}PasLib.o"


StandardNBPLDEFObjs		=	"{ObjDir}StandardNBPLDEF.a.o"						∂
							"{ObjDir}StandardNBPLDEF.p.o"						∂
							"{ObjDir}CommToolboxUtilityRoutines.c.o"			∂
							"{IfObjDir}interface.o"								


CommToolboxPatchObjs	=	"{ObjDir}CommToolboxDispatcher.a.o"					∂
							"{ObjDir}CommToolboxPatches.a.o"					∂
							"{ObjDir}CommToolboxPatches.c.o"					∂
							"{ObjDir}CRMBuiltInSerial.c.o"



"{LibDir}CommToolboxPatch.Lib"	ƒ	{CommToolboxPatchObjs}
	Lib {StdLibOpts} -o "{Targ}" {CommToolboxPatchObjs} 


"{RsrcDir}ConnectionMgr.c.rsrc"	ƒ	{ConnectionMgrObjs}
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 {ConnectionMgrObjs} || Exit 1


"{RsrcDir}TerminalMgr.c.rsrc"	ƒ	{TerminalMgrObjs}
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 {TerminalMgrObjs} || Exit 1


"{RsrcDir}FileTransferMgr.c.rsrc"	ƒ	{FileTransferMgrObjs}
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 {FileTransferMgrObjs} || Exit 1


"{RsrcDir}CommToolboxUtilities.c.rsrc"	ƒ	{CommToolboxUtilitiesObjs}
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 {CommToolboxUtilitiesObjs} || Exit 1


"{RsrcDir}CommResourceMgr.c.rsrc"	ƒ	{CommResourceMgrObjs}
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 {CommResourceMgrObjs} || Exit 1


"{RsrcDir}DITL.p.rsrc"			ƒ	{DITLObjs}
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 {DITLObjs} || Exit 1


"{RsrcDir}CommToolboxLDEF.p.rsrc"	ƒ	{CommToolboxLDEFObjs}
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 {CommToolboxLDEFObjs} || Exit 1


"{RsrcDir}Choose.p.rsrc"		ƒ	{ChooseObjs}
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 {ChooseObjs} || Exit 1


"{RsrcDir}StandardNBP.p.rsrc"	ƒ	{StandardNBPObjs}
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 -m MAIN {StandardNBPObjs} || Exit 1


"{RsrcDir}StandardNBPLDEF.p.rsrc"	ƒ	{StandardNBPLDEFObjs}
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 {StandardNBPLDEFObjs} || Exit 1


"{RsrcDir}TerminalClick.r.rsrc"	ƒ	"{CommTerminalDir}TerminalClick.r"				∂
									"{RIncludes}SysTypes.r"						∂
									"{IntRIncludes}CommToolboxPriv.r"
	Rez {StdROpts} -o "{Targ}" "{CommTerminalDir}TerminalClick.r"  || Exit 1


"{RsrcDir}Choose.r.rsrc"		ƒ	"{CommChooseDir}Choose.r"				∂
									"{RIncludes}SysTypes.r"						∂
									"{RIncludes}Types.r"						∂
									"{RIncludes}CTBTypes.r"						∂
									"{IntRIncludes}CommToolboxPriv.r"
	Rez {StdROpts} -o "{Targ}" "{CommChooseDir}Choose.r" || Exit 1


"{RsrcDir}StandardNBP.r.rsrc"	ƒ	"{CommNBPDir}StandardNBP.r"				∂
									"{RIncludes}Types.r"						∂
									"{RIncludes}CTBTypes.r"						∂
									"{RIncludes}PICT.r"							∂
									"{IntRIncludes}CommToolboxPriv.r"
	Rez {StdROpts} -o "{Targ}" "{CommNBPDir}StandardNBP.r" || Exit 1


"{RsrcDir}ChooseHelp.r.rsrc"		ƒ	"{CommChooseDir}ChooseHelp.r"
	Rez {StdROpts} -o "{Targ}" "{CommChooseDir}ChooseHelp.r"


"{RsrcDir}StandardNBPHelp.r.rsrc"	ƒ	"{CommNBPDir}StandardNBPHelp.r"
	Rez {StdROpts} -o "{Targ}" "{CommNBPDir}StandardNBPHelp.r"


"{RsrcDir}CommToolboxINIT.r.rsrc"	ƒ	"{CommStartupDir}CommToolboxINIT.r"
	Rez {StdROpts} -o "{Targ}" "{CommStartupDir}CommToolboxINIT.r"


"{ObjDir}CommToolboxUtilityRoutines.c.o"	ƒ	"{CIncludes}Menus.h"								∂
												"{CIncludes}Dialogs.h"								∂
												"{CIncludes}QuickDraw.h"							∂
												"{CIncludes}Fonts.h"								∂
												"{CIncludes}SysEqu.h"								∂
												"{CIncludes}CTBUtilities.h"							∂
												"{CIncludes}CommResources.h"						∂
												"{IntCIncludes}CommToolboxPriv.h"					∂
												"{CommUtilityDir}CommToolboxUtilityRoutines.c"
	C {StdCOpts} -o "{Targ}" "{CommUtilityDir}CommToolboxUtilityRoutines.c"


"{ObjDir}CommResourceMgr.a.o"				ƒ	"{AIncludes}traps.a"								∂
												"{AIncludes}CommResources.a"						∂
												"{CommResourceDir}CommResourceMgr.a"
	Asm {StdAOpts} -o "{targ}" "{CommResourceDir}CommResourceMgr.a"


"{ObjDir}CommResourceMgr.c.o"				ƒ	"{CIncludes}SysEqu.h"								∂
												"{CIncludes}Types.h"								∂
												"{CIncludes}Memory.h"								∂
												"{CIncludes}Resources.h"							∂
												"{CIncludes}OSUtils.h"								∂
												"{CIncludes}Errors.h"								∂
												"{CIncludes}Folders.h"								∂
												"{CIncludes}CommResources.h"						∂
												"{CIncludes}Folders.h"								∂
												"{CIncludes}Files.h"								∂
												"{IntCIncludes}CommToolboxPriv.h"					∂
												"{CommResourceDir}CommResourceMgrExtensions.c"		∂
												"{CommResourceDir}CommResourceMgr.h"				∂
												"{CommResourceDir}CommResourceMgr.c"
	C {StdCOpts} -o "{targ}" "{CommResourceDir}CommResourceMgr.c"  


"{ObjDir}CommResourceMgr.p.o"				ƒ	"{PInterfaces}MemTypes.p"							∂
												"{PInterfaces}Types.p"								∂
												"{PInterfaces}Quickdraw.p"							∂
												"{PInterfaces}OSIntf.p"								∂
												"{PInterfaces}ToolIntf.p"							∂
												"{PInterfaces}PackIntf.p"							∂
												"{PInterfaces}SysEqu.p"								∂
												"{PInterfaces}Appletalk.p"							∂
												"{PInterfaces}CTBUtilities.p"						∂
												"{IntPInterfaces}CommToolboxPriv.p"					∂
												"{CommResourceDir}CommResourceMgr.p"
	Pascal {StdPOpts} -o "{targ}" "{CommResourceDir}CommResourceMgr.p"  


"{ObjDir}CommResourceMgrUtilities.a.o"		ƒ	"{AIncludes}SysEqu.a"								∂
												"{IntAIncludes}SysPrivateEqu.a"						∂
												"{AIncludes}SysErr.a"								∂
												"{AIncludes}ToolUtils.a"							∂
												"{AIncludes}Traps.a"								∂
												"{AIncludes}Aliases.a"								∂
												"{IntAIncludes}CommToolboxPriv.a"					∂
												"{CommResourceDir}CommResourceMgrUtilities.a"
	Asm {StdAOpts} -o "{targ}" "{CommResourceDir}CommResourceMgrUtilities.a"


"{ObjDir}CommToolboxUtilities.a.o"			ƒ	"{AIncludes}traps.a"								∂
												"{AIncludes}CTBUtilities.a"							∂
												"{IntAIncludes}CommToolboxPriv.a"					∂
												"{CommUtilityDir}CommToolboxUtilities.a"
	Asm {StdAOpts} -o "{targ}" "{CommUtilityDir}CommToolboxUtilities.a"

"{ObjDir}CommToolboxUtilities.c.o"			ƒ	"{CIncludes}Memory.h"								∂
												"{CIncludes}Resources.h"							∂
												"{CIncludes}Dialogs.h"								∂
												"{CIncludes}Events.h"								∂
												"{CIncludes}AppleTalk.h"							∂
												"{CIncludes}CommResources.h"						∂
												"{CIncludes}CTBUtilities.h"							∂
												"{IntCIncludes}CommToolboxPriv.h"					∂
												"{CommUtilityDir}CommToolboxUtilities.c"
	C {StdCOpts} -o "{targ}" "{CommUtilityDir}CommToolboxUtilities.c"  

"{ObjDir}CommToolboxCore.c.o"				ƒ	"{IntCIncludes}CommToolboxPriv.h"					∂
												"{CIncludes}CommResources.h"						∂
												"{CIncludes}CTBUtilities.h"							∂
												"{IntCIncludes}ConnectionsExtensions.h"				∂
												"{CIncludes}ConnectionTools.h"						∂
												"{CommUtilityDir}CommToolboxCore.c"
	C {StdCOpts} -o "{targ}" "{CommUtilityDir}CommToolboxCore.c"  


"{ObjDir}ChooseUtilities.a.o"				ƒ "{CommChooseDir}ChooseUtilities.a"
	Asm {StdAOpts} -o "{targ}" "{CommChooseDir}ChooseUtilities.a"


"{ObjDir}Choose.a.o"						ƒ	"{IntAIncludes}CommToolboxPriv.a"					∂
												"{CommChooseDir}Choose.a"
	Asm {StdAOpts} -o "{targ}" "{CommChooseDir}Choose.a"


"{ObjDir}Choose.p.o"						ƒ	"{PInterfaces}MemTypes.p"							∂
												"{PInterfaces}QuickDraw.p"							∂
												"{PInterfaces}OSIntf.p"								∂
												"{PInterfaces}ToolIntf.p"							∂
												"{PInterfaces}PackIntf.p"							∂
												"{PInterfaces}AppleTalk.p"							∂
												"{PInterfaces}SysEqu.p"								∂
												"{PInterfaces}Files.p"								∂
												"{PInterfaces}Aliases.p"							∂
												"{PInterfaces}Terminals.p"							∂
												"{PInterfaces}CommResources.p"						∂
												"{PInterfaces}Connections.p"						∂
												"{PInterfaces}FileTransfers.p"						∂
												"{PInterfaces}CTBUtilities.p"						∂
												"{IntPInterfaces}DialogsPriv.p"						∂
												"{IntPInterfaces}CommToolboxPriv.p"					∂
												"{CommChooseDir}Choose.p"
	Pascal {StdPOpts} -o "{targ}" "{CommChooseDir}Choose.p"  


"{ObjDir}StandardNBP.a.o"					ƒ	"{CommNBPDir}StandardNBP.a"						∂
												"{IntAIncludes}CommToolboxPriv.a"
	Asm {StdAOpts} -o "{targ}" "{CommNBPDir}StandardNBP.a"


"{ObjDir}StandardNBP.p.o"					ƒ	"{CommNBPDir}StandardNBP.p"						∂
												"{CommNBPDir}StandardNBPStructures.p"				∂
												"{CommNBPDir}ListUtilities.p"						∂
												"{CommNBPDir}NBPUtilities.p"						∂
												"{CommNBPDir}ZipUtilities.p"						∂
												"{PInterfaces}MemTypes.p"							∂
												"{PInterfaces}QuickDraw.p"							∂
												"{PInterfaces}OSIntf.p"								∂
												"{PInterfaces}ToolIntf.p"							∂
												"{PInterfaces}PackIntf.p"							∂
												"{PInterfaces}AppleTalk.p"							∂
												"{PInterfaces}Script.p"								∂
												"{PInterfaces}Traps.p"								∂
												"{PInterfaces}CTBUtilities.p"						∂
												"{IntPInterfaces}DialogsPriv.p"						∂
												"{IntPInterfaces}IntlUtilsPriv.p"					∂
												"{IntPInterfaces}CommToolboxPriv.p"
	Pascal {StdPOpts} -o "{targ}" "{CommNBPDir}StandardNBP.p"  


"{ObjDir}ListUtilities.p.o"					ƒ	"{CommNBPDir}ListUtilities.p"						∂
												"{CommNBPDir}StandardNBPStructures.p"				∂
												"{PInterfaces}MemTypes.p"							∂
												"{PInterfaces}QuickDraw.p"							∂
												"{PInterfaces}OSIntf.p"								∂
												"{PInterfaces}ToolIntf.p"							∂
												"{PInterfaces}PackIntf.p"							∂
												"{PInterfaces}AppleTalk.p"							∂
												"{PInterfaces}CTBUtilities.p"						∂
												"{IntPInterfaces}IntlUtilsPriv.p"					∂
												"{IntPInterfaces}CommToolboxPriv.p"
	Pascal {StdPOpts} -o "{targ}" "{CommNBPDir}ListUtilities.p"  


"{ObjDir}ZIPUtilities.p.o"					ƒ	"{CommNBPDir}ZIPUtilities.p"						∂
												"{CommNBPDir}StandardNBPStructures.p"				∂
												"{CommNBPDir}ListUtilities.p"						∂
												"{PInterfaces}MemTypes.p"							∂
												"{PInterfaces}QuickDraw.p"							∂
												"{PInterfaces}OSIntf.p"								∂
												"{PInterfaces}ToolIntf.p"							∂
												"{PInterfaces}PackIntf.p"							∂
												"{PInterfaces}AppleTalk.p"							∂
												"{PInterfaces}CTBUtilities.p"						∂
												"{IntPInterfaces}IntlUtilsPriv.p"					∂
												"{IntPInterfaces}CommToolboxPriv.p"
	Pascal {StdPOpts} -o "{targ}" "{CommNBPDir}ZIPUtilities.p"  


"{ObjDir}NBPUtilities.p.o"					ƒ	"{CommNBPDir}NBPUtilities.p"						∂
												"{CommNBPDir}StandardNBPStructures.p"				∂
												"{CommNBPDir}ListUtilities.p"						∂
												"{PInterfaces}MemTypes.p"							∂
												"{PInterfaces}QuickDraw.p"							∂
												"{PInterfaces}OSIntf.p"								∂
												"{PInterfaces}ToolIntf.p"							∂
												"{PInterfaces}PackIntf.p"							∂
												"{PInterfaces}AppleTalk.p"							∂
												"{PInterfaces}CTBUtilities.p"						∂
												"{IntPInterfaces}IntlUtilsPriv.p"					∂
												"{IntPInterfaces}CommToolboxPriv.p"
	Pascal {StdPOpts} -o "{targ}" "{CommNBPDir}NBPUtilities.p"  


"{ObjDir}StandardNBPUtilities.a.o"			ƒ "{CommNBPDir}StandardNBPUtilities.a"
	Asm {StdAOpts} -o "{targ}" "{CommNBPDir}StandardNBPUtilities.a"


"{ObjDir}StandardNBPLDEF.a.o"				ƒ	"{CommNBPDir}StandardNBPLDEF.a"					∂
												"{IntAIncludes}CommToolboxPriv.a"
	Asm {StdAOpts} -o "{Targ}" "{CommNBPDir}StandardNBPLDEF.a"


"{ObjDir}StandardNBPLDEF.p.o"				ƒ	"{CommNBPDir}StandardNBPLDEF.p" 					∂
												"{PInterfaces}MemTypes.p"							∂
												"{PInterfaces}QuickDraw.p"							∂
												"{PInterfaces}OSIntf.p"								∂
												"{PInterfaces}ToolIntf.p"							∂
												"{PInterfaces}PackIntf.p"							∂
												"{PInterfaces}AppleTalk.p"							∂
												"{PInterfaces}Script.p"								∂
												"{PInterfaces}Traps.p"								∂
												"{PInterfaces}SysEqu.p"								∂
												"{PInterfaces}CTBUtilities.p"						∂
												"{IntPInterfaces}CommToolboxPriv.p"					∂
												"{IntPInterfaces}IntlUtilsPriv.p"					∂
												"{CommNBPDir}StandardNBPStructures.p"
	Pascal {StdPOpts} -o "{targ}" "{CommNBPDir}StandardNBPLDEF.p"  


"{ObjDir}CommToolboxLDEF.a.o"				ƒ	"{CommUtilityDir}CommToolboxLDEF.a"			∂
												"{IntAIncludes}CommToolboxPriv.a"
	Asm {StdAOpts} -o "{targ}" "{CommUtilityDir}CommToolboxLDEF.a"


"{ObjDir}CommToolboxLDEF.p.o"				ƒ	"{CommUtilityDir}CommToolboxLDEF.p" 			∂
												"{PInterfaces}MemTypes.p"							∂
												"{PInterfaces}QuickDraw.p"							∂
												"{PInterfaces}OSIntf.p"								∂
												"{PInterfaces}ToolIntf.p"							∂
												"{PInterfaces}PackIntf.p"							∂
												"{PInterfaces}AppleTalk.p"							∂
												"{PInterfaces}Script.p"								∂
												"{PInterfaces}Traps.p"								∂
												"{PInterfaces}SysEqu.p"								∂
												"{IntPInterfaces}CommToolboxPriv.p"
	Pascal {StdPOpts} -o "{targ}" "{CommUtilityDir}CommToolboxLDEF.p"  


"{ObjDir}DITL.a.o"							ƒ	"{CommUtilityDir}DITL.a"						∂
												"{IntAIncludes}CommToolboxPriv.a"
	Asm {StdAOpts} -o "{targ}" "{CommUtilityDir}DITL.a"


"{ObjDir}DITL.p.o"							ƒ	"{CommUtilityDir}DITL.p" 						∂
												"{PInterfaces}MemTypes.p"							∂
												"{PInterfaces}QuickDraw.p"							∂
												"{PInterfaces}OSIntf.p"								∂
												"{PInterfaces}ToolIntf.p"							∂
												"{PInterfaces}PackIntf.p"							∂
												"{PInterfaces}AppleTalk.p"							∂
												"{PInterfaces}CTBUtilities.p"						∂
												"{IntPInterfaces}CommToolboxPriv.p"
	Pascal {StdPOpts} -o "{targ}" "{CommUtilityDir}DITL.p"  


"{ObjDir}ConnectionMgr.a.o"					ƒ	"{CommConnectionDir}ConnectionMgr.a"					∂
												"{AIncludes}Connections.a"							∂
												"{AIncludes}CTBUtilities.a"							∂
												"{AIncludes}ConnectionTools.a"						∂
												"{AIncludes}traps.a"								∂
												"{IntAIncludes}CommToolboxPriv.a"
	Asm {StdAOpts} -o "{targ}" "{CommConnectionDir}ConnectionMgr.a"


"{ObjDir}ConnectionMgr.c.o"					ƒ	"{CommConnectionDir}ConnectionMgr.c"					∂
												"{CIncludes}Errors.h"								∂
												"{CIncludes}Memory.h"								∂
												"{CIncludes}Resources.h"							∂
												"{CIncludes}OSUtils.h"								∂
												"{CIncludes}SysEqu.h"								∂
												"{CIncludes}CTBUtilities.h"							∂
												"{CIncludes}CommResources.h"						∂
												"{CIncludes}Connections.h"							∂
												"{CIncludes}ConnectionTools.h"						∂
												"{IntCIncludes}ConnectionsExtensions.h"				∂
												"{IntCIncludes}ConnectionsPriv.h"					∂
												"{IntCIncludes}CommToolboxPriv.h"					∂
												"{CommConnectionDir}ConnectionMgrUtilities.c"			∂
												"{CommConnectionDir}ConnectionMgrExtensions.c"
	C {StdCOpts} -o "{targ}" "{CommConnectionDir}ConnectionMgr.c"  


"{ObjDir}TerminalMgr.a.o"					ƒ	"{CommTerminalDir}TerminalMgr.a"						∂
												"{AIncludes}Terminals.a"							∂
												"{AIncludes}traps.a"								∂
												"{IntAIncludes}CommToolboxPriv.a"
	Asm {StdAOpts} -o "{targ}" "{CommTerminalDir}TerminalMgr.a"


"{ObjDir}TerminalMgr.c.o"					ƒ	"{CommTerminalDir}TerminalMgr.c"					∂
												"{CIncludes}Memory.h"								∂
												"{CIncludes}Resources.h"							∂
												"{CIncludes}ToolUtils.h"							∂
												"{CIncludes}SysEqu.h"								∂
												"{CIncludes}CTBUtilities.h"							∂
												"{CIncludes}CommResources.h"						∂
												"{CIncludes}Terminals.h"							∂
												"{CIncludes}TerminalTools.h"						∂
												"{IntCIncludes}TerminalsPriv.h"						∂
												"{IntCIncludes}TerminalToolsPriv.h"					∂
												"{IntCIncludes}CommToolboxPriv.h"					∂
												"{CommTerminalDir}TerminalMgrUtilities.c"			∂
												"{CommTerminalDir}TerminalMgrExtensions.c"
	C {StdCOpts} -o "{targ}" "{CommTerminalDir}TerminalMgr.c"  


"{ObjDir}FileTransferMgr.a.o"				ƒ	"{CommFileTransferDir}FileTransferMgr.a"				∂
												"{AIncludes}FileTransfers.a"						∂
												"{AIncludes}CTBUtilities.a"							∂
												"{AIncludes}traps.a"								∂
												"{IntAIncludes}CommToolboxPriv.a"
	Asm {StdAOpts} -o "{targ}" "{CommFileTransferDir}FileTransferMgr.a"


"{ObjDir}FileTransferMgr.c.o"				ƒ	"{CommFileTransferDir}FileTransferMgr.c"				∂
												"{CIncludes}Memory.h"								∂
												"{CIncludes}Resources.h"							∂
												"{CIncludes}Types.h"								∂
												"{CIncludes}SysEqu.h"								∂
												"{CIncludes}CTBUtilities.h"							∂
												"{CIncludes}CommResources.h"						∂
												"{CIncludes}FileTransfers.h"						∂
												"{CIncludes}FileTransferTools.h"					∂
												"{IntCIncludes}FileTransferToolsPriv.h"				∂
												"{IntCIncludes}CommToolboxPriv.h"					∂
												"{CommFileTransferDir}FileTransferMgrUtilities.c"		∂
												"{CommFileTransferDir}FileTransferMgrExtensions.c"
	C {StdCOpts} -o "{targ}" "{CommFileTransferDir}FileTransferMgr.c"  


"{ObjDir}CommToolboxDispatcher.a.o"			ƒ	"{CommStartupDir}CommToolboxDispatcher.a"			∂
												"{AIncludes}Traps.a"								∂
												"{AIncludes}ToolUtils.a"							∂
												"{AIncludes}SysEqu.a"								∂
												"{IntAIncludes}SysPrivateEqu.a"						∂
												"{AIncludes}CommResources.a"						∂
												"{IntAIncludes}CommToolboxPriv.a"
	Asm {StdAOpts} -o "{targ}" "{CommStartupDir}CommToolboxDispatcher.a"


"{ObjDir}CRMBuiltInSerial.c.o"				ƒ	"{CommStartupDir}CRMBuiltInSerial.c"				∂
												"{CIncludes}Memory.h"								∂
												"{CIncludes}Resources.h"							∂
												"{CIncludes}ToolUtils.h"							∂
												"{CIncludes}OSUtils.h"								∂
												"{CIncludes}CommResources.h"						∂
												"{CIncludes}CRMSerialDevices.h"						∂
												"{IntCIncludes}CommToolboxPriv.h"					∂
												"{IntCIncludes}IconUtilsPriv.h"
	C {StdCOpts} -o "{targ}" "{CommStartupDir}CRMBuiltInSerial.c"  


"{ObjDir}CommToolboxPatches.c.o"			ƒ	"{CommStartupDir}CommToolboxPatches.c"				∂
												"{IntCIncludes}CommToolboxPriv.h"					∂
												"{CommResourceDir}CommResourceMgr.h"
	C {StdCOpts} -o "{Targ}" "{CommStartupDir}CommToolboxPatches.c" -i "{CommResourceDir}" 


"{ObjDir}CommToolboxPatches.a.o"			ƒ "{CommStartupDir}CommToolboxPatches.a"
	Asm {StdAOpts} -o "{targ}" "{CommStartupDir}CommToolboxPatches.a"
