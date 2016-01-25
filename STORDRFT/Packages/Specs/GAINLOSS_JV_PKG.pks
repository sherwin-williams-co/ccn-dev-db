create or replace PACKAGE GAINLOSS_JV_PKG
/****************************************************************************** 
This package will hold all pl/sql objects that are needed to 
create and build the Monthly GAINLOSS_JV

created  : 11/24/2014 NXK927 
revisions: 12/31/2014 sxt410 Added LOAD_SD_GAIN_LOSS_JV_HST Procedure to capture 
           Historical data.
******************************************************************************/
AS

PROCEDURE CREATE_GAINLOSS_JV(
/*****************************************************************************
    CREATE_GAINLOSS_JV
    
This procedure will create JV entries for GAIN AND LOSS

created : 11/24/2014 NXK927 
revision: 12/09/2014 jxc517 CCN Project.....
          Modified the cursor to pick correct data, added input parameter which should be
          first of the month on which we are running the report
          Example for november JV run it should be 01-DEC-2014.
          
          12/31/2014 sxt410  Calling LOAD_SD_GAIN_LOSS_JV_HST Procedure to capture
          Historical data and truncating Gainloss_jv table to keep only one month data.
*****************************************************************************/
IN_DATE    IN DATE);

PROCEDURE LOAD_SD_GAIN_LOSS_JV_HST(
/*****************************************************************************
    LOAD_SD_GAIN_LOSS_JV_HST

This procedure will load the history JV gain loss entries for Benefits file for that run

created : 12/31/2014 sxt410 CCN Project Team
revision: 

*****************************************************************************/
IN_DATE    IN DATE);

PROCEDURE CREATE_GAINLOSS_UNBOOKED_RPRT(
/*****************************************************************************
This procedure will create JV unbooked entries for GAIN AND LOSS

created : 01/11/2016 jxc517 CCN Project Team....
revision: 
*****************************************************************************/
IN_DATE    IN DATE);

END GAINLOSS_JV_PKG;

