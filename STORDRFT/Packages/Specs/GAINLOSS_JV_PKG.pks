create or replace PACKAGE GAINLOSS_JV_PKG
/****************************************************************************** 
This package will hold all pl/sql objects that are needed to 
create and build the Monthy GAINLOSS_JV

created : 11/24/2014 NXK927

revisions: 
******************************************************************************/
AS

PROCEDURE CREATE_GAINLOSS_JV(
/*****************************************************************************
	CREATE_GAINLOSS_JV

This procedure will create JV entries for GAIN AND LOSS

created : 11/24/2014 NXK927 
revision: 

*****************************************************************************/
IN_DATE    IN DATE);

END GAINLOSS_JV_PKG;

