#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Added NotificationMgrPatch.a to the lpch build lib. Recreated the build
#							rule for PatchROMAlarmNotify.a, which also goes in the lpch build, but
#							separately.
#				  9/2/94	SuperMario ROM source dump (header preserved below)
#

#
#	File:		NotificationMgr.make
#
#	Contains:	Makefile for the Notification Manager.
#
#	Written by:	Kurt Clark, Chas Spillar, and Tim Nichols
#
#	Copyright:	© 1992 by Apple Computer, Inc., all rights reserved.
#
#	Change History (most recent first):
#


NotificationMgrObjs 	=			"{ObjDir}NotificationMgrPatch.a.o"	# <Sys7.1>	∂
									"{ObjDir}NotificationMgr.c.o"					∂
									"{ObjDir}NotificationMgr.a.o"					∂
									"{ObjDir}SetProcessorLevel.a.o"


"{LibDir}NotificationMgr.lib"	ƒ	{NotificationMgrObjs}
	Lib {StdLibOpts} -o "{Targ}" {NotificationMgrObjs}



"{ObjDir}NotificationMgr.c.o"	ƒ	"{cincludes}Notification.h"						∂
									"{NotificationDir}kernel.h"						∂
									"{NotificationDir}task.h"						∂
									"{CIncludes}Types.h"							∂
									"{CIncludes}Devices.h"							∂
									"{CIncludes}Memory.h"							∂
									"{CIncludes}OSUtils.h"							∂
									"{CIncludes}Events.h"							∂
									"{CIncludes}Resources.h"						∂
									"{CIncludes}Controls.h"							∂
									"{CIncludes}Dialogs.h"							∂
									"{CIncludes}Menus.h"							∂
									"{CIncludes}Sound.h"							∂
									"{NotificationDir}NotificationMgr.c"
	C {StdCOpts} -o "{Targ}" "{NotificationDir}NotificationMgr.c"


"{ObjDir}NotificationMgr.a.o"	ƒ	"{ObjDir}StandardEqu.d"							∂
									"{IntAIncludes}UniversalEqu.a"					∂
									"{AIncludes}HardwareEqu.a"						∂
									"{NotificationDir}NotificationMgr.a"			
	Asm {StdAOpts} -o "{Targ}" "{NotificationDir}NotificationMgr.a"


"{ObjDir}SetProcessorLevel.a.o"	ƒ "{NotificationDir}SetProcessorLevel.a"
	Asm {StdAOpts} -o "{Targ}" "{NotificationDir}SetProcessorLevel.a"


# <Sys7.1>
"{ObjDir}NotificationMgrPatch.a.o"		ƒ	"{ObjDir}StandardEqu.d"					∂
											"{IntAIncludes}LinkedPatchMacros.a"		∂
											"{NotificationDir}NotificationMgrPatch.a"
	Asm {StdAOpts} -o {Targ} "{NotificationDir}NotificationMgrPatch.a"


# <Sys7.1>
"{ObjDir}PatchROMAlarmNotify.a.o"	ƒ "{NotificationDir}PatchROMAlarmNotify.a"
	Asm {StdAOpts} -o "{Targ}" "{NotificationDir}PatchROMAlarmNotify.a"

