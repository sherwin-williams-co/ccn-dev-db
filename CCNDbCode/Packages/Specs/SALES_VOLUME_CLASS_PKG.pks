CREATE OR REPLACE PACKAGE SALES_VOLUME_CLASS_PKG
AS
/*******************************************************************************
                     SALES_VOLUME_CLASS_PKG
                     
SALES VOLUME CLASS PROCESS is a yearly process which update
SALES_VOLUME_CLASS_CODE for all COST_CENTER.

created : 11/03/2014 SXT410 CCN project
revisions: 
*******************************************************************************/

PROCEDURE SALES_VOL_CLASS_PROC
/*******************************************************************************
                     SALES_VOL_CLASS_PROC
                     
Procedure to update STORE.SALES_VOLUME_CLASS_CODE for matching COST_CENTER_CODE.

created : 11/03/2014 SXT410 CCN project
revisions: 
*******************************************************************************/
;
 
END SALES_VOLUME_CLASS_PKG;