create or replace PACKAGE CCN_HISTORY
/*********************************************************** 
This package is will return data for HISTORY detail 

created : 
************************************************************/
    AS
	 	TYPE REF_CURSOR IS REF CURSOR;

		
PROCEDURE RETURN_HIERARCHY_HIST(
 /**********************************************************
 	RETURN_HIERARCHY_HIST
 
 	This procedure will return a ref cursor with data from 
 	from the hierarchy_detail_hst table based on header name, current value , traverse ( UP or DOWN DEFAULT is UP), level
 	and structure as of history date 

set serveroutput on;
declare
out_var ccn_history.REF_CURSOR;
begin
CCN_HISTORY.RETURN_HIERARCHY_HIST('GLOBAL_HIERARCHY','779010','9','UP','01-JAN-2006',out_var);
end;
 
 created : 08/01/2014 CCN Project....
 modified:
 **********************************************************/
     IN_HEADER_NAME         IN      HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE
     ,IN_CURR_ROW_VAL       IN      HIERARCHY_DETAIL.HRCHY_DTL_CURR_ROW_VAL%TYPE
     ,IN_LEVEL              IN      HIERARCHY_DETAIL.HRCHY_DTL_LEVEL%TYPE
     ,IN_TRAVERSE           IN      VARCHAR2 DEFAULT 'UP'
     ,IN_HIST_DATE          IN      HIERARCHY_DETAIL.HRCHY_DTL_EFF_DATE%TYPE DEFAULT NULL
     ,OUT_HIERARCHY_REF_CUR    OUT  REF_CURSOR);

 PROCEDURE RELEASE_LOCK_FOR_HRCHY_HST
  /**********************************************************
	RELEASE_LOCK_FOR_HRCHY_HST

	This procedure will release the lock on the history table

 created : 08/01/2014 CCN Project....
 modified:
**********************************************************/
;

PROCEDURE RETURN_STATUS_HIST (
/**********************************************************
	RETURN_STATUS_HIST

	This procedure will return a ref cursor with data from 
	from the STATUS table based on COST_CENTER_CODE, EXPIRATION_DATE

created : 04/17/2014 nxk 
**********************************************************/
IN_COST_CENTER_CODE IN STATUS.COST_CENTER_CODE%TYPE,
IN_HIST_DATE IN STATUS.EFFECTIVE_DATE%TYPE,
OUT_STATUS_REF_CUR OUT REF_CURSOR);

PROCEDURE RETURN_TYPE_HIST (
/**********************************************************
	RETURN_TYPE_HIST

	This procedure will return a ref cursor with data from 
	from the TYPE table based on COST_CENTER_CODE, EXPIRATION_DATE

created : 04/17/2014 nxk 
**********************************************************/
IN_COST_CENTER_CODE IN TYPE.COST_CENTER_CODE%TYPE,
IN_HIST_DATE IN TYPE.EFFECTIVE_DATE%TYPE,
OUT_TYPE_REF_CUR OUT REF_CURSOR );
         
PROCEDURE RETURN_POLLING_HIST (
/**********************************************************
	RETURN_POLLING_HIST

	This procedure will return a ref cursor with data from 
	from the POLLING table based on COST_CENTER_CODE, CURRENT_FLAG

created : 04/17/2014 nxk 
**********************************************************/
IN_COST_CENTER_CODE IN POLLING.COST_CENTER_CODE%TYPE,
IN_HIST_DATE IN POLLING_HST.CHANGED_DATE%TYPE,
OUT_POLLING_REF_CUR OUT REF_CURSOR);

PROCEDURE RETURN_BANK_CARD_HIST (
/**********************************************************
This procedure will return a ref cursor with data  
from BANK_CARD table based on COST_CENTER_CODE

created : 02/28/2018 bxa919 CCN Project Team...
**********************************************************/
    IN_COST_CENTER_CODE    IN     BANK_CARD.COST_CENTER_CODE%TYPE,
    OUT_BANK_CARD_REF_CUR     OUT REF_CURSOR);

PROCEDURE RETURN_ADDRESS_HIST (
/**********************************************************
This procedure will return a ref cursor with data  
from ADDRESS details from different countries based on 
COST_CENTER_CODE, EXPIRATION_DATE

created : 02/28/2018 bxa919 CCN Project Team...
**********************************************************/
    IN_COST_CENTER_CODE       IN      ADDRESS_USA.COST_CENTER_CODE%TYPE,
    OUT_ADDRESS_USA_REF_CUR      OUT  REF_CURSOR,
    OUT_ADDRESS_CAN_REF_CUR      OUT  REF_CURSOR,
    OUT_ADDRESS_MEX_REF_CUR      OUT  REF_CURSOR,
    OUT_ADDRESS_BRB_REF_CUR      OUT  REF_CURSOR,
    OUT_ADDRESS_OTHER_REF_CUR    OUT  REF_CURSOR);
    
PROCEDURE HIERARCHY_HDR_PICKLIST(
/**********************************************************
This procedure will provide the hierarchies a user can see in 
history window drop down

created : 05/02/2018 sxg151 CCN Project....
modified: 
**********************************************************/
    IN_USER_ID            IN     VARCHAR2,
    OUT_HIERARCHY_REF_CUR    OUT REF_CURSOR);

END CCN_HISTORY;

