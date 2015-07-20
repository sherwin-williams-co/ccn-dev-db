CREATE OR REPLACE PACKAGE BANKING_COMMON_TOOLS
/**************************************************************** 
This package will have store drafts specific tools

created : 07/02/2015 sxh487 CCN Project....
changed :
*****************************************************************/
IS

FUNCTION EXTRACT_TABLE_CLOB (
/*******************************************************************************
  This procedure will extract the required clob from passed XML clob
  and sends back the result as clob

created : 03/30/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB) RETURN CLOB;

FUNCTION GET_BNK_ACCNT_NBR_FOR_CC(
/******************************************************************************
This procedure performs all the business rules that are applicable Account Maintenance Window

created : 06/19/2015 jxc517 CCN Project....
revised : 
*******************************************************************************/
IN_COST_CENTER_CODE IN VARCHAR2) RETURN VARCHAR2;

FUNCTION GET_LEAD_STORE_NBR(
/*******************************************************************************
  This procedure will check if the member Cost Center exists in another LEAD or NOT

created : 06/19/2015 sxh487 CCN Project....
Changed : 
*******************************************************************************/
  IN_MEMBER_STORE_NBR   IN MEMBER_BANK_CC.MEMBER_STORE_NBR%TYPE)
  RETURN VARCHAR2;

FUNCTION GET_LEAD_BANK_CC_REC(
/***********************************************************
	This procedure will be called in lead_transfer_process to 
  get the lead bank rec 
  
created : 06/08/2015 nxk927
update  : 
************************************************************/
    IN_LEAD_STORE_NBR           IN     VARCHAR2) RETURN LEAD_BANK_CC%ROWTYPE;

FUNCTION GET_LEAD_BANK_CC_FUTURE_REC(
/***********************************************************
	This procedure will return the lead_bank_cc_future record
  based on bank account number, lead store number and future id
  
Created : 07/20/2015 jxc517 CCN Project....
Changed  : 
************************************************************/
    IN_LEAD_BANK_ACCOUNT_NBR IN     VARCHAR2,
    IN_LEAD_STORE_NBR        IN     VARCHAR2,
    IN_FUTURE_ID             IN     NUMBER) RETURN LEAD_BANK_CC_FUTURE%ROWTYPE;

FUNCTION GET_BANK_TYPE_CODE(
/*******************************************************************************
  This procedure will check if the Cost Center is a LEAD or NOT

created : 06/09/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_COST_CENTER    IN LEAD_BANK_CC.LEAD_STORE_NBR%TYPE)
RETURN VARCHAR2;

END BANKING_COMMON_TOOLS;

