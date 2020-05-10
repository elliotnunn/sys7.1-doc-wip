    Replaced wholesale:
    APTK57.rsrc
    VM.rsrc
    Tools/Make
    Tools/Pascal


Other patches
-------------

PatchProtector.a (lpch) protects come-from patches.
PatchROMAlarmNotify.a (lpch) removes the ROM 'alarm clock' GNEFilter on `(Plus,SE,II)`.


Gestalt
-------

GestaltExtensions.a (lpch) installs new selectors on `(Plus,SE,II,Portable,IIci)`:
Elliot revisit these please!

*   ostt
*   tbtt
*   xttt
*   micn A machine icon selected from GenericIcons


*   bugz Elliot elaborate on which bugs are declared as fixed


*   rsrc = gestaltPartialRsrcs + gestaltResourceOverrides
*   qdrw = gestaltHasGrayishTextOr +
          (on color machines) gestaltHasDirectPixMaps + gestaltHasDeepGWorlds + gestaltHasColor

*   Added gestaltHasSoftPowerOff bit to hdwr, according to the actual machine


Process Manager
---------------

Entirely System-based, and structured like an application in scod resources. The DA Handler is structured the same way. ProcessManagerSegmentTweaks.a (lpch) forces the non-purgeable scods low on `(Plus,SE,II,IIci,Portable)`.


Shutdown Manager
----------------

`ShutDown(A895)` trap completely replaced on `(Plus,SE,II,Portable,IIci)`. The only ROM code used is AllocFakeRgns for clearing the desktop on shutdown.

ShutDwnPower gets patched on all `(IIci)` machines to display an alert offering to cancel shutdown when there is an EDisk. This is only needed on overpatched ROMs but there is no suitable linked patch conditional (explained in 'ShutDownMgr Release Notes').


HwPriv trap
-----------

    "The _HWPriv trap was created to export some low level hardware control capabilites to the (user mode) world at large. A selector passed in D0 determines which specific transistor to twiddle." - HwPriv.a

    System 7.1 (HwPriv.a) patches HwPriv to look up its selector in a new RAM-based table, pointed to by ExpandMem. Table entries point to a linked patch version in RAM, or to ROM. Un-accelerated 68000 Macs do not get this table: the HwPriv handler just checks for the single valid selector. This table shows the outcome on various machines.

Selector                68000                           68020/030 pre-TERROR            68030/040 TERROR-and-later
 0. SwapICache          unimplemented                   RAM (replacement)               ROM
 1. FlushICache         unimplemented                   RAM (replacement)               ROM
 2. SwapDCache          unimplemented                   RAM (replacement)               ROM
 3. FlushDCache         unimplemented                   RAM (replacement)               ROM
 4. EnableExtCache      unimplemented                   RAM (replacement)               ROM
 5. DisableExtCache     unimplemented                   RAM (replacement)               ROM
 6. FlushExtCache       unimplemented                   RAM (replacement)               ROM
 7. SwapSerialClock     RAM (new)                       RAM (replacement)               RAM (replacement)
 8. ProtectEDisk        unimplemented                   unimplemented                   ROM
 9. FlushCRange         unimplemented                   RAM (new, just FlushICache)     ROM
10. WaitForSCSIDevs     unimplemented                   RAM (new)                       ROM

MC68000 CPUs have no cache, so the cache calls are not useful. Pre-68040 CPUs are unable to flush a specific cache range, so flushing the whole cache with FlushICache is sufficient for FlushCRange.


SwapMMUMode trap
----------------

"To change the address-translation mode from 24-bit to 32- bit or vice versa, use the SwapMMUMode procedure." - IM:M

System 7.1 (HwPriv.a) implements SwapMMUMode as a 'stub' linked patch on `(Plus,SE,Portable)`, reimplements SwapMMUMode with either of two linked patches on `(II)` -- see below, and leaves the ROM implementation alone on `(IIci)`.

When a 'fake' HMMU is installed in the Mac II 68851 socket, the linked patch SwapMMUMode fixes a ROM bug that dropped Apple Sound Chip interrupts when controlling the HMMU via the VIA. When a 'real' PMMU is installed, the linked patch is 'just a more efficient version of SwapMMUMode'. This contrasts with the original `(II)` ROM implementation, which was structured as a single routine that handled all cases.


DispatchHelper and ProcHelper traps
-----------------------------------

Routines for generic and resource-based dispatching on routine selectors, featuring stack cleanup for unknown selectors. DispatchHelper is mainly called from ROM code using the BeginDispatcher/DispatchSelectors/EndDispatcher macros.

System 7.1 (DispatchHelper.a) implements the trap as a linked patch on `(Plus,SE,II,Portable,IIci)`. There is a (SuperMario) ROM version.


Virtual Memory
--------------

The MacOS Virtual Memory implementation expands the addressable RAM (i.e. the range from address 0) using a backing file in fixed storage.

The System 7.1 RAM Start Manager ('boot' 3) loads Virtual Memory from the self-contained 'ptch' 42 resource. This resource is built separately from the System, so unfortunately no source code is available.

System 7.1 implements the VM trap DeferUserFn with a linked patch stub on `(Plus,SE,II,Portable,IIci,notVM)`. There is a (SuperMario) ROM version.


Time Manager
------------

"Lets you schedule a routine to be executed after a given number of milliseconds have elapsed." - IM IV-297

Three versions of the Time Manager are documented in IM VI-23.

1. Original, present in `(Plus,SE,II)` ROMs
2. Revised, with negated microseconds, documented in System 6.0.3+
3. Extended, with drift-free InsXTime, documented in System 7.0+, undocumented in `(Portable,IIci)` ROMs

System 7.1 linked patches ensure that all machines have the extended Time Manager. The original Time Manager in `(Plus,SE,II)` ROMs is replaced without reusing any ROM code. The extended Time Manager in `(Portable,IIci)` ROMs is minimally patched to add a new Microseconds trap. This new trap depends on the Time Manager globals, and on a replaced internal FreezeTime routine that keeps the globals up to date.

Routine                 | `(Plus,SE,II)`              | `(Portable,IIci)`
------------------------|-----------------------------|--------------------------------------------
InsTime/InsXTime        | RAM (replacement)           | RAM (calls new FreezeTime then rejoins ROM)
PrimeTime               | RAM (replacement)           | RAM (calls new FreezeTime then rejoins ROM)
RmvTime                 | RAM (replacement)           | RAM (calls new FreezeTime then rejoins ROM)
Timer2Int (int handler) | RAM (replacement)           | RAM (calls new FreezeTime then rejoins ROM)
FreezeTime (internal)   | RAM (called by above)       | RAM (replaced by above)
(Globals)               | Trashed and reinitialized   | Copied and extended
(Queued tasks)          | Requeued                    | Left alone
Microseconds            | RAM (new)                   | RAM (new)


Alias Manager
-------------

"Establish and resolve alias records, which are data structures that describe file system objects." - IM VI-27

System 7.1 adds the Alias Manager to `(Plus,SE,II,Portable,IIci)` ROMs by creating the new AliasDispatch trap. The Alias Manager initialization code installs the 'alis' and 'fold' Gestalt selectors, and points the ExpandMem variable emFolderCache to a structure of caches for FindFolder calls.


SCSI Manager
------------

System 7.1 linked patches (SCSILinkPatch.a) replace and reinitialize the 53C96 SCSI Manager on `(IIci,hasC96)` i.e. Quadra 700/900/950. The reason is not clear from the changelogs.

System 7.1 linked patches (SCSILinkPatch.a) enable a workaround for the File Sharing deadlock in the `(Plus,SE,Portable,II,IIci,notAUX)` async SCSI Manager. A new private selector is added to SCSIDispatch to check the state of the bus: SCSIBusy (14). When a SCSI call would otherwise cause a deadlock, clients can install a routine to the ExpandMem field jSCSIFreeHook to run when the bus is free.

System 7.1 linked patches (SCSILinkPatch.a) live-patches the Apple SCSI disk driver (which would likely be loaded from a driver partition) to work around a Quantum firmware bug. The buggy drives corrupt data on a 10-15 block read, so that read gets split into two reads.


File Manager, Queue Manager and Desktop Manager
-----------------------------------------------

The Hierarchical File System (codenamed TurboFS) is in ROM from `(Plus)` onwards. It is pretty extensively patched, though. System 7.1 has many linked patches in `FileMgrPatches.a`. With one minor exception, these apply to `(Plus,SE,II,Portable,IIci)`.

An overview of the changes:

*   Queue Manager and Desktop Manager installed [search FileMgrPatches.a for QMInit/DTDBMgrInit]
*   New HFSDispatch selectors added (including ones for Desktop Manager and AppleShare) [search FileMgrPatches.a for HFSDISPHOOK]
*   The new MakeFSSpec selector is emulated on external file systems that do not support it [search FileMgrPatches.a for MakeFSSpecEmulation]
*   Per-process ownership of FCBs and WDCBs tracked in parallel tables for Process Manager cleanup, and so apps cannot close files opened by the System [search FileMgrPatches.a for ClosePatch/OpenWDPatch/fsQueueHookPatch]
*   SetFilLock/RstFilLock traps affect extended Finder info [search FileMgrPatches.a for SetFilLock/RstFilLock]
*   Disk-switch dialog patched to fix cmd-shift-1/2 (eject disk)
*   A mysterious fix to the disk-switch dialog when there is insufficient memory to save the pixels behind [search FileMgrPatches.a for ForceSetPortInDiskSwap/AccumulateDiskSwitchRectIntoUpdateRect/DSHookFixItPatch]
*   Volumes prevented from being renamed to 0 or >27 characters [search FileMgrPatches.a for FixVolumeRenames]
*   Catalog Manager intricately patched to be "fileID-aware", and to fix WDCB table corruption when closed files are mistaken for folders [search FileMgrPatches.a for myCMSetUp]
*   FCB and WDCB tables grown when necessary and safe, leaving some "burst" capacity for when memory must not be moved [search FileMgrPatches.a for OpenAttemptHook/AllocateFCBs/MoreFCBs/MoreWDCBs/fsQueueHookPatch]
*   A longstanding minor bug fixed in DtrmV3, but not on `(Plus,SE)` where it is inconvenient to fix [search FileMgrPatches.a for FixDtrmV3]
*   No memory moved by the disk-switch dialog, to allow async calls to use it [search FileMgrPatches.a for MountVolFor1991/NoCloseOnOffline/NoCloseOnEject/UnmountForTheNineties/DSHookFixItPatch/SetDSHookInfo/KillCheckRemountNiceWay]
*   Impossible BTree flushes to offline volumes prevented [search FileMgrPatches.a for FixBTFlush]
*   A reentrancy problem fixed for the disk-switch dialog by saving its text in a global [search FileMgrPatches.a for DSHookFixItPatch/SetDSHookInfo]
*   SCSI Manager's SCSIBusy/jSCSIFreeHook mechanism used to defer calls made synchronously at interrupt or Deferred Task time, and prevent deadlocks [search FileMgrPatches.a for CheckSCSICollision/CheckInterruptMask/fsSCSIFreeHookProc]
*   Some clever hack is used to prevent arbitrary stack buildup of sychronously executed async calls
*   Multifork file trucation fixed on file close [search FileMgrPatches.a for DontTruncateMultiForks]
*   Write count maintained for catalog nodes, for unclear purpose [search FileMgrPatches.a for WriteCountInit]
*   Clobbered registers on `(Plus)` fixed [search FileMgrPatches.a for SaveD1AcrossBTDelete]
*   MountVol problem of missing an existing offline volume fixed on `(Plus)` [search LaterFileMgrPatches.a for MountVolPatch]
*   Register bug in renaming MFS volumes fixed on `(Plus)` [search LaterFileMgrPatches.a for MFSRenamePatch]

When reading fsQueueHookPatch in FileMgrPatches.a, be aware that it uses the hook mechanism to completely replace the ROM FSQueue routine by failing to return. The actual new code is between "See what work there is to do" and "Go re-execute the original trap".

System 7.1 implements a new FSSpec trap `HighLevelFSDispatch(AA52)` (codenamed "HFS Pinafore") on `(Plus,SE,Portable,II,IIci)`. See `FSpDispatch.a` and `FSSpecCalls.c`.


Font Manager
------------

Routine     | `(Plus,`      | `SE,`         | `II,`         | `Portable,`   | `IIci)`
------------|---------------|---------------|---------------|---------------|---------------
StdText     | Replaced to add `grayishTextOr` opcode      ||| 
StdLine     |
StdRect     |
StdRRect    |
StdOval     |
StdArc      |
StdPoly     |
StdRgn      |
StdBits     |
StdComment  |
StdTxMeas   |
StdGetPic   |
StdPutPic   |






System 7.1 replaces the `StdText(A882)` QD bottleneck proc on B&W machines `(Plus,SE,II)` to add support for the `grayishTextOr` text transfer mode, and for saving font names (rather than just IDs) in PICTs. Likewise, `StdTxMeas(A8ED)` is replaced to add double-byte font support. `MeasureText(A837)`