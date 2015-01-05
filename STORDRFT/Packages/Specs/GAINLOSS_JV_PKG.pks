create or replace 
PACKAGE          GAINLOSS_JV_PKG
/****************************************************************************** 
This package will hold all pl/sql objects that are needed to 
create and build the Monthly GAINLOSS_JV

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

PROCEDURE LOAD_SD_GAIN_LOSS_JV_HST(
/*****************************************************************************
    LOAD_SD_GAIN_LOSS_JV_HST

This procedure will load the history JV gain loss entries for Benefits file for that run

created : 12/31/2014 sxt410 CCN Project Team
revision: 

*****************************************************************************/
IN_DATE    IN DATE);

FUNCTION IS_CC_JV_GAIN_LOSS_ELIGIBLE(
/***********************************************************
This Procedure determine if a cost center needs to be included in JV or not
      
Created : 12/19/2014 jxc517 CCN Project.....
Modified: 
************************************************************/
    IN_COST_CENTER_CODE       IN     VARCHAR2,
    IN_DATE                   IN     DATE) RETURN VARCHAR2;

END GAINLOSS_JV_PKG;