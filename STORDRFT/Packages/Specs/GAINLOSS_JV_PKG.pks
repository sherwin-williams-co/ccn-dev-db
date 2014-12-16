CREATE OR REPLACE PACKAGE STORDRFT.GAINLOSS_JV_PKG
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

PROCEDURE LOAD_GAINLOSS_JV_HST
/*------------------------------------------------------------------------------
                               LOAD_GAINLOSS_JV_HST                
Project     : STORE DRAFT
Author      : SXT410
Created on  : 12/16/2014
Purpose     : This Procedure pull data from GAINLOSS_JV and Insert into 
              GAINLOSS_JV_HST table for historical purpose.
--------------------------------------------------------------------------------
Modification History
--------------------
Modified Date         Modified By         Description
--------------------------------------------------------------------------------
------------------------------------------------------------------------------*/
;

END GAINLOSS_JV_PKG;
/