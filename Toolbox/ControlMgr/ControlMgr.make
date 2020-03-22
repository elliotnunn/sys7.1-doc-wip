#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Added ControlMgrPatches.a and removed ControlMgr.a from the lpch build.
#							Added several other new rules for System file defprocs.
#				  9/2/94	SuperMario ROM source dump (header preserved below)
#

#
#	File:		ControlMgr.make
#
#	Contains:	Makefile for the Control Manager.
#
#	Written by:	Kurt Clark, Chas Spillar, and Tim Nichols
#
#	Copyright:	© 1992 by Apple Computer, Inc., all rights reserved.
#
#	Change History (most recent first):
#
#	   <SM2>	 12/2/92	kc		Added " || Exit 1" to commands with a double dependency.


ControlMgrObjs		=			"{ObjDir}ControlMgrPatches.a.o"			# <Sys7.1>	∂
								"{ObjDir}ControlMgrExtensions.a.o"	


"{RsrcDir}ControlMgr.rsrc"			ƒƒ	"{ObjDir}ButtonCDEF.a.o"					
	Link {StdLOpts} {StdAlign} -rt CDEF=0 -o "{Targ}" "{ObjDir}ButtonCDEF.a.o" || Exit 1


"{RsrcDir}ControlMgr.rsrc"			ƒƒ	"{ObjDir}ScrollBarCDEF.a.o"					
	Link {StdLOpts} {StdAlign} -rt CDEF=1 -o "{Targ}" "{ObjDir}ScrollBarCDEF.a.o" || Exit 1


"{LibDir}ControlMgr.lib"			ƒ 	{ControlMgrObjs}
	Lib {StdLibOpts} -o "{Targ}"	{ControlMgrObjs}


"{ObjDir}ControlMgr.a.o"			ƒ	"{ObjDir}StandardEqu.d"						∂
										"{IntAIncludes}LinkedPatchMacros.a"			∂
										"{IntAIncludes}ControlPriv.a"				∂
										"{ControlMgrDir}ControlMgr.a"
	Asm {StdAOpts} -o "{Targ}" "{ControlMgrDir}ControlMgr.a"


"{ObjDir}ControlMgrExtensions.a.o"	ƒ	"{ObjDir}StandardEqu.d"						∂
										"{IntAIncludes}LinkedPatchMacros.a"			∂
										"{IntAIncludes}ControlPriv.a"				∂
										"{ControlMgrDir}ControlMgrExtensions.a"
	Asm {StdAOpts} -o "{Targ}" "{ControlMgrDir}ControlMgrExtensions.a"


"{ObjDir}ScrollBarCDEF.a.o"		ƒ	"{ObjDir}StandardEqu.d"							∂
									"{IntAIncludes}ColorEqu.a"						∂
									"{ControlMgrDir}ScrollBarCDEF.a"
	Asm {StdAOpts} -o "{Targ}" "{ControlMgrDir}ScrollBarCDEF.a"


"{ObjDir}ButtonCDEF.a.o"		ƒ	"{ObjDir}StandardEqu.d"							∂
									"{IntAIncludes}ColorEqu.a"						∂
									"{ControlMgrDir}ButtonCDEF.a"
	Asm {StdAOpts} -o "{Targ}" "{ControlMgrDir}ButtonCDEF.a"

# <Sys7.1> from here onwards...
"{ObjDir}ControlMgrPatches.a.o"	ƒ	"{ControlMgrDir}ControlMgrPatches.a"
	Asm {StdAOpts} -o "{Targ}" "{ControlMgrDir}ControlMgrPatches.a"

"{ObjDir}PopupCDEFMDEF.a.o"		ƒ	"{ControlMgrDir}PopupCDEFMDEF.a"
	Asm {StdAOpts} -o "{Targ}" "{ControlMgrDir}PopupCDEFMDEF.a"

"{RsrcDir}PopupCDEFMDEF.a.rsrc"	ƒ	"{ObjDir}PopupCDEFMDEF.a.o"
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o "{Targ}" "{ObjDir}PopupCDEFMDEF.a.o"

"{RsrcDir}ButtonCDEF.a.rsrc"	ƒ	"{ObjDir}ButtonCDEF.a.o"
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o "{Targ}" "{ObjDir}ButtonCDEF.a.o"

"{RsrcDir}ScrollBarCDEF.a.rsrc"	ƒ	"{ObjDir}ScrollBarCDEF.a.o"
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o "{Targ}" "{ObjDir}ScrollBarCDEF.a.o"

"{ObjDir}PictButtonCDEF.a.o"	ƒ	 "{ControlMgrDir}PictButtonCDEF.a"
	Asm {StdAOpts} -o "{Targ}" "{ControlMgrDir}PictButtonCDEF.a"
"{RsrcDir}PictButtonCDEF.a.rsrc"ƒ	"{ObjDir}PictButtonCDEF.a.o"
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o "{Targ}" "{ObjDir}PictButtonCDEF.a.o"

"{RsrcDir}PopupTriangle.r.rsrc"	ƒ	"{ControlMgrDir}PopupTriangle.r"
	Rez {StdROpts} -i {IntCIncludes} -o "{Targ}" "{ControlMgrDir}PopupTriangle.r"

PopupCDEFObjs		=			"{ObjDir}PopupCDEF.a.o"								∂
								"{ObjDir}PopupCDEF.c.o"								∂
								"{IfObjDir}Interface.o"

"{ObjDir}PopupCDEF.a.o"			ƒ	"{ControlMgrDir}PopupCDEF.a"
	Asm {StdAOpts} -o "{Targ}" "{ControlMgrDir}PopupCDEF.a"

"{ObjDir}PopupCDEF.c.o"			ƒ	"{ControlMgrDir}PopupCDEF.c"
	C {StdCOpts} -o "{Targ}" "{ControlMgrDir}PopupCDEF.c"

"{RsrcDir}PopupCDEF.c.rsrc"		ƒ	{PopupCDEFObjs}
	Link {StdLOpts} {StdAlign} -m POPUP -rt RSRC=0 -o "{Targ}" {PopupCDEFObjs}
