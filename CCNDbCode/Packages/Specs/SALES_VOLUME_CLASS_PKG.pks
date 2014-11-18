CREATE OR REPLACE PACKAGE COSTCNTR.SALES_VOLUME_CLASS_PKG
AS
/*------------------------------------------------------------------------------
                               SALES_VOLUME_CLASS_PKG                
Project     : CCN
Author      : SXT410
Created on  : 11/03/2014
Purpose     : SALES VOLUME CLASS PROCESS is a yearly process which update
              SALES_VOLUME_CLASS_CODE for all COST_CENTER.
--------------------------------------------------------------------------------
Modification History
--------------------
Modified Date         Modified By         Description
--------------------------------------------------------------------------------
------------------------------------------------------------------------------*/
PROCEDURE SALES_VOL_CLASS_PROC;    
END SALES_VOLUME_CLASS_PKG;
/