#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Written from scratch to replace missing makefile
#

SysVersMajor	=	7			# 0-99
SysVersMinor	=	1			# 0-9
SysVersBugfix	=	0			# 0-9
SysVersStage	=	final		# develop/alpha/beta/final=release (only first letter counted)
SysVersPre		=	0			# 0-255
LangInt			=	0			# 0=US

# Built-in Video Monitors (cdev) Extension for IIci and IIsi
VidExtVers		=	1.0.1

# Directory variables for source code (trailing : essential)
BuildDir		=	{Sources}BuildResults:System:
ImageDir		=	{BuildDir}Image:
RsrcDir			=	{BuildDir}Rsrc:
LibDir			=	{BuildDir}Lib:
ObjDir			=	{BuildDir}Obj:
TextDir			=	{BuildDir}Text:
IfObjDir		=	{ObjDir}Interface:
MakeDir			=	{Sources}Make:
ResourceDir		=	{Sources}Resources:
DeclDir			=	{Sources}DeclData:
ToolDir			=	{Sources}Tools:
ToolSrcDir		=	{Sources}Tools:ToolSource:
MiscDir			=	{Sources}Misc:
TidbitsDir		=	{Sources}Tidbits:
DriverDir		=	{Sources}Drivers:
PatchDir		=	{Sources}Patches:
LinkPatchDir	=	{Sources}LinkedPatches:
ProcessMgrDir	=	{Sources}ProcessMgr:

# Directory variables for Asm/C/Pascal/Rez headers
AIncludes		=	{Sources}Interfaces:AIncludes:
CIncludes		=	{Sources}Interfaces:CIncludes:
PInterfaces		=	{Sources}Interfaces:PInterfaces:
RIncludes		=	{Sources}Interfaces:RIncludes:
IntAIncludes	=	{Sources}Internal:Asm:
IntCIncludes	=	{Sources}Internal:C:
IntPInterfaces	=	{Sources}Internal:Pascal:
IntRIncludes	=	{Sources}Internal:Rez:
Libraries		=	{Sources}Libs:Libraries:
CLibraries		=	{Sources}Libs:CLibraries:
PLibraries		=	{Sources}Libs:PLibraries:

# Resource and Rez files included by Sys.r into the System file
SystemResourceFiles = ∂
					{MiscDir}APTK57.rsrc					∂
					{MiscDir}SystemSounds.r					∂
					{MiscDir}VM.rsrc						∂
					{OSDir}Keyboard:Kbd.r					∂
					{RsrcDir}AliasMgr.rsrc					∂
					{RsrcDir}AppleEventMgr.rsrc				∂
					{RsrcDir}Backlight.rsrc					∂
					{RsrcDir}BalloonPack.a.rsrc				∂
					{RsrcDir}BeforePatches.a.rsrc			∂
					{RsrcDir}BootAlerts.a.rsrc				∂
					{RsrcDir}BootBlocks.a.rsrc				∂
					{RsrcDir}BootCode.a.rsrc				∂
					{RsrcDir}BuiltInVideoExtension.p.rsrc	∂
					{RsrcDir}ButtonCDEF.a.rsrc				∂
					{RsrcDir}Choose.p.rsrc					∂
					{RsrcDir}Choose.r.rsrc					∂
					{RsrcDir}ChooseHelp.r.rsrc				∂
					{RsrcDir}ColorPicker.p.rsrc				∂
					{RsrcDir}CommResourceMgr.c.rsrc			∂
					{RsrcDir}CommToolboxINIT.r.rsrc			∂
					{RsrcDir}CommToolboxLDEF.p.rsrc			∂
					{RsrcDir}CommToolboxUtilities.c.rsrc	∂
					{RsrcDir}ConnectionMgr.c.rsrc			∂
					{RsrcDir}DAHandler.rsrc					∂
					{RsrcDir}DeCompressDefProc.a.rsrc		∂
					{RsrcDir}DeCompressDefProc1.a.rsrc		∂
					{RsrcDir}DictionaryMgr.a.rsrc			∂
					{RsrcDir}DiskCache.a.rsrc				∂
					{RsrcDir}DiskInit.rsrc					∂
					{RsrcDir}DITL.p.rsrc					∂
					{RsrcDir}EditionMgr.rsrc				∂
					{RsrcDir}FileTransferMgr.c.rsrc			∂
					{RsrcDir}GenericIcons.rsrc				∂
					{RsrcDir}Gestalt.rsrc					∂
					{RsrcDir}GreggyBitsDefProc.a.rsrc		∂
					{RsrcDir}IconLDEF.a.rsrc				∂
					{RsrcDir}IconUtils.rsrc					∂
					{RsrcDir}International.rsrc				∂
					{RsrcDir}InternationalPACK.a.rsrc		∂
					{RsrcDir}itl4Roman.a.rsrc				∂
					{RsrcDir}KbdInstall.a.rsrc				∂
					{RsrcDir}LayerWDEF.c.rsrc				∂
					{RsrcDir}LinkedPatches.rsrc				∂
					{RsrcDir}LinkedPatchLoader.a.rsrc		∂
					{RsrcDir}ListMgrPACK.a.rsrc				∂
					{RsrcDir}MACE3.c.rsrc					∂
					{RsrcDir}MACE6.c.rsrc					∂
					{RsrcDir}Meter.c.rsrc					∂
					{RsrcDir}mNote.c.rsrc					∂
					{RsrcDir}mSamp.c.rsrc					∂
					{RsrcDir}mWave.c.rsrc					∂
					{RsrcDir}Note.c.rsrc					∂
					{RsrcDir}ParityINIT.a.rsrc				∂
					{RsrcDir}PartySamp.c.rsrc				∂
					{RsrcDir}PatchIIciROM.a.rsrc			∂
					{RsrcDir}PatchIIROM.a.rsrc				∂
					{RsrcDir}PatchPlusROM.a.rsrc			∂
					{RsrcDir}PatchPortableROM.a.rsrc		∂
					{RsrcDir}PatchSEROM.a.rsrc				∂
					{RsrcDir}PictButtonCDEF.a.rsrc			∂
					{RsrcDir}PictUtilities.rsrc				∂
					{RsrcDir}PictWhap.a.rsrc				∂
					{RsrcDir}PictWhapSound.rsrc				∂
					{RsrcDir}PopupCDEF.c.rsrc				∂
					{RsrcDir}PopupCDEFMDEF.a.rsrc			∂
					{RsrcDir}PopupTriangle.r.rsrc			∂
					{RsrcDir}PPCBrowser.a.rsrc				∂
					{RsrcDir}PreventSwitchLaunch.a.rsrc		∂
					{RsrcDir}PrintDriver.a.rsrc				∂
					{RsrcDir}QDciPatchROM.a.rsrc			∂
					{RsrcDir}QuickDrawPatchII.rsrc			∂
					{RsrcDir}RomanITL2.a.rsrc				∂
					{RsrcDir}RoundedWDEF.a.rsrc				∂
					{RsrcDir}ROvr.a.rsrc					∂
					{RsrcDir}Scheduler.rsrc					∂
					{RsrcDir}ScriptMgrExtensions.rsrc		∂
					{RsrcDir}ScriptMgrPatch.rsrc			∂
					{RsrcDir}ScriptMgrROMPatch.rsrc			∂
					{RsrcDir}ScrollBarCDEF.a.rsrc			∂
					{RsrcDir}SinDrvr.a.rsrc					∂
					{RsrcDir}SinHighLevel.rsrc				∂
					{RsrcDir}SnarfMan.a.rsrc				∂
					{RsrcDir}SnthLoading.rsrc				∂
					{RsrcDir}SoundInputProc.rsrc			∂
					{RsrcDir}SoundPFDProc.rsrc				∂
					{RsrcDir}StandardFile.rsrc				∂
					{RsrcDir}StandardMBDF.a.rsrc			∂
					{RsrcDir}StandardMDEF.a.rsrc			∂
					{RsrcDir}StandardNBP.p.rsrc				∂
					{RsrcDir}StandardNBP.r.rsrc				∂
					{RsrcDir}StandardNBPHelp.r.rsrc			∂
					{RsrcDir}StandardNBPLDEF.p.rsrc			∂
					{RsrcDir}StandardWDEF.a.rsrc			∂
					{RsrcDir}StartSystem.a.rsrc				∂
					{RsrcDir}SystemFonts.rsrc				∂
					{RsrcDir}TerminalClick.r.rsrc			∂
					{RsrcDir}TerminalMgr.c.rsrc				∂
					{RsrcDir}TextLDEF.a.rsrc				∂
					{RsrcDir}TFBDriver.a.rsrc				∂
					{RsrcDir}UserAlerts.a.rsrc				∂
					{RsrcDir}Wave.c.rsrc					∂
					{ToolBoxDir}ColorPicker:ColorPicker.r	∂
					{ToolBoxDir}ColorPicker:ColorPickerWedge.r	∂

# Object files that make up the (big) 'lpch' resources
LinkedPatchObjs = ∂
					{ObjDir}ForceRomBindOrder.a.o			∂
					{ObjDir}PatchProtector.a.o				∂
					{ObjDir}ProcessManagerSegmentTweaks.a.o	∂
					{ObjDir}PatchROMAlarmNotify.a.o			∂
					{ObjDir}GestaltExtensions.a.o			∂
					{ObjDir}ShutDownMgr.a.o					∂
					{ObjDir}HwPriv.a.o						∂
					{ObjDir}MMUPatches.a.o					∂
					{ObjDir}DispatchHelper.a.o				∂
					{ObjDir}VMPatches.a.o					∂
					{LibDir}TimeMgr.lib						∂
					{LibDir}AliasMgr.lib					∂
					{LibDir}SCSI.lib						∂
					{LibDir}HFS.lib							∂
					{LibDir}FontMgr.lib						∂
					{LibDir}BTreeMgr.lib					∂
					{LibDir}PPC.lib							∂
					{LibDir}NotificationMgr.lib				∂
					{LibDir}MenuMgr.lib						∂
					{ObjDir}MungerPatches.a.o				∂
					{LibDir}SlotMgr.lib						∂
					{ObjDir}TextEditPatch.a.o				∂
					{ObjDir}TextEditPatchIIciROM.a.o		∂
					{LibDir}SoundMgr.lib					∂
					{LibDir}IconUtils.lib					∂
					{ObjDir}ADBMgrPatch.a.o					∂
					{ObjDir}KbdPatches.a.o					∂
					{ObjDir}AllBWQDPatch.a.o				∂
					{ObjDir}CheckDevicesINIT.a.o			∂
					{LibDir}CommToolboxPatch.Lib			∂
					{LibDir}ControlMgr.lib					∂
					{ObjDir}DeskMgrPatches.a.o				∂
					{ObjDir}DeviceLoop.a.o					∂
					{LibDir}DialogMgr.lib					∂
					{ObjDir}GetMgrPatches.a.o				∂
					{ObjDir}LayerMgr.c.o					∂
					{ObjDir}MemoryMgrPatches.a.o			∂
					{ObjDir}MiscPatches.a.o					∂
					{LibDir}ModalDialogMenuPatches.lib		∂
					{ObjDir}Mouse.a.o						∂
					{ObjDir}OpenResFile.a.o					∂
					{ObjDir}PaletteMgrPatches.a.o			∂
					{ObjDir}PowerMgrPatches.a.o				∂
					{ObjDir}PrintGlue.a.o					∂
					{ObjDir}LowMemoryPrintingPatches.a.o	∂
					{ObjDir}QuickDrawPatches.a.o			∂
					{LibDir}ResourceMgr.lib					∂
					{ObjDir}SaveRestoreBits.a.o				∂
					{ObjDir}ScrapMgrPatches.a.o				∂
					{ObjDir}SegmentLoaderPatches.a.o		∂
					{ObjDir}SonyPatches.a.o					∂
					{LibDir}ComponentMgr.lib				∂
					{LibDir}ToolboxEventMgr.lib				∂
					{LibDir}WindowMgr.lib					∂
					{ObjDir}backlightpatch.a.o				∂
					{ObjDir}BrightnessPatches.a.o			∂
					{LibDir}HelpMgr.lib						∂
					{LibDir}TextServicesMgr.lib				∂
					{ObjDir}FontFolderExtension.a.o			∂
					{ObjDir}ResourceOverridePatches.a.o		∂
					{ObjDir}EDiskLocalNamePatch.a.o			∂
					{ObjDir}LateLoad.a.o					∂
					{CLibraries}StdCLib.o					∂
					{IfObjDir}interface.o					∂
					{Libraries}Runtime.o					∂
					{ObjDir}FinalInitialization.a.o			∂

# Conditional compilation booleans for Asm/C/Pascal/Rez
Conds = ∂
					BlackBirdDebug=FALSE					∂
					CubeE=TRUE								∂
					DBLite=FALSE							∂
					forADBKeyboards=TRUE					∂
					forPDMDebug=FALSE						∂
					forPDMProto=FALSE						∂
					forROM=FALSE							∂
					forRomulator=FALSE						∂
					forSmurf=FALSE							∂
					forSTPnop=FALSE							∂
					hasADBKeyLayouts=TRUE					∂
					hasAppleEventMgr=TRUE					∂
					hasAsyncSCSI=FALSE						∂
					hasBalloonHelp=TRUE						∂
					hasBitEdit=FALSE						∂
					hasCommToolbox=TRUE						∂
					hasDataAccessMgr=TRUE					∂
					hasDisplayMgrWindows=FALSE				∂
					hasEditionMgr=TRUE						∂
					hasEgret=FALSE							∂
					hasHMC=FALSE							∂
					hasJaws=FALSE							∂
					hasLayerlessApps=FALSE					∂
					hasManEject=FALSE						∂
					hasMMU=FALSE							∂
					hasMSC=FALSE							∂
					hasNiagra=FALSE							∂
					hasNonADBKeyLayouts=TRUE				∂
					hasPortableKeyLayouts=FALSE				∂
					hasPowerMgr=FALSE						∂
					hasPwrControls=TRUE						∂
					hasPwrMgrClock=TRUE						∂
					hasRISCV0ResMgrPatches=FALSE			∂
					hasSlotMgr=TRUE							∂
					hasSplineFonts=TRUE						∂
					IopADB=FALSE							∂
					NewBuildSystem=TRUE						∂
					nonSerializedIO=TRUE					∂
					padForOverPatch=FALSE					∂
					Pre70=FALSE								∂
					PwrMgrADB=TRUE							∂
					ROMFastTraps=FALSE						∂
					Supports24Bit=TRUE						∂
					SystemSevenOrLater=TRUE					∂
					SystemSixOrLater=TRUE					∂
					TheFuture=FALSE							∂
					ViaADB=TRUE								∂

# Stop newer MPW versions from using Symantec C
C = C

# Housekeeping defs not to be overriden by the Build script
MAOpts = -d TRUE=1 -d FALSE=0 -d Alignment=4 -d CPU=20 -blksize 62 -w
MCOpts = -d TRUE=1 -d FALSE=0 -d Alignment=4 -d CPU=00 -b3 -mbg off
MPOpts = -mbg off -r -noload # -r suppresses bounds checks, -noload ignores dirty 'unit' resources

# Build all targets if none is specified
All ƒ FeatureSet {BuildDir}System {BuildDir}ProcessMgrINIT

# Shell vars and precompiled headers first (Build script will always specify FeatureSet)
FeatureSet ƒ RealFeatureSet {ObjDir}StandardEqu.d {ObjDir}ProcessMgrIncludes.D
RealFeatureSet ƒ
	Set Exit			1
	Set StageChar		`Echo {SysVersStage} | StreamEdit -d -e "/•r/ Pr 'f';    /•f/ Pr 'f';    /•b/ Pr 'b';    /•a/ Pr 'a';    /•d/ Pr 'd'"`
	Set StageHex		`Echo {SysVersStage} | StreamEdit -d -e "/•r/ Pr '0x80'; /•f/ Pr '0x80'; /•b/ Pr '0x60'; /•a/ Pr '0x40'; /•d/ Pr '0x20'"`
	Set StageInt		`Evaluate {StageHex}`
	Set VersString		`Echo {SysVersMajor}.{SysVersMinor}.{SysVersBugfix}{StageChar}{SysVersPre} | StreamEdit -e "/≈/ Rep /f0∞/ ''; Rep /(≈)®1.0/ ®1"`
	Set VersInt			`Evaluate 0x{SysVersMajor}{SysVersMinor}{SysVersBugfix}`
	Set VersCommon		"-d SysVers={VersInt} -d StageInt={StageInt} -d LangInt={LangInt}"
	Set FeatureSet		"`Echo {Conds} | StreamEdit -e "/≈/ Replace -c ∞ /([A-Za-z0-9]+=[A-Za-z0-9]+)®1/ '-d ' ®1"`" ; Export FeatureSet
	Set Commands		{ToolDir},{Commands}
	Set ObjDir			{ObjDir}		; Export ObjDir
	Set RsrcDir			{RsrcDir}		; Export RsrcDir
	Set TextDir			{TextDir}		; Export TextDir
	Set	MiscDir			{MiscDir}		; Export MiscDir
	Set	TidbitsDir		{TidbitsDir}	; Export TidbitsDir
	Set AIncludes		{AIncludes}
	Set CIncludes		{CIncludes}
	Set PInterfaces		{PInterfaces}
	Set RIncludes		{RIncludes}
	Set	Libraries		{Libraries}
	Set	CLibraries		{CLibraries}
	Set	PLibraries		{PLibraries}
	Set IntAIncludes	{IntAIncludes}		; Export IntAIncludes
	Set IntCIncludes	{IntCIncludes}		; Export IntCIncludes
	Set IntPInterfaces	{IntPInterfaces}	; Export IntPInterfaces
	Set IntRIncludes	{IntRIncludes}		; Export IntRIncludes
	Set StdAOpts		"{MAOpts} {FeatureSet} -i {IntAIncludes} {AOpts} -i {ObjDir}      {VersCommon} -d &SysVersion=∂∂'{VersString}∂∂'"
	Set StdCOpts		"{MCOpts} {FeatureSet} -i {IntCIncludes} {COpts} -n               {VersCommon} -d SYS_VERSION=∂∂'{VersInt}∂∂'"
	Set StdCPOpts		"{MCPOpts} {FeatureSet} -i {IntCIncludes} {COpts}                 {VersCommon} -d SYS_VERSION=∂∂'{VersInt}∂∂'"
	Set StdPOpts		"{MPOpts} {FeatureSet} -i {IntPInterfaces} {POpts}"
	Set StdROpts		"{MROpts} {FeatureSet} -i {IntRIncludes} {ROpts} -i {RIncludes}   {VersCommon} -d SysVersion=∂∂∂"{VersString}∂∂∂" -d LIntVers=0x{SysVersMajor},0x{SysVersMinor}{SysVersBugfix},{StageHex},`Evaluate -h {SysVersPre}`"
	Set StdLOpts		"-w {LOpts} -mf -t rsrc -c RSED -sg Main"
	Set StdLibOpts		"-w {LibOpts} -mf"
	Set StdAlign		"{Align}"
	Set StdEquAOpts		"-d StandardEquROMFastTraps=0 -d StandardEquSupports24Bit=1" # Compat with new conditionals in SuperMario headers


# For the Build script -- but easier just to trash BuildResults
Clean ƒ
	Delete -i `Files -f -r -o -s {BuildDir}` ≥ Dev:Null

# Make's default rules with XOpts replaced by StdXOpts (defined as a Shell variable above)
.a.o ƒ .a
	{Asm} {StdAOpts} -o {Targ} {DepDir}{Default}.a

.c.o ƒ .c
	{C} {StdCOpts} -o {Targ} {DepDir}{Default}.c

.p.o ƒ .p
	{Pascal} {StdPOpts} -o {Targ} {DepDir}{Default}.p

.cp.o ƒ .c
	{CPlus} {StdCPOpts} -o {Targ} {DepDir}{Default}.cp

# Bring in other variables and rules
# (MainCode.make is for ROM, but it brings in other stuff)
#include {DriverDir}Drivers.make
#include {MakeDir}MainCode.make
#include {DeclDir}DeclData.make
#include {ResourceDir}Resources.make
#include {ProcessMgrDir}ProcessMgr.make


########################################################################
# Build tools 
########################################################################

{RsrcDir}SysDF ƒ {ToolDir}SysDF.c {IfObjDir}Interface.o
	C {COpts} -o {ObjDir}SysDF.c.o {ToolDir}SysDF.c
	Link -o {Targ} -t 'MPST' -c 'MPS ' {ObjDir}SysDF.c.o {IfObjDir}Interface.o {CLibraries}StdCLib.o {Libraries}Runtime.o


########################################################################
# The System file 
########################################################################

# Hacks adapt Sys.r to the changed build system
{BuildDir}System ƒ {ResourceDir}Sys.r {SystemResourceFiles} {PatchDir}LoadPatches.a {RsrcDir}SysDF
	Set Misc {MiscDir}; Export Misc
	Set ColorPicker {ColorPickerDir}; Export ColorPicker
	Set DataAccessMgr {DataAccessDir}; Export DataAccessMgr
	Set Keyboard {OSDir}Keyboard:; Export Keyboard
	Set RealObjDir {ObjDir}; Set ObjDir {RsrcDir}
	Rez	{StdROpts} -t zsys -c MACS -d VidExtVers=∂"{VidExtVers}∂" {ResourceDir}Sys.r -o {Targ}
	Set ObjDir {RealObjDir}
	# Get rid of all the "Main" segment names
	#DeRez {Targ} ∂
	#	| StreamEdit -d -e '/•data ([¬ ]+)®1 ∂(([¬,]+)®2,≈∂"Main∂"/ Print "Change "®1" ("®2") to $$Type ($$Id, $$Attributes);"' ∂
	#	| Rez -a -o {Targ}
	# Compatibility code (and credits) in the data fork
	Asm {StdAOpts} -o {ObjDir}LoadPatches.a.o {PatchDir}LoadPatches.a
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o {RsrcDir}LoadPatches.a.rsrc {ObjDir}LoadPatches.a.o
	{RsrcDir}SysDF {Targ} {RsrcDir}LoadPatches.a.rsrc


########################################################################
# Classical PTCH resources 
########################################################################

# Patches and patch installation code for all ROMs (PTCH 0)
{RsrcDir}BeforePatches.a.rsrc ƒ {PatchDir}BeforePatches.a
	Asm {StdAOpts} -o {ObjDir}BeforePatches.a.o {PatchDir}BeforePatches.a
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o {Targ} {ObjDir}BeforePatches.a.o

PatchOpts = -d SonyNonPortable -i {PatchDir} -i {GestaltDir} -i {QDPatchesDir} -i {Sources}QuickDraw: -i {DriverDir}Video:

# PTCH $75 (117) for Plus
{ObjDir}PatchPlusROM.a.o ƒ {PatchDir}PatchPlusROM.a
	Asm {StdAOpts} {PatchOpts} -o {Targ} {PatchDir}PatchPlusROM.a
{RsrcDir}PatchPlusROM.a.rsrc ƒ {ObjDir}PatchPlusROM.a.o
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o {Targ} {ObjDir}PatchPlusROM.a.o

# PTCH $178 (376) for II
{ObjDir}PatchIIROM.a.o ƒ {PatchDir}PatchIIROM.a
	Asm {StdAOpts} {PatchOpts} -o {Targ} {PatchDir}PatchIIROM.a
{RsrcDir}PatchIIROM.a.rsrc ƒ {ObjDir}PatchIIROM.a.o
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o {Targ} {ObjDir}PatchIIROM.a.o

# PTCH $276 (630) for SE
{ObjDir}PatchSEROM.a.o ƒ {PatchDir}PatchSEROM.a
	Asm {StdAOpts} {PatchOpts} -o {Targ} {PatchDir}PatchSEROM.a
{RsrcDir}PatchSEROM.a.rsrc ƒ {ObjDir}PatchSEROM.a.o
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o {Targ} {ObjDir}PatchSEROM.a.o

# PTCH $37a (890) for Portable
{ObjDir}PatchPortableROM.a.o ƒ {PatchDir}PatchPortableROM.a
	Asm {StdAOpts} {PatchOpts} -o {Targ} {PatchDir}PatchPortableROM.a
{RsrcDir}PatchPortableROM.a.rsrc ƒ {ObjDir}PatchPortableROM.a.o
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o {Targ} {ObjDir}PatchPortableROM.a.o

# PTCH $676 (1660) for IIci
{ObjDir}PatchIIciROM.a.o ƒ {PatchDir}PatchIIciROM.a
	Asm {StdAOpts} {PatchOpts} -o {Targ} {PatchDir}PatchIIciROM.a
{RsrcDir}PatchIIciROM.a.rsrc ƒ {ObjDir}PatchIIciROM.a.o
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o {Targ} {ObjDir}PatchIIciROM.a.o


########################################################################
# The LinkedPatch mechanism
########################################################################

# Link LinkPatch, the LinkedPatch linker (object only, no source code!)
{RsrcDir}LinkPatch ƒ {LinkPatchDir}LinkPatchLib.o {ObjDir}LinkPatch.a.o
	Link -t MPST -c 'MPS ' -o {Targ} {LinkPatchDir}LinkPatchLib.o {ObjDir}LinkPatch.a.o

# LinkPatch needs to know some constants in LinkedPatchMacros.a
{ObjDir}LinkPatch.a.o ƒ {LinkPatchDir}LinkPatch.a
	Asm {StdAOpts} -o {Targ} {LinkPatchDir}LinkPatch.a

# Combine the linked patch objects into one lib...
{LibDir}LinkedPatches.lib ƒ {LinkedPatchObjs}
	Lib {StdLibOpts} -o {Targ} {LinkedPatchObjs}

# ...and link them into several 'lpch' resource
{RsrcDir}LinkedPatches.rsrc ƒ {RsrcDir}LinkPatch {LibDir}LinkedPatches.lib
	# -l for some table, -v for counts, -p for patches, -w for ?warnings-off
	{RsrcDir}LinkPatch -l -w -o {Targ} {LibDir}LinkedPatches.lib > {TextDir}LinkPatchJumpTbl

# Assemble the runtime linked patch loader...
{ObjDir}LinkedPatchLoader.a.o ƒ {LinkPatchDir}LinkedPatchLoader.a
	Asm {StdAOpts} -o {Targ} {LinkPatchDir}LinkedPatchLoader.a

# ...and link it into a 'lodr' resource
{RsrcDir}LinkedPatchLoader.a.rsrc ƒ {ObjDir}LinkedPatchLoader.a.o
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o {Targ} {ObjDir}LinkedPatchLoader.a.o


########################################################################
# LinkedPatch objects not built by another makefile
########################################################################

# My hack to ensure byte-perfect lpch builds
{ObjDir}ForceRomBindOrder.a.o ƒ {Sources}Make:ForceRomBindOrder.a
	Asm {StdAOpts} -o {Targ} {Sources}Make:ForceRomBindOrder.a

# A patch to SetTrapAddress and GetTrapAddress that “protects” come-from patches
{ObjDir}PatchProtector.a.o ƒ {LinkPatchDir}PatchProtector.a
	Asm {StdAOpts} -o {Targ} {LinkPatchDir}PatchProtector.a

# Do smarter loading of Process Manager segments to reduce system heap fragmentation
{ObjDir}ProcessManagerSegmentTweaks.a.o ƒ {PatchDir}ProcessManagerSegmentTweaks.a
	Asm {StdAOpts} -o {Targ} {PatchDir}ProcessManagerSegmentTweaks.a

# Patches to backgroung printing when memory is low
{ObjDir}LowMemoryPrintingPatches.a.o ƒ {PatchDir}LowMemoryPrintingPatches.a
	Asm {StdAOpts} -o {Targ} {PatchDir}LowMemoryPrintingPatches.a

# Patch Classic .Screen drvr to error on "GetScreenState" status call
{ObjDir}BrightnessPatches.a.o ƒ {PatchDir}BrightnessPatches.a
	Asm {StdAOpts} -o {Targ} {PatchDir}BrightnessPatches.a

# RamDisk internal name localizer
{ObjDir}EDiskLocalNamePatch.a.o ƒ {PatchDir}EDiskLocalNamePatch.a
	Asm {StdAOpts} -o {Targ} {PatchDir}EDiskLocalNamePatch.a

# Responsible for mounting slow SCSI drives on TERROR machines
{ObjDir}LateLoad.a.o ƒ {TidbitsDir}LateLoad.a
	Asm {StdAOpts} -o {Targ} {TidbitsDir}LateLoad.a

# "Secondary initialization" patches
{ObjDir}FinalInitialization.a.o ƒ {PatchDir}FinalInitialization.a
	Asm {StdAOpts} -o {Targ} {PatchDir}FinalInitialization.a


########################################################################
# Misc System file resources 
########################################################################

# Deep shit alerts for booting
{RsrcDir}BootAlerts.a.rsrc ƒ {TidbitsDir}BootAlerts.a
	Asm {StdAOpts} -o {ObjDir}BootAlerts.a.o {TidbitsDir}BootAlerts.a
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o {Targ} {ObjDir}BootAlerts.a.o

# Deep shit alerts (for after booting)
{RsrcDir}UserAlerts.a.rsrc ƒ {TidbitsDir}UserAlerts.a
	Asm {StdAOpts} -o {ObjDir}UserAlerts.a.o {TidbitsDir}UserAlerts.a
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o {Targ} {ObjDir}UserAlerts.a.o

# Built-in Video Monitors (cdev) Extension for IIci and IIsi
{RsrcDir}BuiltInVideoExtension.p.rsrc ƒ {TidbitsDir}BuiltInVideoExtension.p
	Pascal {StdPOpts} -o {ObjDir}BuiltInVideoExtension.p.o {TidbitsDir}BuiltInVideoExtension.p
	Link {StdLOpts} {StdAlign} -m ENTRY -rt RSRC=0 -o {Targ} {ObjDir}BuiltInVideoExtension.p.o {LibraryDir}StandardLib.o {IfObjDir}interface.o

# The standard decompression DefProc
{RsrcDir}DeCompressDefProc.a.rsrc ƒ {PatchDir}DeCompressDefProc.a
	Asm {StdAOpts} -o {ObjDir}DeCompressDefProc.a.o {PatchDir}DeCompressDefProc.a
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o {Targ} {ObjDir}DeCompressDefProc.a.o

# The standard decompression defproc for byte sized data
{RsrcDir}DeCompressDefProc1.a.rsrc ƒ {PatchDir}DeCompressDefProc1.a
	Asm {StdAOpts} -o {ObjDir}DeCompressDefProc1.a.o {PatchDir}DeCompressDefProc1.a
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o {Targ} {ObjDir}DeCompressDefProc1.a.o

# Decompress defProc for GreggyBits decompression
{RsrcDir}GreggyBitsDefProc.a.rsrc ƒ {PatchDir}GreggyBitsDefProc.a
	Asm {StdAOpts} -o {ObjDir}GreggyBitsDefProc.a.o {PatchDir}GreggyBitsDefProc.a
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o {Targ} {ObjDir}GreggyBitsDefProc.a.o

# Code to put up a dialog if we have a parity troubles
{RsrcDir}ParityINIT.a.rsrc ƒ {TidbitsDir}ParityINIT.a
	Asm {StdAOpts} -o {ObjDir}ParityINIT.a.o {TidbitsDir}ParityINIT.a
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o {Targ} {ObjDir}ParityINIT.a.o

# FKEY that will save the screen as a PICT file
{RsrcDir}PictWhap.a.rsrc ƒ {TidbitsDir}PictWhap.a
	Asm {StdAOpts} -o {ObjDir}PictWhap.a.o {TidbitsDir}PictWhap.a
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o {Targ} {ObjDir}PictWhap.a.o

# Sound resource which is played when FKEY 3 is executed
{RsrcDir}PictWhapSound.rsrc ƒ {TidbitsDir}PictWhapSound.r
	Rez {StdROpts} -o {Targ} {TidbitsDir}PictWhapSound.r

# Prevents switch launching from System 6 to System 7
{RsrcDir}PreventSwitchLaunch.a.rsrc ƒ {TidbitsDir}PreventSwitchLaunch.a
	Asm {StdAOpts} -o {ObjDir}PreventSwitchLaunch.a.o {TidbitsDir}PreventSwitchLaunch.a
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o {Targ} {ObjDir}PreventSwitchLaunch.a.o

# ROM resource override code
{RsrcDir}ROvr.a.rsrc ƒ {TidbitsDir}ROvr.a
	Asm {StdAOpts} -o {ObjDir}ROvr.a.o {TidbitsDir}ROvr.a
	Link {StdLOpts} {StdAlign} -rt RSRC=0 -o {Targ} {ObjDir}ROvr.a.o

{RsrcDir}SystemFonts.rsrc ƒ {MiscDir}SystemFonts.r
	Rez {StdROpts} -o {Targ} {MiscDir}SystemFonts.r
