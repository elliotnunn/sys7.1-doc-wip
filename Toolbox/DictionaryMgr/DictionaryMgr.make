#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Elliot make this change
#				  9/2/94	SuperMario ROM source dump (header preserved below)
#

#
#	File:		DictionaryMgr.make
#
#	Contains:	Makefile for the Dictionary Manager Package.
#
#	Written by:	Chas Spillar
#
#	Copyright:	© 1992 by Apple Computer, Inc.  All rights reserved.
#
#	Change History (most recent first):
#
#	   <SM2>	12/23/92	kc		Change {DictionaryMgr} to {DictionaryMgrDir}.
#	   <SM1>	12/14/92	CSS		Added to Project.
#
#______________________________________________________________________________________________
#
DictMgrPackObjs					= 	"{ObjDir}DictionaryMgr.a.o"						∂
									"{ObjDir}Dictionary.c.o"						∂
									"{ObjDir}BTreeGlue.a.o"							∂
									"{IfObjDir}Interface.o"
									
"{RsrcDir}DictionaryMgr.a.rsrc"		ƒ	{DictMgrPackObjs}
	Link -o {Targ} {DictMgrPackObjs} {StdLOpts} -rt dimg=0 -m DictionaryMgrPackEntry


"{ObjDir}DictionaryMgr.a.o"		ƒ	"{ObjDir}StandardEqu.d"							∂
									"{IntAIncludes}DispatchHelperPriv.a"			∂
									"{DictionaryMgrDir}DictionaryMgr.a"
	Asm {StdAOpts} -o "{Targ}" "{DictionaryMgrDir}DictionaryMgr.a"
	
	
{ObjDir}Dictionary.c.o			ƒ	"{DictionaryMgrDir}Dictionary.c"
	C {StdCOpts} -o "{Targ}" {DictionaryMgrDir}Dictionary.c
	
	

