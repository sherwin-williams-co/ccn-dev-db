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
/*------------------------------------------------------------------------------
                               LOAD_STOREDRFT_JV_HST                
Project     : STORE DRAFT
Author      : SXT410
Created on  : 12/12/2014
Purpose     : This Procedure pull data from STOREDRFT_JV and Insert into 
              STOREDRFT_JV_HST table for historical purpose.
--------------------------------------------------------------------------------
Modification History
--------------------
Modified Date         Modified By         Description
--------------------------------------------------------------------------------
------------------------------------------------------------------------------*/
;

END SD_BENEFITS_PKG;