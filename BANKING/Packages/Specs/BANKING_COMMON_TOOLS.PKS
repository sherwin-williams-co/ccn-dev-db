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

PROCEDURE GET_DAD_FOR_COST_CENTER(
/******************************************************************************
  This procedure gets the DAD details for the 4 digit store number passed in

Created : 09/30/2015 jxc517 CCN Project....
Changed :
*******************************************************************************/
IN_COST_CENTER_CODE IN     VARCHAR2,
OUT_DIVISION           OUT VARCHAR2,
OUT_AREA               OUT VARCHAR2,
OUT_DISTRICT           OUT VARCHAR2);

FUNCTION GET_BNK_ACCNT_NBR_FOR_CC(
/******************************************************************************
This procedure performs all the business rules that are applicable Account Maintenance Window

created : 06/19/2015 jxc517 CCN Project....
revised : 
*******************************************************************************/
IN_COST_CENTER_CODE IN VARCHAR2) RETURN VARCHAR2;

FUNCTION GET_FTR_BNK_ACCNT_NBR_FOR_CC(
/******************************************************************************
This procedure performs all the business rules that are applicable Account Maintenance Window

created : 10/19/2015 jxc517 CCN Project....
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

FUNCTION GET_UNEXP_LEAD_CC_FUTURE_REC(
/***********************************************************
	This function will return the un expired lead bank future record
  based on lead store number 
  
Created : 11/11/2015 nxk927 CCN Project....
Changed  : 
************************************************************/
    IN_LEAD_STORE_NBR        IN     VARCHAR2) RETURN LEAD_BANK_CC%ROWTYPE;    

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

FUNCTION IS_STORE_LEAD_EVER(
/*******************************************************************************
  This function will return 'Y' if the store passed is a lead ever

Created : 10/20/2015 jxc517 CCN Project....
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
    IN_BANK_ACCOUNT_NBR  IN     VARCHAR2,
    IN_MICR_FORMAT_ID    IN     NUMBER) RETURN BANK_MICR_FORMAT%ROWTYPE;

FUNCTION GET_STR_BANK_MICR_FRMT_FTR_REC(
/***********************************************************
	This function will get the bank MICR format record for passed
  cost center code and future id
  
Created : 08/18/2015 jxc517 CCN Project....
Changed : 
************************************************************/
    IN_BANK_ACCOUNT_NBR  IN     VARCHAR2,
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

FUNCTION GET_STANDARD_VAL_DEPOSIT_ORD(
/*******************************************************************************
  This function will return standard number for REORDER_NUMBER_BKS, NBR_DEP_TICKETS_PER_BK
  and DEPBAG_REORDER_QTY

Created : 11/05/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_IND		IN   VARCHAR2) RETURN NUMBER;

FUNCTION GET_DEPOSIT_TICKET_ONHAND_YTD(
/***********************************************************
	  This function will get the DEP_TKTS_ONHAND_QTY and YTD_DEP_TKTS_ORDERED_QTY
    From history to update the current records as the future will have 0's for both the
    field. When future moves to current, this need to run to update the two fields
Created : 10/30/2015 NXK927
Changed : 
************************************************************/
    IN_COST_CENTER              IN     VARCHAR2,
    IN_REORDER_NUMBER_BKS       IN     NUMBER,
    IN_NBR_DEP_TICKETS_PER_BK   IN     NUMBER,
    IN_FUTURE_ID                IN     NUMBER)RETURN BANK_DEP_TICK_HIST%ROWTYPE;
    
FUNCTION GET_DEPOSIT_BAG_ONHAND_YTD(
/***********************************************************
	  This function will get the DEPBAG_ONHAND_QTY and DEPBAG_YTD_ORDERED_QTY
    From history to update the current records as the future will have 0's for both the
    field. When future moves to current, this need to run to update the two fields  
Created : 10/30/2015 NXK927
Changed : 
************************************************************/
    IN_COST_CENTER           IN     VARCHAR2,
    IN_DEPBAG_REORDER_QTY    IN     NUMBER,
    IN_FUTURE_ID             IN     NUMBER) RETURN BANK_DEP_BAG_TICK_HIST%ROWTYPE;

FUNCTION IS_LEAD_ON_DATE_PASSED(
/***********************************************************
	  This function will check if the cost center is lead or not
    on the date passed
Created : 11/09/2015 NXK927 CCN Project....
Changed : 
************************************************************/
    IN_COST_CENTER           IN     VARCHAR2,
    IN_EFFECTIVE_DATE        IN     DATE) RETURN VARCHAR2;
    
END BANKING_COMMON_TOOLS;

