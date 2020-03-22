/*
	Hacks to match MacOS (most recent first):

	<Sys7.1>	  8/3/92	Reverted Horror and SuperMario changes
							Brought ChargerAdjust/LowTable back from backlight.c
				  9/2/94	SuperMario ROM source dump (header preserved below)
*/

/*
	File:		register.c

	Contains:	Register control for backlight.

	Written by:	Andy Gong  x6595

	Copyright:	© 1991-1993 by Apple Computer, Inc., all rights reserved.

	Change History (most recent first):

	   <SM5>	12/13/93	PN		Roll in KAOs and Horror changes to support Malcom and AJ
									machines
	   <SM4>	 2/11/93	CSS		Update from Horror.  Comments follow:
		<H4>	 6/30/92	ag		Moved cpu depended initialization code to cpu.c file, and input
									routines to input.c.
		<H3>	  5/7/92	ag		Use new table record for min/max limits.
		<H2>	 4/24/92	ag		return error from initialization.
		 <2>	 3/23/92	JSM		OSEvents.h is obsolete, use Events.h.
		 <1>	10/24/91	SAM/KSM	Rolled in Regatta file.
	
									Regatta Change History:
							
									 <8>	 8/21/91	SAM		Undid the last mod.  Using GetKeys again.
									 <7>	 8/19/91	SAM		(ag) added a key repeat delay to the key processing stuff.
									 <6>	 7/30/91	SAM		(ag) removed special initialization code in set brightness,
																changed type of pram value to int to allow for negative error
																check.
									 <5>	 7/18/91	SAM		(ag) cleaned up initialization code.
									 <4>	 6/30/91	SAM		Merged from TERROR [<5>].
									 <3>	 6/14/91	SAM		(ag) added support in set level routine to handle passing in an
																illegal value as a flag to indicated initialization. Changed low
																power handling, get input and set output routines will key off
																of power state.
									 <1>	 5/15/91	SAM		Split off from TERRORProj.
								
									Terror Change History:
								
									 <5>	 6/24/91	ag		Changed init code to initialize to user value.  Changed calling
																structure for setting backlight.  Changed lookup tables to byte
																size elements.
									 <4>	 6/10/91	ag		Changed low power handling, get input and set output routines
																will key off of power state.
									 <3>	 5/10/91	ag		added support in set level routine to handle passing in an
																illegal value as a flag to indicated initialization.
									 <2>	 4/23/91	ag		cleaned up init code, moved initial code to main (backlight.c).
*/

#define PORTABLE_HW			0xFC0202

/*page*/
/************************************/
/***  INCLUDE FILES DECLARATIONS  ***/


#include <SysEqu.h>
#include <types.h>
#include <traps.h>
#include <memory.h>
#include <Events.h>
#include <OSUtils.h>
#include <devices.h>
#include <errors.h>
#include <Shutdown.h>
#include <Stdlib.h>

#include "PowerMgr.h"
#include "backlight.h"

void 			SleepEntry();

// *** backlight stuff	
#define ON_BIT				0x02					/*  0 = off, 1 = on*/
#define L_CS_BIT			0x20					/*  0 = select chip to accept data */
#define	COUNTDN_BIT			0x40					/*  0 = down, 1 = up */
#define COUNT_BIT			0x80					/*  1 - 0 - 1 pulsed to count */
#define ALL_BITS			COUNT_BIT + COUNTUP_BIT + L_CS_BIT

#define SELECT(backlightreg,value)	value &= (~L_CS_BIT); *backlightreg = value
#define DESELECT(backlightreg,value)	value |= L_CS_BIT	; *backlightreg = value

#define MAXSTROBECOUNT		256
#define MAXPOTVALUE			255						/* maximum value of digital pot */
#define MINPOTVALUE			0						/* maximum value of digital pot */

/* brightness boundaries */
#define kMaxBrightness			30		/* <5> maximum brightness */
#define kMinBrightness			0		/* minimum brightness */


#define	REPEATTIME			5
#define REPEATTHRESHOLD		1

#define	BACKLIGHT_ON		true
#define BACKLIGHT_OFF		false

#define	SLEEPQELEMENTTYPE		16


//	*** keyboard stuff
#define	KEYDOWNTEST(keynum,map)	(map[keynum >> 3] & (1 << (keynum % 8)))
#define	KEYDOWNBYTETEST(bytenum,keymask,map)	(map[bytenum] & keymask)

#define	UPARROW				0x7E
#define DOWNARROW			0x7D
#define	RIGHTARROW			0x7C
#define LEFTARROW			0x7B

#define BYTEMASK_7_CTL		0x88
#define BYTEMASK_7_OPT		0x44
#define BYTEMASK_7_SFT		0x11

typedef	struct
	{
	long				oldvector;
	char				keysActive;
	char				keymodifiers;
	short				unused;
	} posteventtype, *posteventtypeptr;
extern posteventtype	postEventData;
extern unsigned char	PortableTbl5V[];
extern unsigned char	PortableTable7V[];
extern short			PortableMaxTbl[];

int		GetBacklightInfo(short	mask, short shift);
void	SaveBacklightInfo(short new,short	mask, short shift);

		TurnOnOff(Boolean on);
		setNewKeys(int		keycombo);

/*page
 ***************************************************************************************************
 *
 *
 ***************************************************************************************************
 */
/* <Sys7.1> verbatim from backlight.c */
void ChargerAdjust  (driverGlobalPtr	globalPtr)
{		
	unsigned int				oldTable;

	oldTable			= globalPtr->lowTable;					/* save the current table being used */
	globalPtr->lowTable =  LowTable(globalPtr);					/* get the new table to use */
	if (globalPtr->lowTable == oldTable) return;				/* are we changing tables ???, no exit */

	globalPtr->slewChange		= true;							/* if change, set tmp slew on */					
	globalPtr->settingTable		= globalPtr->lowTable ? globalPtr->settingTableLow :globalPtr->settingTableHigh ;							
};

/*page
 ***************************************************************************************************
 *
 *
 ***************************************************************************************************
 */
/* <Sys7.1> verbatim from backlight.c */
unsigned int LowTable  (driverGlobalPtr	globalPtr)

{
	PmgrGlobals					**pmgrglobalhdl;				/* handle to power manager globals */
	Boolean						wasLowTable;					/* current table being used */
	Boolean						hiTable;						/* use hi level table  now */

	pmgrglobalhdl 	= (PmgrGlobals **) 0x0D18;					/* handle to power manager globals */

	wasLowTable		= globalPtr->lowTable;						/* current table */
	hiTable 		= false;									/* assume low table */
	if ((wasLowTable && ((*pmgrglobalhdl)->BatAvg >= globalPtr->hiThreshold)) ||
		(!wasLowTable && ((*pmgrglobalhdl)->BatAvg >= globalPtr->lowThreshold)))
		{
		hiTable = (*pmgrglobalhdl)->Charger & 0x01;				/* qualify table with charger */
		};
	return(hiTable ? 0 : 1);									/* return 1 if low table, 0 if high */
};

/*page
 ***************************************************************************************************
 ** Register control software **********************************************************************
 ***************************************************************************************************
 */

/* <Sys7.1> don't return OSErr */
/* <Sys7.1> reverted to old-style tables despite <H3> */
void InitRegControls(driverGlobalPtr	globalPtr)

{
	int					SetBrightness();
	int					KbdControl();
	int					RegisterClose();
	OSErr				RegisterStatus(CntrlParam *, driverGlobalPtr);
	OSErr				RegisterControl(CntrlParam *, driverGlobalPtr);
	int					pramBrightness;
	void				ShutdownBacklight();
	posteventtypeptr	postdataptr;

	
	postdataptr = &postEventData;
	postdataptr->keysActive = 0;
	postdataptr->keymodifiers = 0;

	globalPtr->userInputSampleRate = 1;

	globalPtr->settingTable = (BACKLIGHTSIGREG & TABLE_5V) ? PortableTbl5V : PortableTable7V;

	globalPtr->maximumTable = &PortableMaxTbl;
	globalPtr->setlevelproc = SetBrightness;
	globalPtr->userInputProc = KbdControl;
	globalPtr->closeProc = RegisterClose;
	globalPtr->statusProc = RegisterStatus;
	globalPtr->controlProc = RegisterControl;

	globalPtr->keycodes 		= GetPramKeyData();
	pramBrightness 				= GetPramBrightness();	/* get pram setting */

	setNewKeys(globalPtr->keycodes);
	if (pramBrightness < 0) 									/* check for valid brightness value */
		{
		pramBrightness = 1;													/* <H3> load default brightness */
		SaveBrightness(1);													/* <H3> validate, as save new brightness */
		};


	globalPtr->userBrightness	= 30;										/* <H3> */
	globalPtr->lastHWSetting	= globalPtr->settingTable[30];
	globalPtr->userBrightness 	= SetBrightness(0,globalPtr);				/* <H3> initialize pot */
	globalPtr->userBrightness 	= SetBrightness(pramBrightness,globalPtr);	/* set brightness level */
	
	if (BACKLIGHTSIGREG == BACKLIGHTSIG_UPGRD)
		{
		globalPtr->sleepQelement.sleepQType		= SLEEPQELEMENTTYPE;
		globalPtr->sleepQelement.sleepQProc		= (ProcPtr) SleepEntry;
		SleepQInstall(&globalPtr->sleepQelement);					/* install sleep task */
		};

	ShutDwnInstall( (ShutDwnProcPtr) ShutdownBacklight,sdRestartOrPower);	/* install shutdown task */
};

/*page
 ***************************************************************************************************
 *
 *
 ***************************************************************************************************
 */
void StrobeCount(char *backlightreg, int number, unsigned char value)
	{
	int		index;

	if (!number) return;							/* return if no strobes */
	value |= COUNT_BIT;								/* start with count inactive */
	for (index = (number << 1); index; index--)		/* <15>  write twice for each pulse  <90/08/01>*/
		{
		value ^= COUNT_BIT;							/* toggle count bit */
		*backlightreg = value;						/* write value */
		}
	};

/*page
 ***************************************************************************************************
 *
 *
 ***************************************************************************************************
 */
void ShutdownBacklight()
	{
	TurnOnOff(BACKLIGHT_OFF);
	};

/*page
 ***************************************************************************************************
 *
 *	This sleep task is necessary due to the fact CPU hardware changed the design of the board and
 *	power to the backlight is nolonger turned off by the hardware at sleep or shutdown (yuck!).
 *	Therefore software MUST turn off the backlight for now. ( 90/07/20 ag )
 *
 *
 ***************************************************************************************************
 */
void Sleep_Task(driverGlobalPtr	globalPtr, int		selector)
{

#define	SLEEPQELEMENTTYPE		16

#define	SLEEP_REQUEST		1
#define	SLEEP_DEMAND		2
#define	SLEEP_WAKEUP		3
#define SLEEP_REQ_ABORT		4

	switch (selector)
		{
		case	SLEEP_DEMAND:
					globalPtr->vbl_ok = false;
					TurnOnOff(BACKLIGHT_OFF);
					break;

		case	SLEEP_WAKEUP:
					if (globalPtr->userBrightness) TurnOnOff(BACKLIGHT_ON);
					globalPtr->vbl_ok = true;
					break;

		case	SLEEP_REQ_ABORT:
		case 	SLEEP_REQUEST:
		default:
					break;
		};
};

/*
 ***************************************************************************************************
 *
 *
 ***************************************************************************************************
 */
TurnOnOff(Boolean on)
	{
	unsigned char	regvalue;
	char			*backlightreg;
	Boolean			onBitHigh;

	backlightreg 	= (Ptr) PORTABLE_HW;
	onBitHigh		= (BACKLIGHTSIGREG & ON_HIGH);

	regvalue 			= COUNT_BIT + L_CS_BIT;		/* start with count and CS inactive */
	if ((onBitHigh && on) || (!onBitHigh && !on))
		regvalue |= ON_BIT; 						/* upgrade has opposite polarity */
	*backlightreg 		= regvalue;					/* write value */
	};

/*page
 ***************************************************************************************************
 *
 *
 ***************************************************************************************************
 */
/* <Sys7.1> reverted to old-style tables despite <H3> */
int SetBrightness(int	new, driverGlobalPtr	globalPtr)
	{
	unsigned char	regvalue;
	int				strobes;
	char			*backlightreg;
	char			signature;
	Boolean			onBitHigh;
	Boolean			countDownBit;
	unsigned char	tablevalue;
	Boolean			initialize;



	initialize = (globalPtr->userBrightness < 0);
	PEG_TO_LIMITS(new, globalPtr->maximumTable[globalPtr->powerRange], 0);	/* <H3> limit value to valid range */

	tablevalue = globalPtr->settingTable[new];		/* <H3> look up value from table */
	if (tablevalue == globalPtr->lastHWSetting)
		return(new);								/* nothing to do; 90/05/15 just turn on; 90/07/02 avoid touching */

	/* setup control bits */
	signature 		= BACKLIGHTSIGREG;
	onBitHigh		= (signature & ON_HIGH);
	countDownBit	= (signature & COUNT_DWNBIT);
	backlightreg 	= (Ptr) PORTABLE_HW;
	regvalue		= COUNT_BIT + L_CS_BIT;			/* start with count and CS inactive */

	if ((onBitHigh && new) || (!onBitHigh && !new))	/* <H3> */
		regvalue |= ON_BIT; 						/* upgrade has opposite polarity */

	if ((countDownBit && (new <= globalPtr->userBrightness)) || (!countDownBit && (new >= globalPtr->userBrightness)))
		regvalue |= COUNTDN_BIT;	/* set the count down bit if new > current */

	strobes = (new == 0)  							/* <H3> */
				? MAXSTROBECOUNT					/* if minimum, bang against stops */
				: abs(globalPtr->lastHWSetting - tablevalue);

	SELECT(backlightreg,regvalue);					/* assert chip select */
	StrobeCount(backlightreg,strobes,regvalue);		/* strobe count line */
	DESELECT(backlightreg,regvalue);				/* deassert chip select */

	globalPtr->lastHWSetting = tablevalue;			/* save the hardware setting */

	return(new);
};

/*page
 ***************************************************************************************************
 *
 *			bit        2     1     0
 *					+-----+-----+-----+
 *					|     |     |     |
 *					| opt | sft | ctl |
 *					|     |     |     |
 *					+-----+-----+-----+
 *
 *	90/12/18	ag	recoded key down check.
 *
 *
 *
 ***************************************************************************************************
 */
Boolean KeysDown(int	value, char		kbdmap[])
	
{
#define CONTROLBIT	0x01;
#define SHIFTBIT	0x02;
#define OPTIONBIT	0x04;

	int						keysDown;
	
	if (!value) return (false);					/* no key combinations */

	keysDown = 0;
	if (kbdmap[7] & BYTEMASK_7_CTL) keysDown += CONTROLBIT;
	if (kbdmap[7] & BYTEMASK_7_SFT) keysDown += SHIFTBIT;
	if (kbdmap[7] & BYTEMASK_7_OPT) keysDown += OPTIONBIT;

	return((keysDown == value));
};

/*page
 ***************************************************************************************************
 *
 *
 ***************************************************************************************************
 */
int KbdControl (driverGlobalPtr	globalPtr)

{
	char						kbdmap[16];
	int							delta;
	int							returnValue;
	int							maximum;

	returnValue = globalPtr->userBrightness;
	
	maximum = globalPtr->maximumTable[globalPtr->powerRange];
	if (globalPtr->userBrightness > maximum)
		return(maximum);

	GetKeys((KeyMap) &kbdmap[0]);
//	postdataptr 				= &postEventData;
//	if (!postdataptr->keysActive)
	if (!KeysDown(globalPtr->keycodes,kbdmap))
		{
		globalPtr->mousedownTicks 	= 0;						/* no mouse event */
		globalPtr->kbdactive		= false;					/* kbd control cancel */							
		}
	else 
		{
		globalPtr->mousedownTicks += 1;								/* increment mouse down time */
		if (globalPtr->mousedownTicks > ((globalPtr->kbdactive) ? REPEATTIME : REPEATTHRESHOLD) )
			{
			globalPtr->kbdactive		= true;							
			globalPtr->mousedownTicks 	= 1;
			delta = 0;
	
			if (KEYDOWNTEST(UPARROW,kbdmap) 	|| KEYDOWNTEST(RIGHTARROW,kbdmap)) 	delta = 1;
			if (KEYDOWNTEST(DOWNARROW,kbdmap) 	|| KEYDOWNTEST(LEFTARROW,kbdmap)) 	delta = -1;
	
			if ((globalPtr->userBrightness+delta) > maximum)
				delta = 0;
			if ((globalPtr->userBrightness+delta) < 0 )
				delta = 0;
			returnValue = globalPtr->userBrightness + delta;
			};
		};
	return(returnValue);
};

/*page
 ***************************************************************************************************
 *
 *
 ***************************************************************************************************
 */
/* <Sys7.1> reverted to old-style tables despite <H3> */
int RegisterClose (driverGlobalPtr	globalPtr)

{
	globalPtr->userBrightness 	= 30;							/* <H3> */
	globalPtr->userBrightness 	= SetBrightness(0,globalPtr);	/* <H3> initialize pot */

	SleepQRemove(&globalPtr->sleepQelement);					/* remove sleep task */
	ShutDwnRemove( (ShutDwnProcPtr) ShutdownBacklight);			/* remove shutdown task */

//	NSetTrapAddress(postdataptr->oldvector,_PostEvent,OSTrap); 

	return(0);
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
OSErr RegisterControl(CntrlParam *ctlPB,driverGlobalPtr	globalPtr)		/* 'open' entry point */

{
#pragma	unused (ctlPB)
	int 						error;
	int							tempvalue;

	error				= noErr;
	switch(ctlPB->csCode) 
		{
		case kSetScreenBrightness:										/* set brightness level */
			tempvalue = ctlPB->csParam[0];
			globalPtr->userBrightness 	= SetBrightness(tempvalue,globalPtr);	/* <Sys7.1> no proc for this in driver globals */
			break;
		case kSaveScreenBrightness:										/* save brightness level */
			SaveBrightness(globalPtr->userBrightness);
			break;
		case kSetBrightnessKeys:
			tempvalue = ctlPB->csParam[0];
			globalPtr->keycodes	= tempvalue & KEY_VALUE_MASK;			/* limit value to key code range */

			setNewKeys(globalPtr->keycodes);


			break;
		case kSavePKeys:
			SaveKeyData(globalPtr->keycodes);
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
 *		statusErr	- illegal control selector
 *
 ***************************************************************************************************
 */
OSErr RegisterStatus(CntrlParam *ctlPB,driverGlobalPtr	globalPtr)			/* 'open' entry point */

{

	short 						error;	

	error	= noErr;
	switch(ctlPB->csCode) 
		{
		case kGetScreenBrightness:								/* <Sys7.1> */
			ctlPB->csParam[0] = globalPtr->userBrightness;
			break;
		case kGetBrightnessKeys:								/* return current saved brightness */
			ctlPB->csParam[0] = globalPtr->keycodes;
			break;
		case kGetBrightnessRange:								/* <Sys7.1> */
			ctlPB->csParam[0] = 30;
			ctlPB->csParam[1] = 0;
			break;
		case kGetPBacklight:
			ctlPB->csParam[0] = GetPramBrightness();
			break;
		case kGetPKey:
			ctlPB->csParam[0] = GetPramKeyData();
			break;
		case kGetMaximum:										/* <Sys7.1> */
			ctlPB->csParam[0] = globalPtr->maximumTable[globalPtr->powerRange];
			break;

		default:
			error = statusErr;
		};
	return(error);
}

setNewKeys(int		keycombo)

{
	char						newKey;
	posteventtypeptr			postdataptr;

	newKey			= 0;
	if (keycombo & 0x01) newKey |= 0x10;
	if (keycombo & 0x02) newKey |= 0x02;
	if (keycombo & 0x04) newKey |= 0x08;
	
	/* <Sys7.1> would interact with (alas unused) MyPostEvent patch */
	postdataptr = &postEventData;
	postdataptr->keymodifiers = newKey;
};

