CREATE OR REPLACE PACKAGE SD_BENEFITS_PKG
/****************************************************************************** 
This package will hold all pl/sql objects that are needed to 
create and build the Monthly benefits monthly JV with ADP information
for US and Canada

created : 07/03/2014 sxh 

revisions: 
******************************************************************************/
AS

PROCEDURE CREATE_JV
/*****************************************************************************
    Create_US_File

This procedure will create JV entries for Benefits

created : 07/03/2014 sxh  Storedraft project  
revision: 

*****************************************************************************/
;

PROCEDURE LOAD_STOREDRFT_JV_HST
/*****************************************************************************
    LOAD_STOREDRFT_JV_HST

This procedure will load the history JV entries for Benefits file for that run

created : 12/31/2014 sxt410 CCN Project Team
revision: 

*****************************************************************************/
;

END SD_BENEFITS_PKG;