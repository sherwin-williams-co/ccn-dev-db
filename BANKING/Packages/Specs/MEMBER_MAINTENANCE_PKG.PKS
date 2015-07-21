CREATE OR REPLACE PACKAGE MEMBER_MAINTENANCE_PKG
AS
/**********************************************************
This Package contains all the procedures used in
member cost center maintenance window

Created : 07/09/2015 jxc517 CCN Project....
Changed :
**********************************************************/

TYPE REF_CURSOR IS REF CURSOR;

PROCEDURE MEMBER_CC_MAINTENACE_UI_SP (
/*******************************************************************************
	This procedure is intended to RETURN a ref cursor with data from member
  cost center maintenance related tables

Inputs:
    IN_COST_CENTER_CODE

Created : 07/09/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_COST_CENTER_CODE          IN     VARCHAR2
,OUT_BANK_MBR_CC_REF_CUR         OUT REF_CURSOR
,OUT_BANK_MBR_CC_FTR_REF_CUR     OUT REF_CURSOR);

PROCEDURE MEMBER_MNTNC_UI_UPSERT_SP(
/******************************************************************************
This procedure is intended to update following tables used in the Mamber Maintenance Window
    Tables: 
       MEMBER_BANK_CC
       MEMBER_BANK_CC_FUTURE

Created : 07/09/2015 jxc517 CCN Project....
Changed :
*******************************************************************************/
    IN_ROW_DATA  IN  CLOB);

END MEMBER_MAINTENANCE_PKG;

