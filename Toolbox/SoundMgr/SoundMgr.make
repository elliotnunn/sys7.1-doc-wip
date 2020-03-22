#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Written from scratch
#

SoundMgrObjs 	=					"{ObjDir}SoundMgrPatch.a.o"						∂
									"{ObjDir}SysBeepPatch.a.o"						∂
									"{ObjDir}Tables.3.a.o"							∂


"{LibDir}SoundMgr.lib"			ƒ	{SoundMgrObjs}
	Lib {StdLibOpts} -o "{Targ}" {SoundMgrObjs} -rn _R258C_OTHERNAME=_R258C


"{ObjDir}SoundMgrPatch.a.o"		ƒ	"{SoundMgrDir}SoundMgrPatch.a"			
	Asm {StdAOpts} -o "{Targ}" "{SoundMgrDir}SoundMgrPatch.a"


"{ObjDir}SysBeepPatch.a.o"		ƒ	"{Sources}Patches:SysBeepPatch.a"			
	Asm {StdAOpts} -o "{Targ}" "{Sources}Patches:SysBeepPatch.a"


"{ObjDir}Tables.3.a.o"			ƒ	"{SoundMgrDir}Tables.3.a"			
	Asm {StdAOpts} -o "{Targ}" "{SoundMgrDir}Tables.3.a"
