create or replace PACKAGE CCN_HISTORY
/*********************************************************** 
This package is will return data for HISTORY detail 

created : 
************************************************************/
    AS
	 	TYPE REF_CURSOR IS REF CURSOR;

		
PROCEDURE RETURN_HIERARCHY_HIST (	
/**********************************************************
	RETURN_HIERARCHY_HIST

	This procedure will return a ref cursor with data from 
	from the hierarchy_detail_hst table based on header name, current value , traverse ( UP or DOWN DEFAULT is UP), level
	and structure as of history date 
	ex. CCN_HIERARCHY.RETURN_HIERARCHY('DAD Structure','703252','DOWN',TO_DATE('03/24/2011','MM/DD/YYYY'),OUT_DEFINED_REF_CURSOR)

created : 
**********************************************************/
IN_HEADER_NAME 	IN HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE,
IN_CURR_ROW_VAL	IN HIERARCHY_DETAIL.HRCHY_DTL_CURR_ROW_VAL%TYPE,
IN_LEVEL	IN HIERARCHY_DETAIL.HRCHY_DTL_LEVEL%TYPE,
IN_TRAVERSE	IN VARCHAR2 DEFAULT 'UP',
IN_HIST_DATE	IN HIERARCHY_DETAIL.HRCHY_DTL_EFF_DATE%TYPE DEFAULT NULL,
OUT_HIERARCHY_REF_CUR OUT REF_CURSOR);

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
         
END CCN_HISTORY;

