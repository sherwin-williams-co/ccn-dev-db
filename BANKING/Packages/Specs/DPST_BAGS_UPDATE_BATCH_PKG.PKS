CREATE OR REPLACE PACKAGE DPST_BAGS_UPDATE_BATCH_PKG
AS
/**********************************************************
  This Package contains procedured to update the deposit bag tickets on a daily
  basis based on the files we recieve from POS

Created : 10/20/2015 jxc517 CCN Project....
Changed :
**********************************************************/
PROCEDURE PROCESS
/******************************************************************************
  This procedure will update the deposit bag tickets on a daily
  basis based on the files we recieve from POS

Created : 10/20/2015 jxc517 CCN Project....
Changed :
*******************************************************************************/
;

PROCEDURE UPDATE_BAGORDER_TRACK_NUM(
/*******************************************************************************
This procedure is intended to update the tracing number information for an order id.

Created : 06/21/2016 mxk766 CCN Project....
Changed : 
*******************************************************************************/
IN_LOAD_DATE IN VARCHAR2);

END DPST_BAGS_UPDATE_BATCH_PKG;

