#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Elliot make this change
#				  9/2/94	SuperMario ROM source dump (header preserved below)
#

#
#	File		PowerMgr.Make
#
#	Contains:	Makefile for the Power mager.
#
#	Written by:	Kurt Clark, Chas Spillar, and Tim Nichols
#
#	Copyright:	© 1992 by Apple Computer, Inc.  All rights reserved.
#
#	Change History (most recent first):
#
#	   <SM2>	  9/1/93	SKH		Added PwrControlsPatches.o
#	   <SM1>	 12/7/92	SWC		Updated list of dependencies.
#


"{ObjDir}PowerMgr.o"			ƒ	"{ObjDir}StandardEqu.d"							∂
									"{IntAIncludes}HardwarePrivateEqu.a"			∂
									"{IntAIncludes}UniversalEqu.a"					∂
									"{IntAIncludes}PowerPrivEqu.a"					∂
									"{AIncludes}AppleTalk.a"						∂
									"{AIncludes}Notification.a"						∂
									"{IntAIncludes}IopEqu.a"						∂
									"{IntAIncludes}EgretEqu.a"						∂
									"{IntAIncludes}AppleDeskBusPriv.a"				∂
									"{IntAIncludes}MMUEqu.a"						∂
									"{IntAIncludes}IOPrimitiveEqu.a"				∂
									"{AIncludes}LAPEqu.a"							∂
									"{IntAIncludes}DockingEqu.a"					∂
									"{AIncludes}Slots.a"							∂
									"{PowerMgrDir}PowerMgr.a"
	Asm {StdAOpts} -o "{Targ}" "{PowerMgrDir}PowerMgr.a"

"{ObjDir}PwrControlsPatches.o"			ƒ	"{ObjDir}StandardEqu.d"							∂
									"{IntAIncludes}HardwarePrivateEqu.a"			∂
									"{IntAIncludes}UniversalEqu.a"					∂
									"{IntAIncludes}PowerPrivEqu.a"					∂
									"{AIncludes}AppleTalk.a"						∂
									"{AIncludes}Notification.a"						∂
									"{IntAIncludes}IopEqu.a"						∂
									"{IntAIncludes}EgretEqu.a"						∂
									"{IntAIncludes}AppleDeskBusPriv.a"				∂
									"{IntAIncludes}MMUEqu.a"						∂
									"{IntAIncludes}IOPrimitiveEqu.a"				∂
									"{AIncludes}LAPEqu.a"							∂
									"{IntAIncludes}DockingEqu.a"					∂
									"{AIncludes}Slots.a"							∂
									"{PowerMgrDir}PwrControlsPatches.a"
	Asm {StdAOpts} -o "{Targ}" "{PowerMgrDir}PwrControlsPatches.a"

"{ObjDir}PowerMgrPatches.a.o"	ƒ	"{PowerMgrDir}PowerMgrPatches.a"
	Asm {StdAOpts} -o "{Targ}" "{PowerMgrDir}PowerMgrPatches.a"

