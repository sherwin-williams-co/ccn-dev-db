CREATE OR REPLACE PACKAGE SD_PAIDS_JV_PKG
/******************************************************************************* 
This package will hold all pl/sql objects that are needed to 
create and build the Monthly benefits monthly JV with ADP information
for US and Canada

created  : 07/03/2014 sxh487
revisions: 12/31/2014 sxt410 Added LOAD_STOREDRFT_JV_HST Procedure to capture 
           Historical data.
         : 03/04/2015 sxt410 Renamed package from SD_BENEFIT_JV to SD_PAIDS_JV_PKG
*******************************************************************************/
AS
PROCEDURE CREATE_JV(
/*******************************************************************************
    Create_US_File

This procedure will create JV entries for Benefits file

created : 07/03/2014 sxh487  Storedraft project  
revision: 12/31/2014 sxt410  Calling LOAD_STOREDRFT_JV_HST Procedure to capture
          Historical data and truncating storedrft_jv table to keep only one month data.
          
          01/14/2015 sxt410 Added input parameter IN_CLOSING_DATE instead of sysdate
*******************************************************************************/
IN_CLOSING_DATE IN DATE);
PROCEDURE LOAD_STOREDRFT_JV_HST
/*******************************************************************************
    LOAD_STOREDRFT_JV_HST

This Procedure will captures Historical data from storedrft_jv table
and indicate how many times JV entries has ran for a month.

created : 12/31/2014 sxt410 CCN Project Team
revision: 

*******************************************************************************/
;
END SD_PAIDS_JV_PKG;