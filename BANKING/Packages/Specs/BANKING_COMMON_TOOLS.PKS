CREATE OR REPLACE PACKAGE BANKING_COMMON_TOOLS
AS
/**************************************************************** 
This package will have store drafts specific tools

Created : 07/02/2015 sxh487 CCN Project....
Changed :
*****************************************************************/
G_12HR_FORMAT    VARCHAR2(100) := 'MM-DD-YYYY HH12:MI:SS AM';

FUNCTION EXTRACT_TABLE_CLOB (
/*******************************************************************************
	This procedure will extract the required clob from passed XML clob
  and sends back the result as clob

Created : 03/30/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB) RETURN CLOB;

PROCEDURE GET_ADDRESS_RECORD(
/******************************************************************************
  This procedure gets the address details for the cost center passed in

Created : 06/22/2015 jxc517 CCN Project....
Changed :
*******************************************************************************/
IN_COST_CENTER_CODE       IN     VARCHAR2,
OUT_ADDRESS_RECORD           OUT ADDRESS_VW%ROWTYPE);

PROCEDURE GET_PHONE_RECORD(
/******************************************************************************
  This procedure gets the phone details for the cost center passed in

Created : 06/22/2015 jxc517 CCN Project....
Changed :
*******************************************************************************/
IN_COST_CENTER_CODE       IN     VARCHAR2,
OUT_PHONE_RECORD             OUT CCN_PHONE_INFO_VW%ROWTYPE);

PROCEDURE GET_EMPLOYEE_RECORD(
/******************************************************************************
  This procedure gets the employee details for the cost center and job title passed in

Created : 06/22/2015 jxc517 CCN Project....
Changed :
*******************************************************************************/
IN_COST_CENTER_CODE       IN     VARCHAR2,
IN_JOB_TITLE              IN     VARCHAR2,
OUT_EMPLOYEE_RECORD          OUT SWC_HR_GEMS_TB%ROWTYPE);

FUNCTION GET_BNK_ACCNT_NBR_FOR_CC(
/******************************************************************************
This procedure performs all the business rules that are applicable Account Maintenance Window

created : 06/19/2015 jxc517 CCN Project....
revised : 
*******************************************************************************/
IN_COST_CENTER_CODE IN VARCHAR2) RETURN VARCHAR2;

FUNCTION GET_LEAD_STORE_NBR_FOR_MBR_STR(
/*******************************************************************************
  This function will get the current lead store for the passed member store

Created : 06/19/2015 sxh487/jxc517 CCN Project....
Changed : 
*******************************************************************************/
  IN_MEMBER_STORE_NBR   IN MEMBER_BANK_CC.MEMBER_STORE_NBR%TYPE) RETURN VARCHAR2;

FUNCTION GET_FTR_LD_STR_NBR_FOR_MBR_STR(
/*******************************************************************************
  This function will get the future lead store for the passed future member store

Created : 08/25/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
  IN_MEMBER_STORE_NBR   IN MEMBER_BANK_CC_FUTURE.MEMBER_STORE_NBR%TYPE,
  IN_FUTURE_ID          IN NUMBER) RETURN VARCHAR2;

FUNCTION GET_LEAD_BANK_CC_REC(
/***********************************************************
	This function will get the lead bank record for passed lead
  store number
  
Created : 06/08/2015 nxk927
Changed : 
************************************************************/
    IN_LEAD_STORE_NBR           IN     VARCHAR2) RETURN LEAD_BANK_CC%ROWTYPE;

FUNCTION GET_LEAD_BANK_CC_HIST_REC(
/***********************************************************
	This function will get the lead bank record from current tables
  for the passed lead store number and effective date
  If not found it will try to get the details from the history tables
  based on lead store number and effective date
  
Created : 07/22/2015 sxh487/jxc517
Changed : 
************************************************************/
    IN_LEAD_STORE_NBR           IN     VARCHAR2,
    IN_EFFECTIVE_DATE           IN     LEAD_BANK_CC.EFFECTIVE_DATE%TYPE) RETURN LEAD_BANK_CC%ROWTYPE;

FUNCTION GET_LEAD_BANK_CC_FUTURE_REC(
/***********************************************************
	This function will return the lead bank future record
  based on bank account number, lead store number and future id
  
Created : 07/20/2015 jxc517 CCN Project....
Changed  : 
************************************************************/
    IN_LEAD_BANK_ACCOUNT_NBR IN     VARCHAR2,
    IN_LEAD_STORE_NBR        IN     VARCHAR2,
    IN_FUTURE_ID             IN     NUMBER) RETURN LEAD_BANK_CC_FUTURE%ROWTYPE;

FUNCTION GET_BANK_ACCOUNT_REC(
/***********************************************************
	This function will get the bank account record for passed
  bank account number
  
Created : 07/23/2015 jxc517 CCN Project....
Changed : 
************************************************************/
    IN_BANK_ACCOUNT_NBR IN     VARCHAR2) RETURN BANK_ACCOUNT%ROWTYPE;

FUNCTION GET_BANK_ACCOUNT_FUTURE_REC(
/***********************************************************
	This function will get the bank account future record for passed
  bank account number
  
Created : 07/23/2015 jxc517 CCN Project....
Changed : 
************************************************************/
    IN_BANK_ACCOUNT_NBR IN     VARCHAR2,
    IN_FUTURE_ID        IN     NUMBER) RETURN BANK_ACCOUNT_FUTURE%ROWTYPE;

FUNCTION GET_BANK_ACCOUNT_HIST_REC(
/***********************************************************
	This function will get the bank account record from current tables
  for the passed bank account number and effective date
  If not found it will try to get the details from the history tables
  based on bank account number and effective date
  
Created : 07/22/2015 sxh487/jxc517
Changed : 
************************************************************/
    IN_BANK_ACCOUNT_NBR           IN     VARCHAR2,
    IN_EFFECTIVE_DATE             IN     BANK_ACCOUNT.EFFECTIVE_DATE%TYPE) RETURN BANK_ACCOUNT%ROWTYPE;

FUNCTION GET_BANK_TYPE_CODE(
/*******************************************************************************
  This function will get the bank type code for the passed store number

Created : 07/13/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_COST_CENTER    IN     LEAD_BANK_CC.LEAD_STORE_NBR%TYPE) RETURN VARCHAR2;

FUNCTION GET_FUTURE_ID(
/***********************************************************
	This fucntion will get next future id for the 
  passed bank account number

Created : 07/08/2015 nxk927/jxc517 CCN Project Team....
Changed : 
************************************************************/
IN_BANK_ACCOUNT_NBR IN VARCHAR2) RETURN NUMBER;

FUNCTION GET_NEXT_MICR_FORMAT_ID(
/***********************************************************
	This function will get next future id for the 
  passed bank account number

Created : 07/08/2015 nxk927/jxc517 CCN Project Team....
Changed : 
************************************************************/
IN_BANK_ACCOUNT_NBR IN     VARCHAR2,
IN_FUTURE_ID        IN     VARCHAR2) RETURN NUMBER;

FUNCTION GET_STORE_MICR_FORMAT_DTLS_REC(
/***********************************************************
	This function will get the store MICR format detail record for passed
  cost center code
  
Created : 08/18/2015 jxc517 CCN Project....
Changed : 
************************************************************/
    IN_COST_CENTER_CODE IN     VARCHAR2) RETURN STORE_MICR_FORMAT_DTLS%ROWTYPE;

FUNCTION GET_STR_MICR_FRMT_DTLS_FTR_REC(
/***********************************************************
	This function will get the store MICR format detail future record for passed
  cost center code and future id
  
Created : 08/18/2015 jxc517 CCN Project....
Changed : 
************************************************************/
    IN_COST_CENTER_CODE IN     VARCHAR2,
    IN_FUTURE_ID        IN     NUMBER) RETURN STORE_MICR_FORMAT_DTLS_FUTURE%ROWTYPE;

FUNCTION GET_STORE_BANK_MICR_FORMAT_REC(
/***********************************************************
	This function will get the bank MICR format record for passed
  cost center code
  
Created : 08/18/2015 jxc517 CCN Project....
Changed : 
************************************************************/
    IN_BANK_ACCONUT_NBR  IN     VARCHAR2,
    IN_MICR_FORMAT_ID    IN     NUMBER) RETURN BANK_MICR_FORMAT%ROWTYPE;

FUNCTION GET_STR_BANK_MICR_FRMT_FTR_REC(
/***********************************************************
	This function will get the bank MICR format record for passed
  cost center code and future id
  
Created : 08/18/2015 jxc517 CCN Project....
Changed : 
************************************************************/
    IN_BANK_ACCONUT_NBR  IN     VARCHAR2,
    IN_MICR_FORMAT_ID    IN     NUMBER,
    IN_FUTURE_ID         IN     NUMBER) RETURN BANK_MICR_FORMAT_FUTURE%ROWTYPE;

FUNCTION GET_MICR_FRMT_ID_FR_BA_FRMT_NM(
/***********************************************************
	This function will get next MICR format id for the passed bank account number,
  format name

Created : 08/17/2015 jxc517 CCN Project Team....
Changed : 
************************************************************/
IN_BANK_ACCOUNT_NBR IN     VARCHAR2,
IN_FORMAT_NAME      IN     VARCHAR2,
IN_FUTURE_ID        IN     NUMBER) RETURN NUMBER;

END BANKING_COMMON_TOOLS;

