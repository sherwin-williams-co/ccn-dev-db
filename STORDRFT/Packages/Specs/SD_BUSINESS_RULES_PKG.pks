create or replace PACKAGE SD_BUSINESS_RULES_PKG
/****************************************************************************** 
This package BODY will do the business rules validations:
  
created : 06/30/2014 
changed : 04/16/2015 jxc517 CCN Project
          Added global variables to store statement types based on their category
******************************************************************************/
AS

G_HISTORY_MONTHS           NUMBER := 18;
G_US_AUTO_STMNT_TYPES      VARCHAR2(500) := 'AU';
G_CAN_NON_AUTO_STMNT_TYPES VARCHAR2(500) := 'CN,DC,QC';
G_CAN_AUTO_STMNT_TYPES     VARCHAR2(500) := 'AC';
--Anything apart from above statement types are US NON AUTOMOTIVE

PROCEDURE SET_STORE_DRAFT_FLAGS(
/*****************************************************************************
	SET_STORE_DRAFT_FLAGS

	This function will get set the flag values for store drafts table

created : 07/10/2014 
changed :
*****************************************************************************/
    IN_ROW_TYPE     IN OUT    STORE_DRAFTS%ROWTYPE);


FUNCTION IS_UNATTACHED_STORE_DRAFT(
/*****************************************************************************
	IS_UNATTACHED_STORE_DRAFT

	This function will return if the passed record is unattached or not based on some ruels.  

created : 07/01/2014
changed :
*****************************************************************************/
    IN_STORE_DRAFTS_RECORD     IN    STORE_DRAFTS%ROWTYPE) RETURN BOOLEAN;


FUNCTION GET_CHECK_SERIAL_NUMBER(
/*****************************************************************************
	GET_CHECK_SERIAL_NUMBER

    This function will return the 10 digit check serial number based on passed 
    check serial number or (cost center id and draft number).

created : 09/10/2014 jxc517 CCN Project . . .
changed : 07/25/2019 akj899 ASP-1193 CCNSD-8 CCN Project Team....
*****************************************************************************/
    IN_COST_CENTER_CODE IN    STORE_DRAFTS.COST_CENTER_CODE%TYPE,
    IN_CHECK_NUMBER     IN    VARCHAR2) RETURN VARCHAR2;

PROCEDURE UNATTACHED_MNL_DRFT_DTL_SP(
/*****************************************************************************
	UNATTACHED_MNL_DRFT_DTL_SP

	This procedure will do the bussiness rules validations for UNATTACHED_MNL_DRFT_DTL table

created : 09/12/2014 jxc517 CCN Project . . .
changed :
*****************************************************************************/
    IN_RECORD IN    UNATTACHED_MNL_DRFT_DTL%ROWTYPE);

PROCEDURE STORE_DRAFTS_SP(
/*****************************************************************************
	STORE_DRAFTS_SP

	This procedure will do the bussiness rules validations for STORE_DRAFTS table

created : 09/12/2014 jxc517 CCN Project . . .
changed :
*****************************************************************************/
    IN_RECORD IN    STORE_DRAFTS%ROWTYPE);

PROCEDURE SD_BANK_FILE_SENT_DETAILS_SP(
/*****************************************************************************
	SD_BANK_FILE_SENT_DETAILS_SP

	This procedure will do the bussiness rules validations for SD_BANK_FILE_SENT_DETAILS table

created : 09/29/2014 jxc517 CCN Project . . .
changed :
*****************************************************************************/
    IN_COST_CENTER_CODE    IN    SD_BANK_FILE_SENT_DETAILS.COST_CENTER_CODE%TYPE,
    IN_CHECK_SERIAL_NUMBER IN    SD_BANK_FILE_SENT_DETAILS.CHECK_SERIAL_NUMBER%TYPE);

PROCEDURE SD_GL_ACCOUNT_VALIDATION(
/*****************************************************************************
	SD_GL_ACCOUNT_VALIDATION

	This procedure will do the bussiness rules validations for GL_ACCOUNT_NUMBER

created : 11/04/2014 jxc517 CCN Project . . .
changed :
*****************************************************************************/
    IN_GL_ACCOUNT_NUMBER    IN    VARCHAR2);

PROCEDURE DUPLICATE_STORE_DRAFTS_SP(
/*****************************************************************************
	This procedure will determine if a draft is duplciate or not during insert process from UI

created : 12/30/2014 jxc517 CCN Project . . .
changed :
*****************************************************************************/
    IN_CHECK_SERIAL_NUMBER IN    STORE_DRAFTS.CHECK_SERIAL_NUMBER%TYPE);
    
PROCEDURE SD_RUN_TYPE_VALIDATION(
/*****************************************************************************
This procedure will do the bussiness rules validations for Run Type

created : 1/28/2019 kxm302 CCN Project . . .
changed : 07/22/2019 akj899 ASP-1193 CCNSD-8 CCN Project Team....
*****************************************************************************/
    IN_STORE_RUN_TYPE_DETAILS_ROW     IN           STORE_RUN_TYPE_DETAILS%ROWTYPE);

PROCEDURE SD_VALIDATE_RUN_TYPE_DETAILS(
/*****************************************************************************
This procedure will validate the check run type in code detail table.

created : 7/25/2019 akj899 ASP-1193 CCNSD-8  CCN Project Team....
changed :
*****************************************************************************/
    IN_ROW_DATA     IN           SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS%ROWTYPE);

PROCEDURE SD_VALIDATE_TERMINAL(
/*****************************************************************************
This procedure will validate terminal number and its combination with store.

created : 7/25/2019 akj899 ASP-1193 CCNSD-8  CCN Project Team....
changed :
*****************************************************************************/
    IN_COST_CENTER_CODE    IN           STORE_DRAFTS.COST_CENTER_CODE%TYPE,
    IN_TERMINAL_NUMBER     IN           STORE_DRAFTS.TERMINAL_NUMBER%TYPE DEFAULT NULL); 

END SD_BUSINESS_RULES_PKG;