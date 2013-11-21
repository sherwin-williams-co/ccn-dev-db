PACKAGE CCN_INTERFACES_PKG AS 
/*******************************************************************************************************
	CCN_INTERFACES_PKG 

	This Package is intended to return a ref cursor with the MATERIALIZED VIEW 
  FOR EACH SCREEN FROM THE USER_INTERFACE.

created : 
*******************************************************************************************************/
TYPE REF_CUR_VIEW IS REF CURSOR;


PROCEDURE COST_CENTER_VIEW(
/*******************************************************************************************************
	COST_CENTER_VIEW 

	This Package is intended  to return a ref cursor with the  MATERIALIZED VIEW 
  FOR cost center screen FROM THE USER_INTERFACE.

created : 
*******************************************************************************************************/
in_cost_center_code IN cost_center.cost_center_code%TYPE,
OUT_COST_CENTER_CUR OUT REF_CUR_VIEW) ;

PROCEDURE HIERARCHY_DETAIL_VIEW(
/*******************************************************************************************************
	HIERARCHY_DETAIL_VIEW 

	This Package is intended  to return a ref cursor with the MATERIALIZED VIEW 
  FOR hierarchy screen FROM THE USER_INTERFACE.

created : 
*******************************************************************************************************/
in_HRCHY_HDR_NAME in HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE,
OUT_HIERARCHY_DETAIL_CUR OUT REF_CUR_VIEW) ;

PROCEDURE ADDRESS_ALL_VIEW (
/*******************************************************************************************************
	ADDRESS_ALL_VIEW 

  This Package is intended  to return a ref cursor with the MATERIALIZED VIEW 
  FOR address screen FROM THE USER_INTERFACE.
	

created : 
*******************************************************************************************************/
in_cost_center_code IN cost_center.cost_center_code%TYPE,
out_ADDRESS_ALL_cur OUT REF_CUR_VIEW);


PROCEDURE POLLING_VIEW(
/*******************************************************************************************************
	POLLING_VIEW 

    This Package is intended  to return a ref cursor with the MATERIALIZED VIEW 
    FOR polling screen FROM THE USER_INTERFACE.

created : 
*******************************************************************************************************/
in_cost_center_code IN polling.cost_center_code%TYPE,
out_POLLING_cur OUT REF_CUR_VIEW) ;

END CCN_INTERFACES_PKG;
/

