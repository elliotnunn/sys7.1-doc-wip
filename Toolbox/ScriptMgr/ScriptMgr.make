#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Added ScriptMgrPatch and ScriptMgrUtil to the lpch build. Recreated
#							several missing build rules.
#				  9/2/94	SuperMario ROM source dump (header preserved below)
#

#
#	File:		ScriptMgr.make
#
#	Contains:	Makefile to build the script manager library
#
#	Written by:	Kurt Clark, Chas Spillar, and Tim Nichols
#
#	Copyright:	© 1992 by Apple Computer, Inc.  All rights reserved.
#
#	Change History (most recent first):
#
#	   <SM2>	11/30/92	SWC		Changed PackMacs.a->Packages.a.


# These are postion depenedant

ScriptMgrObjects =					"{ObjDir}ScriptMgrHeader.a.o"					∂
									"{ObjDir}RomanUtil.a.o"							∂
									"{ObjDir}ScriptMgrMisc.a.o"						∂
									"{ObjDir}ScriptMgrPatch.a.o"	# <Sys7.1>		∂
									"{ObjDir}ScriptMgrUtil.a.o"		# <Sys7.1>		∂
									"{ObjDir}ScriptMgrUtilDate.a.o"					∂
									"{ObjDir}ScriptMgrUtilText.a.o"					∂
									"{ObjDir}ScriptMgrUtilNum.a.o"					∂
									"{ObjDir}ScriptMgrInit.a.o"						∂
									"{ObjDir}RomanNewJust.a.o"						∂
									"{ObjDir}ScriptMgrFindWord.c.o"					∂
									"{ObjDir}ScriptMgrTruncRepl.a.o"				∂
									"{ObjDir}ScriptMgrKbdMenu.a.o"					∂
									"{ObjDir}ScriptMgrSysMenuPatch.a.o"				∂
									"{ObjDir}DblByteCompat.a.o"						∂
									"{ObjDir}ScriptMgrExtensions.a.o"				∂
									"{ObjDir}ScriptMgrKeyGetSet.a.o"				∂
									"{ObjDir}ScriptMgrDispatch.a.o"					∂


"{LibDir}ScriptMgr.lib"	ƒ	{ScriptMgrObjects}
	Lib {StdLibOpts} -o "{Targ}" {ScriptMgrObjects}


"{ObjDir}ScriptMgrDispatch.a.o"		 ƒ	"{IntAIncludes}ScriptPriv.a" 				∂
										"{IntAIncludes}IntlUtilsPriv.a"				∂
										"{ObjDir}StandardEqu.d"						∂
										"{ScriptMgrDir}ScriptMgrDispatch.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}ScriptMgrDispatch.a"


"{ObjDir}ScriptMgrHeader.a.o"		ƒ	"{IntAIncludes}ScriptPriv.a"				∂
										"{ObjDir}StandardEqu.d"						∂
										"{ScriptMgrDir}ScriptMgrHeader.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}ScriptMgrHeader.a"


"{ObjDir}ScriptMgrInit.a.o"			ƒ	"{IntAIncludes}ScriptPriv.a" 				∂
										"{AIncludes}Packages.a"						∂
										"{ObjDir}StandardEqu.d"						∂
										"{ScriptMgrDir}ScriptMgrInit.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}ScriptMgrInit.a"


"{ObjDir}ScriptMgrExtensions.a.o" 	ƒ	"{ScriptMgrDir}ScriptMgrExtensions.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}ScriptMgrExtensions.a"


"{ObjDir}ScriptMgrKeyGetSet.a.o" 	ƒ	"{IntAIncludes}ScriptPriv.a" 				∂
										"{IntAIncludes}TSMPrivate.a"				∂
										"{IntAIncludes}MenuMgrPriv.a"				∂
										"{AIncludes}Components.a"					∂
										"{AIncludes}TextServices.a"					∂
										"{ObjDir}StandardEqu.d"						∂
										"{ScriptMgrDir}ScriptMgrKeyGetSet.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}ScriptMgrKeyGetSet.a"


"{ObjDir}ScriptMgrMisc.a.o"			ƒ	"{IntAIncludes}ScriptPriv.a"				∂
										"{ObjDir}StandardEqu.d"						∂
										"{AIncludes}ApplDeskBus.a"					∂
										"{ScriptMgrDir}ScriptMgrMisc.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}ScriptMgrMisc.a"


"{ObjDir}RomanUtil.a.o"				ƒ	"{IntAIncludes}ScriptPriv.a"				∂
										"{ObjDir}StandardEqu.d"						∂
										"{AIncludes}Packages.a"						∂
										"{ScriptMgrDir}RomanUtil.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}RomanUtil.a"


"{ObjDir}RomanNewJust.a.o"			ƒ	"{IntAIncludes}ScriptPriv.a"				∂
										"{ObjDir}StandardEqu.d"						∂
										"{IntAIncludes}ColorEqu.a"					∂
										"{AIncludes}FixMath.a"						∂
										"{ScriptMgrDir}RomanNewJust.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}RomanNewJust.a"


"{ObjDir}ScriptMgrUtilDate.a.o"		ƒ	"{IntAIncludes}ScriptPriv.a"				∂
										"{ObjDir}StandardEqu.d"						∂
										"{AIncludes}Packages.a"						∂
										"{AIncludes}SANEMacs.a"						∂
										"{AIncludes}FixMath.a"						∂
										"{ScriptMgrDir}ScriptMgrUtilDate.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}ScriptMgrUtilDate.a"


"{ObjDir}ScriptMgrUtilText.a.o"		ƒ	"{IntAIncludes}ScriptPriv.a"				∂
										"{ObjDir}StandardEqu.d"						∂
										"{ScriptMgrDir}ScriptMgrUtilText.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}ScriptMgrUtilText.a"


"{ObjDir}ScriptMgrTruncRepl.a.o"	ƒ	"{IntAIncludes}ScriptPriv.a"				∂
										"{ObjDir}StandardEqu.d"						∂
										"{AIncludes}Packages.a"						∂
										"{ScriptMgrDir}ScriptMgrTruncRepl.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}ScriptMgrTruncRepl.a"


"{ObjDir}ScriptMgrFindWord.c.o"		ƒ 	"{CIncludes}Types.h"						∂
										"{CIncludes}Script.h" 						∂
										"{IntCIncludes}ScriptPriv.h"				∂
										"{ScriptMgrDir}ScriptMgrFindWord.c"
	C {StdCOpts} -o "{Targ}" "{ScriptMgrDir}ScriptMgrFindWord.c"


"{ObjDir}ScriptMgrKbdMenu.a.o"		ƒ 	"{ObjDir}StandardEqu.d"						∂
										"{IntAIncludes}ScriptPriv.a"				∂
										"{IntAIncludes}IconUtilsPriv.a"				∂
										"{IntAIncludes}MenuMgrPriv.a"				∂
										"{AIncludes}Components.a"					∂
										"{AIncludes}TextServices.a"					∂
										"{AIncludes}Packages.a"						∂
										"{AIncludes}Icons.a"						∂
										"{ScriptMgrDir}ScriptMgrKbdMenu.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}ScriptMgrKbdMenu.a"


"{ObjDir}ScriptMgrSysMenuPatch.a.o"	ƒ 	"{ObjDir}StandardEqu.d"						∂
										"{IntAIncludes}ScriptPriv.a"				∂
										"{IntAIncludes}MFPrivate.a"					∂
										"{IntAIncludes}DialogsPriv.a"				∂
										"{IntAIncludes}MenuMgrPriv.a"				∂
										"{AIncludes}Components.a"					∂
										"{AIncludes}Icons.a"						∂
										"{ScriptMgrDir}ScriptMgrSysMenuPatch.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}ScriptMgrSysMenuPatch.a"


"{ObjDir}DblByteCompat.a.o"			ƒ	"{AIncludes}SysEqu.a"						∂
										"{AIncludes}Script.a"						∂
										"{IntAIncludes}ScriptPriv.a"				∂
										"{ScriptMgrDir}DblByteCompat.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}DblByteCompat.a"


"{ObjDir}ScriptMgrUtilNum.a.o"		ƒ	"{IntAIncludes}ScriptPriv.a" 				∂
										"{ObjDir}StandardEqu.d"						∂
										"{AIncludes}Packages.a"						∂
										"{AIncludes}SANEMacs.a"	∂
										"{ScriptMgrDir}ScriptMgrUtilNum.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}ScriptMgrUtilNum.a"




# <Sys7.1>
ScriptMgrExtObjects =				"{ObjDir}ScriptMgrExtHead.a.o"					∂
									"{ObjDir}ScriptMgrFindWord.c.o"					∂
									"{ObjDir}ScriptMgrTruncRepl.a.o"				∂
									"{ObjDir}RomanNewJust.a.o"						∂
									"{ObjDir}ScriptMgrKbdMenu.a.o"					∂
									"{ObjDir}ScriptMgrSysMenuPatch.a.o"				∂
									"{ObjDir}DblByteCompat.a.o"						∂
									"{ObjDir}ScriptMgrDispatch.a.o"					∂
									"{ObjDir}ScriptMgrKeyGetSet.a.o"				∂
									"{ObjDir}ScriptMgrExtensions.a.o"				∂
									"{ObjDir}ScriptMgrInit.a.o"						∂
									"{ObjDir}ScriptMgrExtTail.a.o"					∂


# <Sys7.1>
"{RsrcDir}International.rsrc"		ƒ	"{ScriptMgrDir}International.r"
	Rez {StdROpts} -o "{Targ}" "{ScriptMgrDir}International.r"


# <Sys7.1>
"{RsrcDir}ScriptMgrPatch.rsrc"		ƒ	"{LibDir}ScriptMgr.lib"
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 "{LibDir}ScriptMgr.lib"


# <Sys7.1>
"{RsrcDir}ScriptMgrExtensions.rsrc"	ƒ	{ScriptMgrExtObjects}
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 {ScriptMgrExtObjects}


# <Sys7.1>
"{RsrcDir}InternationalPACK.a.rsrc"	ƒ	"{ObjDir}InternationalPACK.a.o"
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 "{ObjDir}InternationalPACK.a.o"


# <Sys7.1>
"{RsrcDir}ScriptMgrROMPatch.rsrc"	ƒ	"{ObjDir}ScriptMgrROMPatch.a.o"
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 "{ObjDir}ScriptMgrROMPatch.a.o"


# <Sys7.1>
"{RsrcDir}RomanITL2.a.rsrc"			ƒ	"{ObjDir}RomanITL2.a.o"
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 "{ObjDir}RomanITL2.a.o"


# <Sys7.1>
"{RsrcDir}itl4Roman.a.rsrc"			ƒ	"{ObjDir}itl4Roman.a.o"
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 "{ObjDir}itl4Roman.a.o"


# <Sys7.1>
"{ObjDir}ScriptMgrPatch.a.o"		ƒ	"{ScriptMgrDir}ScriptMgrPatch.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}ScriptMgrPatch.a"


# <Sys7.1>
"{ObjDir}ScriptMgrUtil.a.o"		ƒ	"{ScriptMgrDir}ScriptMgrUtil.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}ScriptMgrUtil.a"


# <Sys7.1>
"{ObjDir}InternationalPACK.a.o"		ƒ	"{ScriptMgrDir}InternationalPACK.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}InternationalPACK.a"


# <Sys7.1>
"{ObjDir}ScriptMgrROMPatch.a.o"		ƒ	"{ScriptMgrDir}ScriptMgrROMPatch.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}ScriptMgrROMPatch.a"


# <Sys7.1>
"{ObjDir}RomanITL2.a.o"				ƒ	"{ScriptMgrDir}RomanITL2.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}RomanITL2.a"


# <Sys7.1>
"{ObjDir}itl4Roman.a.o"				ƒ	"{ScriptMgrDir}itl4Roman.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}itl4Roman.a"


# <Sys7.1>
"{ObjDir}ScriptMgrExtHead.a.o"		ƒ	"{ScriptMgrDir}ScriptMgrExtHead.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}ScriptMgrExtHead.a"


# <Sys7.1>
"{ObjDir}ScriptMgrExtTail.a.o"		ƒ	"{ScriptMgrDir}ScriptMgrExtTail.a"
	Asm {StdAOpts} -o "{Targ}" "{ScriptMgrDir}ScriptMgrExtTail.a"
