#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Elliot make this change
#				  9/2/94	SuperMario ROM source dump (header preserved below)
#

#
#	File:		ADBMgr.make
#
#	Contains:	Makefile for ADB.
#
#	Written by:	Kurt Clark, Chas Spillar, and Tim Nichols
#
#	Copyright:	© 1992 by Apple Computer, Inc., all rights reserved.
#
#	Change History (most recent first):
#

"{LibDir}ADBMgr.lib"			ƒ	"{ObjDir}StandardEqu.d"							∂
									"{AIncludes}HardwareEqu.a"						∂
									"{IntAIncludes}IOPEqu.a"						∂
									"{IntAIncludes}EgretEqu.a"						∂
									"{IntAIncludes}AppleDeskBusPriv.a"				∂
									"{IntAIncludes}ScriptPriv.a"					∂
									"{IntAIncludes}UniversalEqu.a"					∂
									"{ADBDir}ADBMgr.a"
	Asm {StdAOpts} -o "{Targ}" "{ADBDir}ADBMgr.a"


"{ObjDir}ADBMgrPatch.a.o"		ƒ	"{ADBDir}ADBMgrPatch.a"
	Asm {StdAOpts} -o "{Targ}" "{ADBDir}ADBMgrPatch.a"
