/*
	Hacks to match MacOS (most recent first):

	<Sys7.1>	  8/3/92	Decompiled from scratch
*/

#ifndef __TYPES__
#include <Types.h>
#endif

#ifndef __FILES__
#include <Files.h>
#endif

#ifndef __MEMORY__
#include <Memory.h>
#endif

#ifndef __ERRORS__
#include <Errors.h>
#endif

#ifndef __RESOURCES__
#include <Resources.h>
#endif

#ifndef __TOOLUTILS__
#include <ToolUtils.h>
#endif

#ifndef __OSUTILS__
#include <OSUtils.h>
#endif

#ifndef __DEVICES__
#include <Devices.h>
#endif

#ifndef __POWER__
#include <Power.h>
#endif

#include <BTEqu.h>
#include "UserGroup.h"

#ifndef __APPLETALK__
#include <AppleTalk.h>
#endif

#ifndef __ADSP__
#include "ADSP.h"
#endif

#ifndef __PPCTOOLBOX__
#include <PPCToolBox.h>
#endif

#ifndef __STDDEF__
#include <StdDef.h>
#endif

#include "PPCCommon.h"


OSErr OpenADSPDriver(short *refNum) //26cc4
{
// ROM:00126CC4                 link    a6,#0
// ROM:00126CC8                 subq.l  #2,sp
// ROM:00126CCA                 pea     unk_126CDC
// ROM:00126CCE                 move.l  8(a6),-(sp)
// ROM:00126CD2                 ori.b   #$D7,d0
// ROM:00126CD6                 move.w  (sp)+,d0
// ROM:00126CD8                 unlk    a6
// ROM:00126CDA                 rts
	return OpenDriver("\p.DSP", refNum);
}

OSErr CreateConnectionListener(Ptr ccbPtr, //8
							   DSPParamBlock *dsp, //c
							   unsigned short dspDrvrRef, //10
							   unsigned char  socket, //12
							   Boolean  async, //14
							   ProcPtr  compRoutine) //16 //26ce2
{
// ROM:00126CE2
// ROM:00126CE2                 link    a6,#0
// ROM:00126CE6                 movem.l a3-a4,-(sp)
// ROM:00126CEA                 movea.l $C(a6),a3
// ROM:00126CEE                 lea     $22(a3),a4
// ROM:00126CF2                 move.w  $12(a6),$18(a3)
// ROM:00126CF8                 move.w  #$FB,$1A(a3)
// ROM:00126CFE                 move.l  $1C(a6),$C(a3)
// ROM:00126D04                 move.l  8(a6),(a4)
// ROM:00126D08                 moveq   #0,d0
// ROM:00126D0A                 move.l  d0,4(a4)
// ROM:00126D0E                 clr.w   8(a4)
// ROM:00126D12                 clr.w   $E(a4)
// ROM:00126D16                 move.l  d0,$A(a4)
// ROM:00126D1A                 move.l  d0,$10(a4)
// ROM:00126D1E                 move.l  d0,$14(a4)
// ROM:00126D22                 move.b  $17(a6),$18(a4)
// ROM:00126D28                 move.l  a3,-(sp)
// ROM:00126D2A                 subq.l  #2,sp
// ROM:00126D2C                 move.l  a3,-(sp)
// ROM:00126D2E                 move.b  $1B(a6),-(sp)
// ROM:00126D32                 ori.b   #$DF,d5
// ROM:00126D36                 move.w  (sp)+,d0
// ROM:00126D38                 ext.l   d0
// ROM:00126D3A                 move.l  d0,-(sp)
// ROM:00126D3C                 ori.b   #$20,d0         ; jsr DMFix
// ROM:00126D40                 movem.l -8(a6),a3-a4
// ROM:00126D46                 unlk    a6
// ROM:00126D48                 rts
	struct TRinitParams *params = &(dsp->u.initParams);

	dsp->ioCRefNum = dspDrvrRef;
	dsp->csCode = dspCLInit;
	dsp->ioCompletion = compRoutine;

	params->ccbPtr = ccbPtr;
	params->userRoutine = NULL;
	params->sendQSize = 0;
	params->recvQSize = 0;
	params->sendQueue = NULL;
	params->recvQueue = NULL;
	params->attnPtr = NULL;
	params->localSocket = socket;

	return DMFix(PBControl(dsp, async), dsp);
}

OSErr ListenConnectionRequest(DSPParamBlock *dsp,
							  Boolean async,
							  ProcPtr compRoutine) //26d4a
{
// ROM:00126D4A                 link    a6,#0
// ROM:00126D4E                 movem.l a3-a4,-(sp)
// ROM:00126D52                 movea.l 8(a6),a4
// ROM:00126D56                 lea     $22(a4),a3
// ROM:00126D5A                 move.w  #$F9,$1A(a4)
// ROM:00126D60                 move.l  $10(a6),$C(a4)
// ROM:00126D66                 clr.b   $A(a3)
// ROM:00126D6A                 clr.w   8(a3)
// ROM:00126D6E                 clr.b   $B(a3)
// ROM:00126D72                 move.l  a4,-(sp)
// ROM:00126D74                 subq.l  #2,sp
// ROM:00126D76                 move.l  a4,-(sp)
// ROM:00126D78                 move.b  $F(a6),-(sp)
// ROM:00126D7C                 ori.b   #$DF,d5
// ROM:00126D80                 move.w  (sp)+,d0
// ROM:00126D82                 ext.l   d0
// ROM:00126D84                 move.l  d0,-(sp)
// ROM:00126D86                 ori.b   #$20,d0
// ROM:00126D8A                 movem.l -8(a6),a3-a4
// ROM:00126D90                 unlk    a6
// ROM:00126D92                 rts
	struct TRopenParams *params = &(dsp->u.openParams);

	dsp->csCode = dspCLListen;
	dsp->ioCompletion = compRoutine;

	params->filterAddress.aNode = 0;
	params->filterAddress.aNet = 0;
	params->filterAddress.aSocket = 0;

	return DMFix(PBControl(dsp, async), dsp);
}


void RejectConnectionRequest(DSPParamBlock *dsp, Boolean async, ProcPtr compRoutine) //26d94
{
// ROM:00126D94                 link    a6,#0
// ROM:00126D98                 move.l  a4,-(sp)
// ROM:00126D9A                 movea.l 8(a6),a4
// ROM:00126D9E                 move.l  $10(a6),$C(a4)
// ROM:00126DA4                 move.w  #$F8,$1A(a4)
// ROM:00126DAA                 move.l  a4,-(sp)
// ROM:00126DAC                 subq.l  #2,sp
// ROM:00126DAE                 move.l  a4,-(sp)
// ROM:00126DB0                 move.b  $F(a6),-(sp)
// ROM:00126DB4                 ori.b   #$DF,d5
// ROM:00126DB8                 move.w  (sp)+,d0
// ROM:00126DBA                 ext.l   d0
// ROM:00126DBC                 move.l  d0,-(sp)
// ROM:00126DBE                 ori.b   #$20,d0
// ROM:00126DC2                 movea.l -4(a6),a4
// ROM:00126DC6                 unlk    a6
// ROM:00126DC8                 rts
	dsp->ioCompletion = compRoutine;
	dsp->csCode = dspCLDeny;

	DMFix(PBControl(dsp, async), dsp);
}

OSErr RemoveConnectionListener(unsigned char abortFlag,
						  	   Boolean        async,
						  	   ProcPtr        compRoutine,
				          	   DSPParamBlock  *dsp) //26dca
{
// ROM:00126DCA                 link    a6,#0
// ROM:00126DCE                 movem.l a3-a4,-(sp)
// ROM:00126DD2                 movea.l $14(a6),a4
// ROM:00126DD6                 lea     $22(a4),a3
// ROM:00126DDA                 move.w  #$FA,$1A(a4)
// ROM:00126DE0                 move.l  $10(a6),$C(a4)
// ROM:00126DE6                 move.b  $B(a6),(a3)
// ROM:00126DEA                 move.l  a4,-(sp)
// ROM:00126DEC                 subq.l  #2,sp
// ROM:00126DEE                 move.l  a4,-(sp)
// ROM:00126DF0                 move.b  $F(a6),-(sp)
// ROM:00126DF4                 ori.b   #$DF,d5
// ROM:00126DF8                 move.w  (sp)+,d0
// ROM:00126DFA                 ext.l   d0
// ROM:00126DFC                 move.l  d0,-(sp)
// ROM:00126DFE                 ori.b   #$20,d0
// ROM:00126E02                 movem.l -8(a6),a3-a4
// ROM:00126E08                 unlk    a6
// ROM:00126E0A                 rts
	struct TRcloseParams *params = &(dsp->u.closeParams);

	dsp->csCode = dspCLRemove;
	dsp->ioCompletion = compRoutine;

	params->abort = abortFlag;

	return DMFix(PBControl(dsp, async), dsp);
}

OSErr CreateConnectionEnd(TRCCB *ccbPtr,
						  ProcPtr userRoutine,
						  unsigned short   sendQSize,
						  unsigned char    *sendQ,
                  		  unsigned short   recvQSize,
						  unsigned char    *recvQ,
						  unsigned char    *attnPtr,
						  unsigned char    socket,
						  short            drvrRef,
             			  Boolean          async,
						  ProcPtr          compRoutine,
						  DSPParamBlock    *dsp) //26e0c
{
// ROM:00126E0C                 link    a6,#0
// ROM:00126E10                 movem.l a3-a4,-(sp)
// ROM:00126E14                 movea.l $34(a6),a3
// ROM:00126E18                 lea     $22(a3),a4
// ROM:00126E1C                 move.w  $2A(a6),$18(a3)
// ROM:00126E22                 move.w  #$FF,$1A(a3)
// ROM:00126E28                 move.l  $30(a6),$C(a3)
// ROM:00126E2E                 move.l  8(a6),(a4)
// ROM:00126E32                 move.l  $C(a6),4(a4)
// ROM:00126E38                 move.w  $12(a6),8(a4)
// ROM:00126E3E                 move.w  $1A(a6),$E(a4)
// ROM:00126E44                 move.l  $14(a6),$A(a4)
// ROM:00126E4A                 move.l  $1C(a6),$10(a4)
// ROM:00126E50                 move.l  $20(a6),$14(a4)
// ROM:00126E56                 move.b  $27(a6),$18(a4)
// ROM:00126E5C                 move.l  a3,-(sp)
// ROM:00126E5E                 subq.l  #2,sp
// ROM:00126E60                 move.l  a3,-(sp)
// ROM:00126E62                 move.b  $2F(a6),-(sp)
// ROM:00126E66                 ori.b   #$DF,d5
// ROM:00126E6A                 move.w  (sp)+,d0
// ROM:00126E6C                 ext.l   d0
// ROM:00126E6E                 move.l  d0,-(sp)
// ROM:00126E70                 ori.b   #$20,d0
// ROM:00126E74                 movem.l -8(a6),a3-a4
// ROM:00126E7A                 unlk    a6
// ROM:00126E7C                 rts
	struct TRinitParams *params = &(dsp->u.initParams);

	dsp->ioCRefNum = drvrRef;
	dsp->csCode = dspInit;
	dsp->ioCompletion = compRoutine;

	params->ccbPtr = ccbPtr;
	params->userRoutine = userRoutine;
	params->sendQSize = sendQSize;
	params->recvQSize = recvQSize;
	params->sendQueue = sendQ;
	params->recvQueue = recvQ;
	params->attnPtr = attnPtr;
	params->localSocket = socket;

	return DMFix(PBControl(dsp, async), dsp);
}

OSErr OpenConnectionEnd(unsigned short remoteCid,
				        AddrBlock      *remoteAddr,
						AddrBlock      *filterAddr,
						unsigned long  sendSeq,
						unsigned short sendWindow,
						unsigned long  attnSendSeq,
						unsigned char  ocMode,
						Boolean        async,
						ProcPtr        compRoutine,
						DSPParamBlock  *dsp) //26e7e
{
	PPCGlobalParamsPtr ppcglobPtr = getGlobal();
	struct PPCConfigInfo *myptr = &(ppcglobPtr->configData);

	struct TRopenParams *params = &(dsp->u.openParams);

	dsp->csCode = dspOpen;
	dsp->ioCompletion = compRoutine;

	params->remoteAddress.aNet = remoteAddr->aNet;
	params->remoteAddress.aNode = remoteAddr->aNode;
	params->remoteAddress.aSocket = remoteAddr->aSocket;
	params->filterAddress.aNet = filterAddr->aNet;
	params->filterAddress.aNode = filterAddr->aNode;
	params->filterAddress.aSocket = filterAddr->aSocket;
	params->ocMode = ocMode;
	params->sendSeq = sendSeq;
	params->sendWindow = sendWindow;
	params->attnSendSeq = attnSendSeq;
	params->remoteCID = remoteCid;
	params->ocInterval = myptr->adspTimeout;
	params->ocMaximum = myptr->adspRetries;

	return DMFix(PBControl(dsp, async), dsp);

// ROM:00126E7E                 link    a6,#-4
// ROM:00126E82                 movem.l a3-a4,-(sp)
// ROM:00126E86                 movea.l $2C(a6),a3
// ROM:00126E8A                 ori.w   #$9406,a1 // getGlobal
// ROM:00126E8E                 movea.l d0,a4
// ROM:00126E90                 lea     $CC(a4),a0
// ROM:00126E94                 move.l  a0,-4(a6)
// ROM:00126E98                 lea     $22(a3),a4

// ROM:00126E9C                 move.w  #$FD,$1A(a3)
// ROM:00126EA2                 move.l  $28(a6),$C(a3)

// ROM:00126EA8                 movea.l $C(a6),a0
// ROM:00126EAC                 move.w  (a0),4(a4)
// ROM:00126EB0                 movea.l $C(a6),a0
// ROM:00126EB4                 move.b  2(a0),6(a4)
// ROM:00126EBA                 movea.l $C(a6),a0
// ROM:00126EBE                 move.b  3(a0),7(a4)

// ROM:00126EC4                 movea.l $10(a6),a0
// ROM:00126EC8                 move.w  (a0),8(a4)
// ROM:00126ECC                 movea.l $10(a6),a0
// ROM:00126ED0                 move.b  2(a0),$A(a4)
// ROM:00126ED6                 movea.l $10(a6),a0
// ROM:00126EDA                 move.b  3(a0),$B(a4)

// ROM:00126EE0                 move.b  $23(a6),$1E(a4)
// ROM:00126EE6                 move.l  $14(a6),$C(a4)
// ROM:00126EEC                 move.w  $1A(a6),$10(a4)
// ROM:00126EF2                 move.l  $1C(a6),$16(a4)
// ROM:00126EF8                 move.w  $A(a6),2(a4)

// ROM:00126EFE                 movea.l -4(a6),a0
// ROM:00126F02                 move.b  8(a0),$1F(a4) adspTimeout
// ROM:00126F08                 movea.l -4(a6),a0
// ROM:00126F0C                 move.b  9(a0),$20(a4) adspRetries

// ROM:00126F12                 move.l  a3,-(sp)
// ROM:00126F14                 subq.l  #2,sp
// ROM:00126F16                 move.l  a3,-(sp)
// ROM:00126F18                 move.b  $27(a6),-(sp)
// ROM:00126F1C                 ori.b   #$DF,d5
// ROM:00126F20                 move.w  (sp)+,d0
// ROM:00126F22                 ext.l   d0
// ROM:00126F24                 move.l  d0,-(sp)
// ROM:00126F26                 ori.b   #$20,d0
// ROM:00126F2A                 movem.l -$C(a6),a3-a4
// ROM:00126F30                 unlk    a6
// ROM:00126F32                 rts
}

OSErr RemoveConnectionEnd(unsigned char abortFlag,
						  Boolean        async,
						  ProcPtr        compRoutine,
				          DSPParamBlock  *dsp) //26f34
{
	struct TRcloseParams *params = &(dsp->u.closeParams);

	dsp->csCode = dspRemove;
	dsp->ioCompletion = compRoutine;

	params->abort = abortFlag;

	return DMFix(PBControl(dsp, async), dsp);
// ROM:00126F34                 link    a6,#0
// ROM:00126F38                 movem.l a3-a4,-(sp)
// ROM:00126F3C                 movea.l $14(a6),a4
// ROM:00126F40                 lea     $22(a4),a3
// ROM:00126F44                 move.w  #$FE,$1A(a4) dspRemove
// ROM:00126F4A                 move.l  $10(a6),$C(a4)
// ROM:00126F50                 move.b  $B(a6),(a3)
// ROM:00126F54                 move.l  a4,-(sp)
// ROM:00126F56                 subq.l  #2,sp
// ROM:00126F58                 move.l  a4,-(sp)
// ROM:00126F5A                 move.b  $F(a6),-(sp)
// ROM:00126F5E                 ori.b   #$DF,d5
// ROM:00126F62                 move.w  (sp)+,d0
// ROM:00126F64                 ext.l   d0
// ROM:00126F66                 move.l  d0,-(sp)
// ROM:00126F68                 ori.b   #$20,d0
// ROM:00126F6C                 movem.l -8(a6),a3-a4
// ROM:00126F72                 unlk    a6
// ROM:00126F74                 rts
}


OSErr WriteToConnection(unsigned short reqCount,
						unsigned char  *dataPtr,
						unsigned char  eom,
						unsigned char  flush,
						Boolean        async,
						ProcPtr        compRoutine,
						DSPParamBlock  *dsp) //26f76
{
	struct TRioParams *params = &(dsp->u.ioParams);

	dsp->csCode = dspWrite;
	dsp->ioCompletion = compRoutine;

	params->reqCount = reqCount;
	params->dataPtr = dataPtr;
	params->eom = eom;
	params->flush = flush;

	return DMFix(PBControl(dsp, async), dsp);
// ROM:00126F76                 link    a6,#0
// ROM:00126F7A                 movem.l a3-a4,-(sp)
// ROM:00126F7E                 movea.l $20(a6),a4
// ROM:00126F82                 lea     $22(a4),a3
// ROM:00126F86                 move.w  #$F5,$1A(a4)
// ROM:00126F8C                 move.l  $1C(a6),$C(a4)

// ROM:00126F92                 move.w  $A(a6),(a3)
// ROM:00126F96                 move.l  $C(a6),4(a3)
// ROM:00126F9C                 move.b  $13(a6),8(a3)
// ROM:00126FA2                 move.b  $17(a6),9(a3)

// ROM:00126FA8                 move.l  a4,-(sp)
// ROM:00126FAA                 subq.l  #2,sp
// ROM:00126FAC                 move.l  a4,-(sp)
// ROM:00126FAE                 move.b  $1B(a6),-(sp)
// ROM:00126FB2                 ori.b   #$DF,d5
// ROM:00126FB6                 move.w  (sp)+,d0
// ROM:00126FB8                 ext.l   d0
// ROM:00126FBA                 move.l  d0,-(sp)
// ROM:00126FBC                 ori.b   #$20,d0
// ROM:00126FC0                 movem.l -8(a6),a3-a4
// ROM:00126FC6                 unlk    a6
// ROM:00126FC8                 rts
}

OSErr ReadFromConnection(unsigned short reqCount,
						 unsigned char  *dataPtr,
						 Boolean        async,
						 ProcPtr        compRoutine,
						 DSPParamBlock  *dsp) //26fca
{
	struct TRioParams *params = &(dsp->u.ioParams);

	dsp->csCode = dspRead;
	dsp->ioCompletion = compRoutine;

	params->reqCount = reqCount;
	params->dataPtr = dataPtr;

	return DMFix(PBControl(dsp, async), dsp);
// ROM:00126FCA                 link    a6,#0
// ROM:00126FCE                 movem.l a3-a4,-(sp)
// ROM:00126FD2                 movea.l $18(a6),a4
// ROM:00126FD6                 lea     $22(a4),a3

// ROM:00126FDA                 move.w  #$F6,$1A(a4)
// ROM:00126FE0                 move.l  $14(a6),$C(a4)

// ROM:00126FE6                 move.w  $A(a6),(a3)
// ROM:00126FEA                 move.l  $C(a6),4(a3)

// ROM:00126FF0                 move.l  a4,-(sp)
// ROM:00126FF2                 subq.l  #2,sp
// ROM:00126FF4                 move.l  a4,-(sp)
// ROM:00126FF6                 move.b  $13(a6),-(sp)
// ROM:00126FFA                 ori.b   #$DF,d5
// ROM:00126FFE                 move.w  (sp)+,d0
// ROM:00127000                 ext.l   d0
// ROM:00127002                 move.l  d0,-(sp)
// ROM:00127004                 ori.b   #$20,d0
// ROM:00127008                 movem.l -8(a6),a3-a4
// ROM:0012700E                 unlk    a6
// ROM:00127010                 rts
}
