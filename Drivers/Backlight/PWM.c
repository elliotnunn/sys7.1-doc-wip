/*
	Hacks to match MacOS (most recent first):

	<Sys7.1>	  8/3/92	Reverted Horror and SuperMario changes
							Brought Get_AtoD/Get_PGEButton/GetPortableValues/PotControl back from backlightinput.c
							Recreated PWMStatus (similar code to PWMControl)
							Reduced the amount of indirection through global procedure pointers
				  9/2/94	SuperMario ROM source dump (header preserved below)
*/

/*
	File:		PWM.c

	Contains:	This file contains the hardware specific routines to control a PWM-based
				interface found on Asahi, TIM, DB-Lite.

	Written by:	Andy Gong  x6595

	Copyright:	© 1990-1993 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):
	
	   <SM3>	 2/11/93	CSS		Update from Horror.  Comments follow:
	   <H10>	 6/30/92	ag		Moved cpu depended initialization code to cpu.c file, input
									routines to input.c, and table routines to backlight.c file.
		<H9>	 5/26/92	ag		Added write to PONTI to turnoff backlight through PONTI bit.
		<H8>	  5/7/92	ag		Use new table record for min/max limits. Added new entry for
									Dartanian.
		<H7>	 4/24/92	ag		set default to single table operation except on TIM (LC). added
									new vector for custom input control to handle hardware
									dependencies.
		<H6>	12/17/91	SWC		Added boxDBLiteLC to the list in InitPWMControls. Grouped boxTIM
									and boxDartanian since their code is identical.
		<H5>	12/16/91	HJR		Added boxDartanian to the list.
		<H4>	 9/10/91	SWC		Changed Get_AtoD to get the current setting of the up/down
									buttons.
		<H3>	 8/27/91	SWC		Changed references to get/set contrast to use get/set brightness
									on machines other than TIM. On TIM, they used the contrast
									command to control screen brightness. Added PWM table for
									DB-Lite.
		<H2>	  8/5/91	SWC		Changed Get_AtoD to use GetScreenCmd to get the current contrast
									instead of reading from the A-D if not on TIM.
		 <3>	 3/24/92	JSM		Nuke boxFlag codenames.
		 <2>	 3/23/92	JSM		OSEvents.h is obsolete, use Events.h.
		 <1>	10/24/91	SAM/KSM	Rolled in Regatta file.

									Regatta Change History:
								
									 <6>	 8/29/91	SAM		(ag) changed power manager call "BatteryStatusImmCmd" for more
																responsiveness.
									 <5>	 7/18/91	SAM		(ag) changed initialization code.  converted to table only brightness
																levels.
									 <4>	 6/30/91	SAM		Merged from TERROR [<4><5><6><7><8>].
									 <3>	 6/14/91	SAM		(ag) Turnoff backlight at close. Changed low power handling
																code, to rescale pot to lower range.
									 <1>	 5/15/91	SAM		Split off from TERRORProj.
								
									Terror Change History:
								
									 <8>	 6/27/91	ag		fixed bug with init powerbook 100, initialize table based data
																only on table based hardware.
									 <7>	 6/27/91	ag		centralize table determination code "LowTable".
									 <6>	 6/27/91	ag		code clean up.
									 <5>	 6/26/91	ag		added support for table change as a function of charger and
																voltage.
									 <4>	 6/24/91	ag		Changed look up table size to byte elements.  Added software
																scale control.  Added software setting controls.  Added software
																table control.
									 <3>	 6/10/91	ag		Changed low power handling code, to rescale pot to lower range.
									 <2>	  6/5/91	ag		turnoff backlight at close
*/

/*page*/
/************************************/
/***  INCLUDE FILES DECLARATIONS  ***/


#include <SysEqu.h>
#include <types.h>
#include <memory.h>
#include <Events.h>
#include <devices.h>
#include <errors.h>
#include <retrace.h>
#include <Shutdown.h>
#include <stdlib.h>

#include "PowerMgr.h"
#include "backlight.h"

/* <Sys7.1> copied from backlightcpu.c */
#define	BACKLIGHT_POT_CHANNEL	0
#define STATUS					0
#define POWERBYTE				1
#define TEMPBYTE				2

/* <Sys7.1> reclaimed from backlightinput.c */
#define	READ_ATOD_CHANNEL	0xD8
#define	READ_BUTTON_VALUE	0xD9
extern short			PotInputRangeShiftTblPWM[];

/* <Sys7.1> enable access to these assembly "procedures" (really tables) */
extern unsigned char	timTblLow[];
extern unsigned char	timTbl[];
extern unsigned char	asahiTbl[];
extern short			PWMMaxTbl[];

/*page
 ***************************************************************************************************
 ** PWM software ***********************************************************************************
 ***************************************************************************************************
 */

/* <Sys7.1> don't return OSErr */
/* <Sys7.1> reverted to old-style tables despite <H8> */
void InitPWMControls(driverGlobalPtr	globalPtr)

{
	unsigned int	startvalue;
	int boxFlag;

	/* <Sys7.1> setup default values */
	globalPtr->flyByWire = true;
	globalPtr->freeflag = true;
	globalPtr->dualTable = true;
	globalPtr->userInputSampleRate = 10;
	globalPtr->maximumTable = &PWMMaxTbl;
	globalPtr->settingTableLow = &timTblLow;
	globalPtr->settingTable = globalPtr->settingTableHigh = &timTbl;

	/* <Sys7.1> override for some specific machines */
	boxFlag = *(unsigned char *)0xCB3;
	switch (boxFlag)
		{
		case 18: // PowerBook 100, Asahi
			globalPtr->freeflag = false;
			globalPtr->dualTable = false;
			globalPtr->settingTable = &asahiTbl;
			break;
		case 15: // PowerBook 170, TIM
			if (*JAWS_SPEED_FSTN_REG_PTR & JAWS_FSTN)
				globalPtr->dualTable = false;
			break;
		}

	/* initialize dual table variables */
	if (globalPtr->dualTable) 
		{
		globalPtr->slewLimit		= true;				/* maximum change per/accrun */

		/* <Sys7.1> determine table directly instead of using a tableProc */
		globalPtr->lowThreshold		= 163;
		globalPtr->hiThreshold		= 173;
		globalPtr->tableProc		= ChargerAdjust;
		globalPtr->lowTable			= LowTable(globalPtr);
		if (globalPtr->lowTable)
			globalPtr->settingTable = globalPtr->settingTableLow;
		};

	/* <Sys7.1> not really sure why these procs weren't being set */
	globalPtr->setlevelproc = SetPWM;
	globalPtr->userInputProc = PotControl;
	globalPtr->closeProc = PWMCloseRoutine;
	globalPtr->controlProc = PWMControl;
	globalPtr->statusProc = PWMStatus;

	/* initialize backlight hardware */	
	startvalue 						= PotControl(globalPtr);								/* <H8> */
	globalPtr->userBrightness 		= -1;
	globalPtr->userBrightness 		= SetPWM(startvalue,globalPtr);							/* <H8> */
};

/*
 ***************************************************************************************************
 *
 *
 ***************************************************************************************************
 */
int PWMCloseRoutine (driverGlobalPtr	globalPtr)

{
	SetPWM(0,globalPtr);																	/* <Sys7.1> no global setlevelproc */
	return(0);
};

/*
 ***************************************************************************************************
 *
 *
 ***************************************************************************************************
 */

/* <Sys7.1> moved from bottom of file and edited */
/* <Sys7.1> reverted to old-style tables despite <H8> */
int SetPWM(int	new,driverGlobalPtr	globalPtr)
{
	PMgrPBlock		pb;									/* power manager pb */
	unsigned char	val;								/* hardware value setting */
	
	PEG_TO_LIMITS(new, globalPtr->maximumTable[globalPtr->powerRange], 0);	/* <H8> use new tables */				/* limit value to valid range */
	val = globalPtr->settingTable[new];					/* look up value from table */

	if ((globalPtr->userBrightness >= 0) && (val == globalPtr->lastHWSetting)) return(new);/* nothing to do; 90/05/15 just turn on; 90/07/02 avoid touching */
	if (globalPtr->slewChange)
		{
		if (abs(globalPtr->lastHWSetting - val) > globalPtr->slewLimit)
			val = globalPtr->lastHWSetting + ((globalPtr->lastHWSetting > val) ? -globalPtr->slewLimit : globalPtr->slewLimit);
		else
			globalPtr->slewChange = false;
		};
	globalPtr->lastHWSetting	= val;					/* save the new hardware setting */

	pb.pmgrCmd					= ScreenSetCmd;			/* <Sys7.1> don't do what they do */ /*  everyone else uses "set brightness" */
	pb.pmgrCnt					= 1;
	pb.pmgrXPtr 				= &val;
	pb.pmgrRPtr 				= nil;
	PMgr(&pb);											/* set the pwm */

	return(new);										/* return the current value */
};

/*page
 ***************************************************************************************************
 *
 *
 ***************************************************************************************************
 */

/* <Sys7.1> verbatim from backlightinput.c */
unsigned char Get_AtoD(int	channel)
{
	PMgrPBlock		pb;									/* power manager pb */
	char			atodChannel;						/* a to d channel to read [0-8] */
	unsigned char	value;								/* return value */
	OSErr			error;								/* pmgr error */


	atodChannel	= channel;								/* load channel value into buffer */

	pb.pmgrCmd	= READ_ATOD_CHANNEL;					/* load read channel command */
	pb.pmgrCnt	= 1;									/* transmit buffer count is 1 byte */
	pb.pmgrXPtr = &atodChannel;							/* pointer to transmit buffer */
	pb.pmgrRPtr = &value;								/* pointer to receive buffer */
	
	error = PMgr(&pb);

	return( (error) ? 0 : value);
};

/*page
 ***************************************************************************************************
 *
 *
 ***************************************************************************************************
 */

/* <Sys7.1> verbatim from backlightinput.c */
unsigned char Get_PGEButton(int	channel)
{
	PMgrPBlock		pb;									/* power manager pb */
	char			atodChannel;						/* a to d channel to read [0-8] */
	unsigned char	value;								/* return value */
	OSErr			error;								/* pmgr error */


	atodChannel	= channel;								/* load channel value into buffer */

	pb.pmgrCmd	= READ_BUTTON_VALUE;					/* load read channel command */
	pb.pmgrCnt	= 1;									/* transmit buffer count is 1 byte */
	pb.pmgrXPtr = &atodChannel;							/* pointer to transmit buffer */
	pb.pmgrRPtr = &value;								/* pointer to receive buffer */
	
	error = PMgr(&pb);

	return( (error) ? 0 : value);
};

/*page
 ***************************************************************************************************
 *
 *
 ***************************************************************************************************
 */
/* <Sys7.1> verbatim from backlightinput.c */
unsigned char GetPortableValues(int	parameter)
{

	PMgrPBlock		pb;									/* power manager pb */
	OSErr			err;								/* power manager error */
	unsigned char	rbuf[3];							/* buffer for send command */

	pb.pmgrCmd = BatteryStatusImmCmd;					/* on old pmgr, read battery status (immediate not averaged) */
	pb.pmgrCnt = 0;
	pb.pmgrXPtr = nil;
	pb.pmgrRPtr = rbuf;

	err = PMgr(&pb);
	return( (err) ? 0 : rbuf[parameter]);				/* return 0 if error, else read value */
}

/*page
 ***************************************************************************************************
 *
 *
 ***************************************************************************************************
 */
/* <Sys7.1> modified from backlightinput.c */
int PotControl (driverGlobalPtr	globalPtr)

{
#pragma	unused (globalPtr)

	unsigned int	potvalue;
	
	/* <Sys7.1> no proc for this in driver globals */
	potvalue = globalPtr->freeflag ? Get_AtoD(BACKLIGHT_POT_CHANNEL) : GetPortableValues(TEMPBYTE);

	if (abs(globalPtr->lastatod - potvalue) <= 5) 		/* was the change less than 100mv */
		potvalue = globalPtr->lastatod;					/* is less than, the use old value */

	globalPtr->lastatod = potvalue;						/* update last a to d value */
	potvalue >>= 3;										/* scale to 0 to 31 */
	if (potvalue)										/* if non-zero, check for subrange limiting */
		{
		potvalue >>= PotInputRangeShiftTblPWM[globalPtr->powerRange]; /* rescale in low power levels */
		if (!potvalue) potvalue = 1;					/* make sure we don't change the backlight state */
		};
	return(potvalue);
};

/*page
 ***************************************************************************************************
 *
 * The control routine…
 *
 *	return:
 *		noErr		- task completed successfully
 *		controlErr	- illegal control selector
 *
 *
 ***************************************************************************************************
 */
OSErr PWMControl(CntrlParam *ctlPB,driverGlobalPtr	globalPtr)		/* 'open' entry point */

{
	int 		error;
	int			tempvalue;

	error	= noErr;

	if (!globalPtr->disableHWinput)						/* if hardware not disabled, error */
		error = controlErr;
	else
		switch(ctlPB->csCode) 
			{
			case kSetScreenBrightness:					/* set brightness level */
				tempvalue = ctlPB->csParam[0];
				globalPtr->userBrightness 	= SetPWM(tempvalue,globalPtr);	/* <Sys7.1> no proc for this in driver globals */
				break;
				
			default:
				error = controlErr;
			};

	return(error);
};

/*page
 ***************************************************************************************************
 *
 * The status routine…
 *
 *	return:
 *		noErr		- task completed successfully
 *		statusErr	- illegal status selector
 *
 *
 ***************************************************************************************************
 */

/* <Sys7.1> recreated from scratch */
OSErr PWMStatus(CntrlParam *ctlPB,driverGlobalPtr	globalPtr)
{
	OSErr 		error;

	error	= noErr;

	switch(ctlPB->csCode) 
		{
		case kGetScreenBrightness:						/* get brightness level */
			ctlPB->csParam[0] = globalPtr->userBrightness;
			break;
			
		case kGetBrightnessRange:
			ctlPB->csParam[0] = 31;
			ctlPB->csParam[1] = 0;
			break;

		case kGetMaximum:
			ctlPB->csParam[0] = globalPtr->maximumTable[globalPtr->powerRange];
			break;

		default:
			error = statusErr;
		};

	return(error);
}
