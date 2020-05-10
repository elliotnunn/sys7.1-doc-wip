#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Written from scratch to replace missing makefile
#

ProcessMgrDefs = ∂
					-d WRITENOW_FIX=1						∂
					-d MSWORKS_FIX=1						∂
					-d PsychicTV=0							∂

ProcessMgrDefsC = ∂
					-d SYS_SEGMENT_TYPE=∂'scod∂'			∂
					-d NULLPROC_SIGNATURE=∂'TWIT∂'			∂
					-d SYS_PUPPET_STRING_RSRC_TYPE=∂'TWIT∂'	∂
					-d SYS_PUPPET_STRING_RSRC_ID=-16458		∂
					-d DAH_SEGMENT_ZERO=-16479				∂
					-d DAH_SIZE_RESOURCE_ID=-16471			∂
					-d LOMEM_TAB_TYPE=∂'lmem∂'				∂
					-d COLOR_LOMEMTAB_ID=-16458				∂
					-d BW_LOMEMTAB_ID=-16459				∂

SchedulerObjs = ∂
					{ObjDir}Error.a.o						∂
					{ObjDir}OSDispatch.a.o					∂
					{ObjDir}ProcessMgrMisc.a.o				∂
					{ObjDir}Switch.a.o						∂
					{ObjDir}ZoomRect.a.o					∂
					{ObjDir}Startup.c.o						∂
					{ObjDir}AppleEventExtensions.c.o		∂
					{ObjDir}Data.c.o						∂
					{ObjDir}Debugger.c.o					∂
					{ObjDir}DeskMgrPatches.c.o				∂
					{ObjDir}Eppc.c.o						∂
					{ObjDir}Error.c.o						∂
					{ObjDir}EventMgrPatches.c.o				∂
					{ObjDir}FileSystem.c.o					∂
					{ObjDir}HList.c.o						∂
					{ObjDir}LayerMgrPatches.c.o				∂
					{ObjDir}Memory.c.o						∂
					{ObjDir}MemoryMgrPatches.c.o			∂
					{ObjDir}MemoryMgr24Patches.c.o			∂
					{ObjDir}MemoryMgr32Patches.c.o			∂
					{ObjDir}MenuMgrPatches.c.o				∂
					{ObjDir}OSDispatch.c.o					∂
					{ObjDir}PackageMgrPatches.c.o			∂
					{ObjDir}Patches.c.o						∂
					{ObjDir}Processes.c.o					∂
					{ObjDir}Puppet.c.o						∂
					{ObjDir}Queue.c.o						∂
					{ObjDir}ResourceMgrPatches.c.o			∂
					{ObjDir}Schedule.c.o					∂
					{ObjDir}ScrapCoercion.c.o				∂
					{ObjDir}SegmentLoaderPatches.c.o		∂
					{ObjDir}Sleep.c.o						∂
					{ObjDir}Switch.c.o						∂
					{ObjDir}Utilities.c.o					∂
					{ObjDir}WindowMgrPatches.c.o			∂
					{IfObjDir}interface.o					∂
					{Libraries}Runtime.o					∂

DAHandlerObjs = ∂
					{ObjDir}DAHandler.a.o					∂
					{ObjDir}DAHandler.c.o					∂
					{IfObjDir}interface.o					∂
					{Libraries}Runtime.o					∂

ProcessMgrINITObjs = ∂
					{ObjDir}ProcessMgrINIT.c.o				∂
					{IfObjDir}interface.o					∂


{ObjDir}ProcessMgrIncludes.D ƒ {ProcessMgrDir}MakePMIncludes.a
	Asm {StdEquAOpts} -o Dev:Null -d &DumpFile="'{ObjDir}ProcessMgrIncludes.D'" -i {IntAIncludes} {ProcessMgrDir}MakePMIncludes.a

{RsrcDir}Scheduler.rsrc ƒƒ {SchedulerObjs} {RsrcDir}CDG5SystemSegment
	# Omitting Link's -map arg yields a subtly different binary
	Link {SchedulerObjs} ∂
		-m main -map -o {Targ} ∂
		-ra           INIT=sysheap,purgeable,locked,preload # scod -16469/$BFAB ∂
		-ra           Main=sysheap,locked                   # scod -16468/$BFAC ∂
		-ra     zone_tools=sysheap,locked,preload           # scod -16467/$BFAD ∂
		-ra   zone32_tools=sysheap,locked,preload           # scod -16466/$BFAE ∂
		-ra   zone24_tools=sysheap,locked,preload           # scod -16465/$BFAF ∂
		-ra kernel_segment=sysheap,locked                   # scod -16464/$BFB0 ∂
		-ra        %A5Init=sysheap,purgeable,locked         # scod -16463/$BFB1 ∂
		-ra   eppc_segment=sysheap,locked                   # scod -16462/$BFB2 ∂
		-ra       Debugger=sysheap                          # scod -16461/$BFB3 ∂
		> {TextDir}Scheduler.map
	{RsrcDir}CDG5SystemSegment {Targ} -16470                # scod -16470/$BFAA (jt)

{RsrcDir}DAHandlerCode.rsrc ƒ {DAHandlerObjs} {RsrcDir}CDG5SystemSegment
	Link {DAHandlerObjs} ∂
		-map -o {Targ} ∂
		-ra           Main=sysheap,purgeable,locked         # scod -16478/$BFA2 ∂
		-ra           Init=sysheap,purgeable,locked         # scod -16477/$BFA3 ∂
		-ra        %A5Init=sysheap,purgeable,locked         # scod -16476/$BFA4 ∂
		> {TextDir}DAHandler.map
	{RsrcDir}CDG5SystemSegment {Targ} -16479                # scod -16479/$BFA1 (jt)

{BuildDir}ProcessMgrINIT ƒ {ProcessMgrDir}ProcessMgrINIT.r {ProcessMgrINITObjs} {RsrcDir}Scheduler.rsrc
	Set RealObjDir {ObjDir}; Set ObjDir {RsrcDir} # Hack to adapt to old build system
	Rez {StdROpts} {ProcessMgrDir}ProcessMgrINIT.r -o {Targ} # Includes the scods from Scheduler.rsrc
	Set ObjDir {RealObjDir}
	Link {ProcessMgrINITObjs} -rt INIT=128 -t INIT -m main -o {Targ}


{ObjDir}Error.a.o ƒ {ProcessMgrDir}Error.a
	Asm {ProcessMgrDefs} {StdAOpts} -o {Targ} {ProcessMgrDir}Error.a

{ObjDir}OSDispatch.a.o ƒ {ProcessMgrDir}OSDispatch.a
	Asm {ProcessMgrDefs} {StdAOpts} -o {Targ} {ProcessMgrDir}OSDispatch.a

{ObjDir}ProcessMgrMisc.a.o ƒ {ProcessMgrDir}ProcessMgrMisc.a
	Asm {ProcessMgrDefs} {StdAOpts} -o {Targ} {ProcessMgrDir}ProcessMgrMisc.a

{ObjDir}Switch.a.o ƒ {ProcessMgrDir}Switch.a
	Asm {ProcessMgrDefs} {StdAOpts} -o {Targ} {ProcessMgrDir}Switch.a

{ObjDir}ZoomRect.a.o ƒ {ProcessMgrDir}ZoomRect.a
	Asm {ProcessMgrDefs} {StdAOpts} -o {Targ} {ProcessMgrDir}ZoomRect.a

{ObjDir}AppleEventExtensions.c.o ƒ {ProcessMgrDir}AppleEventExtensions.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}AppleEventExtensions.c

{ObjDir}Data.c.o ƒ {ProcessMgrDir}Data.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}Data.c

{ObjDir}Debugger.c.o ƒ {ProcessMgrDir}Debugger.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}Debugger.c

{ObjDir}DeskMgrPatches.c.o ƒ {ProcessMgrDir}DeskMgrPatches.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}DeskMgrPatches.c

{ObjDir}Eppc.c.o ƒ {ProcessMgrDir}Eppc.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}Eppc.c

{ObjDir}Error.c.o ƒ {ProcessMgrDir}Error.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}Error.c

{ObjDir}EventMgrPatches.c.o ƒ {ProcessMgrDir}EventMgrPatches.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}EventMgrPatches.c

{ObjDir}FileSystem.c.o ƒ {ProcessMgrDir}FileSystem.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}FileSystem.c

{ObjDir}HList.c.o ƒ {ProcessMgrDir}HList.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}HList.c

{ObjDir}LayerMgrPatches.c.o ƒ {ProcessMgrDir}LayerMgrPatches.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}LayerMgrPatches.c

{ObjDir}Memory.c.o ƒ {ProcessMgrDir}Memory.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}Memory.c

{ObjDir}MemoryMgr24Patches.c.o ƒ {ProcessMgrDir}MemoryMgr24Patches.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}MemoryMgr24Patches.c

{ObjDir}MemoryMgr32Patches.c.o ƒ {ProcessMgrDir}MemoryMgr32Patches.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}MemoryMgr32Patches.c

{ObjDir}MemoryMgrPatches.c.o ƒ {ProcessMgrDir}MemoryMgrPatches.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}MemoryMgrPatches.c

{ObjDir}MenuMgrPatches.c.o ƒ {ProcessMgrDir}MenuMgrPatches.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}MenuMgrPatches.c

{ObjDir}OSDispatch.c.o ƒ {ProcessMgrDir}OSDispatch.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}OSDispatch.c

{ObjDir}PackageMgrPatches.c.o ƒ {ProcessMgrDir}PackageMgrPatches.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}PackageMgrPatches.c

{ObjDir}Patches.c.o ƒ {ProcessMgrDir}Patches.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}Patches.c

{ObjDir}Processes.c.o ƒ {ProcessMgrDir}Processes.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}Processes.c

{ObjDir}Puppet.c.o ƒ {ProcessMgrDir}Puppet.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}Puppet.c

{ObjDir}Queue.c.o ƒ {ProcessMgrDir}Queue.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}Queue.c

{ObjDir}ResourceMgrPatches.c.o ƒ {ProcessMgrDir}ResourceMgrPatches.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}ResourceMgrPatches.c

{ObjDir}Schedule.c.o ƒ {ProcessMgrDir}Schedule.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}Schedule.c

{ObjDir}ScrapCoercion.c.o ƒ {ProcessMgrDir}ScrapCoercion.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}ScrapCoercion.c

{ObjDir}SegmentLoaderPatches.c.o ƒ {ProcessMgrDir}SegmentLoaderPatches.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}SegmentLoaderPatches.c

{ObjDir}Sleep.c.o ƒ {ProcessMgrDir}Sleep.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}Sleep.c

{ObjDir}Startup.c.o ƒ {ProcessMgrDir}Startup.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}Startup.c

{ObjDir}Switch.c.o ƒ {ProcessMgrDir}Switch.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}Switch.c

{ObjDir}Utilities.c.o ƒ {ProcessMgrDir}Utilities.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}Utilities.c

{ObjDir}WindowMgrPatches.c.o ƒ {ProcessMgrDir}WindowMgrPatches.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}WindowMgrPatches.c

{ObjDir}ProcessMgrINIT.c.o ƒ {ProcessMgrDir}ProcessMgrINIT.c
	C {ProcessMgrDefs} {ProcessMgrDefsC} {StdCOpts} -o {Targ} {ProcessMgrDir}ProcessMgrINIT.c

{RsrcDir}Scheduler.rsrc ƒƒ {ProcessMgrDir}ProcessMgr.r
	Rez -a {StdROpts} -o {Targ} {ProcessMgrDir}ProcessMgr.r

{ObjDir}PuppetString.Default.a.o ƒ {ProcessMgrDir}PuppetString.Default.a
	Asm {StdAOpts} -o {Targ} {ProcessMgrDir}PuppetString.Default.a
{RsrcDir}Scheduler.rsrc ƒƒ {ObjDir}PuppetString.Default.a.o
	Link {ObjDir}PuppetString.Default.a.o -rt TWIT=-16458 -ra Main=sysheap,locked -o {Targ}

{ObjDir}PuppetString.MacDraw.a.o ƒ {ProcessMgrDir}PuppetString.MacDraw.a
	Asm {StdAOpts} -o {Targ} {ProcessMgrDir}PuppetString.MacDraw.a
{RsrcDir}Scheduler.rsrc ƒƒ {ObjDir}PuppetString.MacDraw.a.o
	Link {ObjDir}PuppetString.MacDraw.a.o -rt MDRW=-16458 -ra Main=sysheap,locked -o {Targ}

{ObjDir}PuppetString.MacPaint.a.o ƒ {ProcessMgrDir}PuppetString.MacPaint.a
	Asm {StdAOpts} -o {Targ} {ProcessMgrDir}PuppetString.MacPaint.a
{RsrcDir}Scheduler.rsrc ƒƒ {ObjDir}PuppetString.MacPaint.a.o
	Link {ObjDir}PuppetString.MacPaint.a.o -rt MPNT=-16458 -ra Main=sysheap,locked -o {Targ}

{ObjDir}PuppetString.MacWrite.a.o ƒ {ProcessMgrDir}PuppetString.MacWrite.a
	Asm {StdAOpts} -o {Targ} {ProcessMgrDir}PuppetString.MacWrite.a
{RsrcDir}Scheduler.rsrc ƒƒ {ObjDir}PuppetString.MacWrite.a.o
	Link {ObjDir}PuppetString.MacWrite.a.o -rt MACA=-16458 -ra Main=sysheap,locked -o {Targ}

{ObjDir}LomemTab.BlackWhite.a.o ƒ {ProcessMgrDir}LomemTab.BlackWhite.a
	Asm {StdAOpts} -o {Targ} {ProcessMgrDir}LomemTab.BlackWhite.a
{RsrcDir}Scheduler.rsrc ƒƒ {ObjDir}LomemTab.BlackWhite.a.o
	Link {ObjDir}LomemTab.BlackWhite.a.o -rt lmem=-16459 -ra Main=sysheap,locked -o {Targ}

{ObjDir}LomemTab.Color.a.o ƒ {ProcessMgrDir}LomemTab.Color.a
	Asm {StdAOpts} -o {Targ} {ProcessMgrDir}LomemTab.Color.a
{RsrcDir}Scheduler.rsrc ƒƒ {ObjDir}LomemTab.Color.a.o
	Link {ObjDir}LomemTab.Color.a.o -rt lmem=-16458 -ra Main=sysheap,locked -o {Targ}

{ObjDir}DAHandler.a.o ƒ {ProcessMgrDir}DAHandler.a
	Asm {StdAOpts} -o {Targ} {ProcessMgrDir}DAHandler.a

{ObjDir}DAHandler.c.o ƒ {ProcessMgrDir}DAHandler.c
	C {StdCOpts} -o {Targ} {ProcessMgrDir}DAHandler.c

{RsrcDir}DAHandler.rsrc ƒ {ProcessMgrDir}DAHandler.r {RsrcDir}DAHandlerCode.rsrc
	Set CodeResFile {RsrcDir}DAHandlerCode.rsrc; Export CodeResFile
	Rez {StdROpts} -o {Targ} {ProcessMgrDir}DAHandler.r

{RsrcDir}CDG5SystemSegment ƒ {MakeDir}CDG5SystemSegment.c
	C -o {ObjDir}CDG5SystemSegment.c.o {MakeDir}CDG5SystemSegment.c
	Link -t MPST -c 'MPS ' -o {Targ} {ObjDir}CDG5SystemSegment.c.o ∂
		{CLibraries}StdCLib.o {Libraries}Runtime.o {IfObjDir}Interface.o ∂
		-sg SingleSegWorkaround=Main,STDCLIB,STDIO,SANELIB,%A5Init,INTENV,SADEV
