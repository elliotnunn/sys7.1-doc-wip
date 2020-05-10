#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Elliot make this change
#				  9/2/94	SuperMario ROM source dump (header preserved below)
#

#
#	File:		ListMgr.make
#
#	Contains:	Makefile for List Manager.
#
#	Written by:	Kurt Clark, Chas Spillar, and Tim Nichols
#
#	Copyright:	© 1992 by Apple Computer, Inc.  All rights reserved.
#
#	Change History (most recent first):
#
#	   <SM4>	 12/2/92	kc		Added " || Exit 1" to commands with a double dependency.
#	   <SM3>	11/30/92	SWC		Changed PackMacs.a->Packages.a.
#	   <SM2>	11/20/92	RB		Changed SndLOpts to StdLOpts
#


"{RsrcDir}IconLDEF.a.rsrc"		ƒ	"{ObjDir}IconLDEF.a.o"
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 "{ObjDir}IconLDEF.a.o" || Exit 1


"{RsrcDir}ListMgrPACK.a.rsrc"	ƒ	"{ObjDir}ListMgrPACK.a.o"
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 "{ObjDir}ListMgrPACK.a.o" || Exit 1


"{RsrcDir}TextLDEF.a.rsrc"		ƒ	"{ObjDir}TextLDEF.a.o"
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 "{ObjDir}TextLDEF.a.o" || Exit 1


"{ObjDir}IconLDEF.a.o"			ƒ 	"{ListMgrDir}IconLDEF.a"						∂
									"{AIncludes}SysEqu.a"							∂
									"{IntAIncludes}SysPrivateEqu.a"					∂
									"{AIncludes}QuickDraw.a"						∂
									"{AIncludes}Traps.a"							∂
									"{AIncludes}Packages.a"							∂
									"{AIncludes}Script.a"							∂
									"{IntAIncludes}IconUtilsPriv.a"
	Asm {StdAOpts} -o "{Targ}" "{ListMgrDir}IconLDEF.a"


"{ObjDir}ListMgrPACK.a.o"		ƒ 	"{ObjDir}StandardEqu.d"							∂
									"{AIncludes}Packages.a"							∂
									"{ListMgrDir}ListMgrPriv.a"						∂
									"{ListMgrDir}ListMgrPACK.a"
	Asm {StdAOpts} -o "{Targ}" "{ListMgrDir}ListMgrPACK.a"


"{ObjDir}TextLDEF.a.o"			ƒ 	"{AIncludes}SysEqu.a"							∂
									"{IntAIncludes}SysPrivateEqu.a"					∂
									"{AIncludes}Traps.a"							∂
									"{AIncludes}QuickDraw.a"						∂
									"{AIncludes}Packages.a"							∂
									"{ListMgrDir}TextLDEF.a"
	Asm {StdAOpts} -o "{Targ}" "{ListMgrDir}TextLDEF.a"



