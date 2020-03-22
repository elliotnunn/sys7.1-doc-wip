#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Added build rules for some System resources.
#				  9/2/94	SuperMario ROM source dump (header preserved below)
#

#
#	File:		IconUtils.make
#
#	Contains:	Makefile for the Icon Utilities.
#
#	Written by:	Kurt Clark, Chas Spillar, and Tim Nichols
#
#	Copyright:	© 1992 by Apple Computer, Inc., all rights reserved.
#
#	Change History (most recent first):
#


IconUtilsObjs 	= 					"{ObjDir}IconUtils.a.o"			∂
									"{ObjDir}IconUtils.c.o"

"{LibDir}IconUtils.lib"			ƒ	{IconUtilsObjs}
	Lib {StdLibOpts} -o "{Targ}" {IconUtilsObjs}


"{ObjDir}IconUtils.a.o"			ƒ	"{IconUtilsDir}IconUtils.a"
	Asm {StdAOpts} -o "{Targ}" "{IconUtilsDir}IconUtils.a"



"{ObjDir}IconUtils.c.o"			ƒ	"{IconUtilsDir}IconUtils.c"
	C {StdCOpts} -o "{Targ}" "{IconUtilsDir}IconUtils.c"


# <Sys7.1> System resources
"{RsrcDir}IconUtils.rsrc"		ƒ	"{IconUtilsDir}IconUtils.r"
	Rez {StdROpts} -o "{Targ}" -i {IntCIncludes} "{IconUtilsDir}IconUtils.r"


# <Sys7.1> System resources
"{RsrcDir}GenericIcons.rsrc"	ƒ	"{IconUtilsDir}GenericIcons.r"
	Rez {StdROpts} -o "{Targ}" "{IconUtilsDir}GenericIcons.r"
