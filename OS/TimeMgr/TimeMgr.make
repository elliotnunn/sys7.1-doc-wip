#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Elliot make this change
#				  9/2/94	SuperMario ROM source dump (header preserved below)
#

#
#	File:		TimeMgr.make
#
#	Contains:	Makefile for the Time Manager.
#
#	Written by:	Kurt Clark, Chas Spillar, and Tim Nichols
#
#	Copyright:	© 1992 by Apple Computer, Inc., all rights reserved.
#
#	Change History (most recent first):
#

TimeMgrObjs	=					"{ObjDir}TimeMgrPatch.a.o"							∂
								"{ObjDir}TimeMgr.a.o"


"{LibDir}TimeMgr.lib"			ƒ	{TimeMgrObjs}
	Lib {StdLibOpts} -o "{Targ}" {TimeMgrObjs}


"{ObjDir}TimeMgr.a.o"			ƒ	"{ObjDir}StandardEqu.d"							∂
									"{IntAIncludes}HardwarePrivateEqu.a"			∂
									"{TimeMgrDir}TimeMgr.a"
	Asm {StdAOpts} -o "{Targ}" "{TimeMgrDir}TimeMgr.a"


"{ObjDir}TimeMgrPatch.a.o"		ƒ	"{TimeMgrDir}TimeMgrPatch.a"
	Asm {StdAOpts} -o "{Targ}" "{TimeMgrDir}TimeMgrPatch.a"

