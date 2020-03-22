#
#	Hacks to match MacOS (most recent first):
#
#	<Sys7.1>	  8/3/92	Un-#included the missing files Serial.make and SerialDMA.make
#				  9/2/94	SuperMario ROM source dump (header preserved below)
#

#
#	File:		Drivers.make
#
#	Contains:	makefile for the drivers in ROM
#
#	Written by:	Kurt Clark
#
#	Copyright:	© 1992-1993 by Apple Computer, Inc., all rights reserved.
#
#	Change History (most recent first):
#
#	   <SM2>	 4/11/93	chp		Added SerialDMA.make as a separate entity from Serial.make.
#

SonyDir			=	{DriverDir}Sony:
SerialDir		=	{DriverDir}Serial:
NewAgeDir		=	{DriverDir}NewAge:
IOPDir			=	{DriverDir}IOP:
SerialDMADir	=	{DriverDir}SerialDMA:
EDiskDir		=	{DriverDir}EDisk:
BackLightDir	=	{DriverDir}BackLight:

#include {SonyDir}Sony.make

#include {NewAgeDir}NewAge.make

#include {IOPDir}IOP.make

#include {EDiskDir}EDisk.make

#include {BackLightDir}Backlight.make
