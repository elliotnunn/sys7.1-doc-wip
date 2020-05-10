#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Elliot make this change
#				  9/2/94	SuperMario ROM source dump (header preserved below)
#

#
#	File		SlotMgr.make
#
#	Contains:	Makefile for SlotMgr.
#
#	Written by:	Kurt Clark, Chas Spillar, and Tim Nichols
#
#	Copyright:	© 1992-1993 by Apple Computer, Inc., all rights reserved.
#
#	Change History (most recent first):
#
#	   <SM2>	  9/7/93	pdw		Fixed dependencies.


SlotMgrObjs						=	"{ObjDir}SlotMgrPatch.a.o"						∂
									"{ObjDir}SlotInterrupts.a.o"					∂
									"{ObjDir}SlotMgrInit.a.o"						∂
									"{ObjDir}SlotMgr.a.o"

"{LibDir}SlotMgr.lib"			ƒ	{SlotMgrObjs}
	Lib {StdLibOpts} -o "{Targ}" {SlotMgrObjs}




"{ObjDir}SlotInterrupts.a.o"	ƒ	"{ObjDir}StandardEqu.d"							∂
									"{IntAIncludes}HardwarePrivateEqu.a"			∂
									"{IntAIncludes}SlotMgrEqu.a"					∂
									"{AIncludes}Slots.a"							∂
									"{IntAIncludes}UniversalEqu.a"					∂
									"{SlotMgrDir}SlotInterrupts.a"
	Asm {StdAOpts} -o "{Targ}" "{SlotMgrDir}SlotInterrupts.a"


"{ObjDir}SlotMgrInit.a.o"		ƒ	"{ObjDir}StandardEqu.d"							∂
									"{IntAIncludes}HardwarePrivateEqu.a"			∂
									"{AIncludes}RomEqu.a"							∂
									"{IntAIncludes}UniversalEqu.a"					∂
									"{IntAIncludes}SlotMgrEqu.a"					∂
									"{AIncludes}Slots.a"							∂
									"{IntAIncludes}ComVideoEqu.a"					∂
									"{SlotMgrDir}SlotMgrInit.a"
	Asm {StdAOpts} -o "{Targ}" "{SlotMgrDir}SlotMgrInit.a"


"{ObjDir}SlotMgr.a.o"			ƒ	"{ObjDir}StandardEqu.d"							∂
									"{IntAIncludes}HardwarePrivateEqu.a"			∂
									"{AIncludes}RomEqu.a"							∂
									"{IntAIncludes}UniversalEqu.a"					∂
									"{IntAIncludes}SlotMgrEqu.a"					∂
									"{AIncludes}Slots.a"							∂
									"{IntAIncludes}ComVideoEqu.a"					∂
									"{SlotMgrDir}SlotMgr.a"
	Asm {StdAOpts} -o "{Targ}" "{SlotMgrDir}SlotMgr.a"


"{ObjDir}SlotMgrPatch.a.o"		ƒ	"{SlotMgrDir}SlotMgrPatch.a"
	Asm {StdAOpts} -o "{Targ}" "{SlotMgrDir}SlotMgrPatch.a"

