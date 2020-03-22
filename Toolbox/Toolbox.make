#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Written from scratch to replace missing makefile
#

AliasMgrDir 				= "{ToolBoxDir}AliasMgr:"
AppleEventDir				= "{ToolBoxDir}AppleEventMgr:"
ColorPickerDir				= "{ToolBoxDir}ColorPicker:"
CommToolboxDir				= "{ToolBoxDir}CommToolbox:"
ComponentMgrDir 			= "{ToolBoxDir}ComponentMgr:"
ControlMgrDir 				= "{ToolBoxDir}ControlMgr:"
DataAccessDir 				= "{ToolBoxDir}DataAccessMgr:"
DeskMgrDir					= "{ToolBoxDir}DeskMgr:"
DialogDir 					= "{ToolBoxDir}DialogMgr:"
DictionaryMgrDir			= "{ToolBoxDir}DictionaryMgr:"
DiskInitDir 				= "{ToolBoxDir}DiskInit:"
DisplayMgrDir 				= "{ToolBoxDir}DisplayMgr:"
EditionMgrDir				= "{ToolBoxDir}DataPubsMgr:"
ExpansionBusMgrDir 			= "{ToolBoxDir}ExpansionBusMgr:"
FontMgrDir 					= "{ToolBoxDir}FontMgr:"
GetMgrDir					= "{ToolBoxDir}GetMgr:"
HelpMgrDir					= "{ToolBoxDir}HelpMgr:"
IconUtilsDir				= "{ToolBoxDir}IconUtils:"
InSaneDir 					= "{ToolBoxDir}InSANE:"
ListMgrDir					= "{ToolBoxDir}ListMgr:"
MenuMgrDir 					= "{ToolBoxDir}MenuMgr:"
MungerDir 					= "{ToolBoxDir}Munger:"
NotificationDir 			= "{ToolBoxDir}NotificationMgr:"
PrintingDir					= "{ToolBoxDir}Printing:"
ResourceMgrDir 				= "{ToolBoxDir}ResourceMgr:"
SANEDir 					= "{ToolBoxDir}SANE:"
ScrapMgrDir					= "{ToolBoxDir}ScrapMgr:"
ScriptMgrDir 				= "{ToolBoxDir}ScriptMgr:"
SegmentLoaderDir 			= "{ToolBoxDir}SegmentLoader:"
ShutDownMgrDir 				= "{ToolBoxDir}ShutDownMgr:"
SoundMgrDir 				= "{ToolBoxDir}SoundMgr:"
StandardFileDir 			= "{ToolBoxDir}StandardFile:"
TextEditDir					= "{ToolBoxDir}TextEdit:"
TextServicesDir				= "{ToolBoxDir}TextServicesMgr:"
ToolboxEventDir 			= "{ToolBoxDir}ToolboxEventMgr:"
WindowMgrDir 				= "{ToolBoxDir}WindowMgr:"



#include "{AliasMgrDir}AliasMgr.make"
#include "{AppleEventDir}AppleEventMgr.make"
#include "{ColorPickerDir}ColorPicker.make"
#include "{CommToolboxDir}CommToolbox.make"
#include "{ComponentMgrDir}ComponentMgr.make"
#include "{ControlMgrDir}ControlMgr.make"
#include "{DataAccessDir}DataAccessMgr.make"
#include "{DialogDir}DialogMgr.make"
#include "{DictionaryMgrDir}DictionaryMgr.make"
#include "{DiskInitDir}DiskInit.make"
#include "{DisplayMgrDir}DisplayMgr.make"
#include "{EditionMgrDir}EditionMgr.make"
#include "{ExpansionBusMgrDir}ExpansionBusMgr.make"
#include "{FontMgrDir}FontMgr.make"
#include "{HelpMgrDir}HelpMgr.make"
#include "{IconUtilsDir}IconUtils.make"
#include "{InSaneDir}InSane.make"
#include "{ListMgrDir}ListMgr.make"
#include "{MenuMgrDir}MenuMgr.make"
#include "{NotificationDir}NotificationMgr.make"
#include "{ResourceMgrDir}ResourceMgr.make"
#include "{SANEDir}SANE.make"
#include "{ScriptMgrDir}ScriptMgr.make"
#include "{SoundMgrDir}SoundMgr.make"
#include "{StandardFileDir}StandardFile.make"
#include "{TextServicesDir}TextServicesMgr.make"
#include "{ToolboxEventDir}ToolboxEventMgr.make"
#include "{WindowMgrDir}WindowMgr.make"



"{ObjDir}DeskMgr.a.o"				ƒ	"{DeskMgrDir}DeskMgr.a"
	Asm {StdAOpts} -o "{Targ}" "{DeskMgrDir}DeskMgr.a"

"{ObjDir}DeskMgrPatches.a.o"		ƒ	"{DeskMgrDir}DeskMgrPatches.a"
	Asm {StdAOpts} -o "{Targ}" "{DeskMgrDir}DeskMgrPatches.a"



"{ObjDir}GetMgr.a.o"				ƒ	"{GetMgrDir}GetMgr.a"
	Asm {StdAOpts} -o "{Targ}" "{GetMgrDir}GetMgr.a"

"{ObjDir}GetMgrPatches.a.o"			ƒ	"{GetMgrDir}GetMgrPatches.a"
	Asm {StdAOpts} -o "{Targ}" "{GetMgrDir}GetMgrPatches.a"



"{ObjDir}Munger.a.o"				ƒ	"{MungerDir}Munger.a"
	Asm {StdAOpts} -o "{Targ}" "{MungerDir}Munger.a"

"{ObjDir}MungerPatches.a.o"			ƒ	"{MungerDir}MungerPatches.a"
	Asm {StdAOpts} -o "{Targ}" "{MungerDir}MungerPatches.a"



"{ObjDir}PackageMgr.a.o"			ƒ	"{ToolboxDir}PackageMgr.a"
	Asm {StdAOpts} -o "{Targ}" "{ToolboxDir}PackageMgr.a"



"{ObjDir}PrintGlue.a.o"				ƒ	"{PrintingDir}PrintGlue.a"
	Asm {StdAOpts} -o "{Targ}" "{PrintingDir}PrintGlue.a"

"{ObjDir}PrintDriver.a.o"			ƒ	"{PrintingDir}PrintDriver.a"
	Asm {StdAOpts} -o "{Targ}" "{PrintingDir}PrintDriver.a"

"{RsrcDir}PrintDriver.a.rsrc"		ƒ	"{ObjDir}PrintDriver.a.o"
	Link {StdLOpts} {StdAlign} -o "{Targ}" -rt RSRC=0 "{ObjDir}PrintDriver.a.o"



"{ObjDir}ScrapMgr.a.o"				ƒ	"{ScrapMgrDir}ScrapMgr.a"
	Asm {StdAOpts} -o "{Targ}" "{ScrapMgrDir}ScrapMgr.a"

"{ObjDir}ScrapMgrPatches.a.o"		ƒ	"{ScrapMgrDir}ScrapMgrPatches.a"
	Asm {StdAOpts} -o "{Targ}" "{ScrapMgrDir}ScrapMgrPatches.a"



"{ObjDir}SegmentLoader.a.o"			ƒ	"{SegmentLoaderDir}SegmentLoader.a"
	Asm {StdAOpts} -o "{Targ}" "{SegmentLoaderDir}SegmentLoader.a"

"{ObjDir}SegmentLoaderPatches.a.o"	ƒ	"{SegmentLoaderDir}SegmentLoaderPatches.a"
	Asm {StdAOpts} -o "{Targ}" "{SegmentLoaderDir}SegmentLoaderPatches.a"



"{ObjDir}SexyDate.a.o"				ƒ	"{ToolboxDir}SexyDate.a"
	Asm {StdAOpts} -o "{Targ}" "{ToolboxDir}SexyDate.a"



"{ObjDir}ShutDownMgr.a.o"			ƒ	"{ShutDownMgrDir}ShutDownMgr.a"
	Asm {StdAOpts} -o "{Targ}" "{ShutDownMgrDir}ShutDownMgr.a"



"{ObjDir}TextEdit.a.o"				ƒ	"{TextEditDir}TextEdit.a" "{TextEditDir}IncludeTextEdit.a"
	Asm {StdAOpts} -o "{Targ}" "{TextEditDir}IncludeTextEdit.a"

"{ObjDir}TextEditPatch.a.o"			ƒ	"{TextEditDir}TextEditPatch.a"
	Asm {StdAOpts} -o "{Targ}" "{TextEditDir}TextEditPatch.a"

"{ObjDir}TextEditPatchIIciROM.a.o"	ƒ	"{TextEditDir}TextEditPatchIIciROM.a"
	Asm {StdAOpts} -o "{Targ}" "{TextEditDir}TextEditPatchIIciROM.a"
