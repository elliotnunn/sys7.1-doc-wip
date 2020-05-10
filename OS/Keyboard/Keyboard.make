#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Elliot make this change
#				  9/2/94	SuperMario ROM source dump (header preserved below)
#

#
#	File:		Keyboard.make
#
#	Contains:	Makefile for the Keyboard resources.
#
#	Written by:	Kurt Clark, Chas Spillar, and Tim Nichols
#
#	Copyright:	© 1992 by Apple Computer, Inc., all rights reserved.
#
#	Change History (most recent first):
#

"{RsrcDir}Kbd.rsrc"				ƒ	"{KeyboardDir}Kbd.r"
	Rez {StdROpts} -o "{Targ}" "{KeyboardDir}Kbd.r"

"{ObjDir}KbdInstall.a.o"		ƒ	"{KeyboardDir}KbdInstall.a"
	Asm {StdAOpts} -o "{Targ}" "{KeyboardDir}KbdInstall.a"

"{RsrcDir}KbdInstall.a.rsrc"	ƒ	"{ObjDir}KbdInstall.a.o"
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 "{ObjDir}KbdInstall.a.o"
