create or replace PACKAGE SD_CHECK_NBR_PRINT_SRVCS
AS

FUNCTION GET_STORE_DRAFT_RUN_TYPE_REC(
/**********************************************************
This function will get run type detail for COST_CENTER passed.

Created : 07/22/2019 akj899 ASP-1193 CCNSD-8 CCN project Team.... 
Changed : 
**********************************************************/
    IN_COST_CENTER_CODE    IN    VARCHAR2
) RETURN STORE_RUN_TYPE_DETAILS%ROWTYPE;

PROCEDURE SD_CHECK_NBR_PRINT_PROCESS
/**********************************************************
This procedure will go ahead and place draft print order if unused drafts less then threshold.

Created : 07/22/2019 akj899 ASP-1193 CCNSD-8 CCN project Team.... 
Changed : 
**********************************************************/
;

PROCEDURE SD_CHECK_NBR_PRINT_PROCESS(
/**********************************************************
This procedure will go ahead and place draft print order on demand for the cost center passed.

Created : 07/22/2019 akj899 ASP-1193 CCNSD-8 CCN project Team.... 
Changed : 
**********************************************************/
    IN_COST_CENTER_CODE   IN    VARCHAR2);

PROCEDURE SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS_UPSERT_SP (
/**********************************************************
This procedure will insert/update into the SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS table. 

<SD_CHECK_NBR_PRNT_UI>
 <SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS>
   <STORE_DRAFT_CHECK_RUN_TYPE>S</STORE_DRAFT_CHECK_RUN_TYPE>
   <NO_OF_BOOKS>2</NO_OF_BOOKS>
   <CHECKS_PER_BOOK>201</CHECKS_PER_BOOK>
   <STORE_DRFT_THRESHOLD>10</STORE_DRFT_THRESHOLD>
   <BANK_ACCOUNT_NBR>9823469237</BANK_ACCOUNT_NBR>
   <BANK_ROUTING_NBR>242352353456</BANK_ROUTING_NBR>
   <CREATED_BY_USER_ID>kxm302</CREATED_BY_USER_ID>
   <CREATED_ON_DATE>01-11-2019</CREATED_ON_DATE>
 </SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS>
 <SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS>
   <STORE_DRAFT_CHECK_RUN_TYPE>L</STORE_DRAFT_CHECK_RUN_TYPE>
   <NO_OF_BOOKS>2</NO_OF_BOOKS>
   <CHECKS_PER_BOOK>76</CHECKS_PER_BOOK>
   <STORE_DRFT_THRESHOLD>40</STORE_DRFT_THRESHOLD>
   <BANK_ACCOUNT_NBR>9823469237</BANK_ACCOUNT_NBR>
   <BANK_ROUTING_NBR>242352353456</BANK_ROUTING_NBR>
   <CREATED_BY_USER_ID>kxm302</CREATED_BY_USER_ID>
   <CREATED_ON_DATE>01-11-2019</CREATED_ON_DATE>
 </SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS>
</SD_CHECK_NBR_PRNT_UI>

Created : 07/22/2019 akj899 ASP-1193 CCNSD-8 CCN project Team.... 
Changed : 
**********************************************************/ 
    IN_XML                CLOB);

PROCEDURE STORE_RUN_TYPE_DETAILS_UPSERT_SP (
/**********************************************************
This procedure will insert/update into the STORE_RUN_TYPE_DETAILS table.

<STORE_RUN_TYPE_DETAILS_UI>
 <STORE_RUN_TYPE_DETAILS>
   <COST_CENTER_CODE>701004</COST_CENTER_CODE>
   <STORE_DRAFT_CHECK_RUN_TYPE>S</STORE_DRAFT_CHECK_RUN_TYPE>
   <CREATED_BY_USER_ID>kxm302</CREATED_BY_USER_ID>
 </STORE_RUN_TYPE_DETAILS>
</STORE_RUN_TYPE_DETAILS_UI> 

Created : 07/22/2019 akj899 ASP-1193 CCNSD-8 CCN project Team....  
Changed : 
**********************************************************/ 
    IN_XML                CLOB);

FUNCTION GET_SD_CHK_TYP_REC(
/**********************************************************
This function will return no of books ,checks per book , threshold, bank acccount number and routing number for run type passed.

Created : 07/22/2019 akj899 ASP-1193 CCNSD-8 CCN project Team....  
Changed : 
**********************************************************/
    IN_RUN_TYPE      IN    VARCHAR2
) RETURN SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS%ROWTYPE;

PROCEDURE INITIAL_DRAFT_DTLS_LOAD_PROCESS;
/**********************************************************
This procedure will be a one-time run that loads the initial data as provided from
1) Julio's team => Run type details
2) Pat's team => Run type tie back with stores
3) Jason's team => previous order date/check draft numbers

Created : 7/15/2019 akj899 ASP-1193 CCNSD-8 CCN Project Team.... 
Changed : 
**********************************************************/

FUNCTION GET_CHECK_SERIAL_NUMBER(
/****************************************************************************************
This function will return 10 digit check serial number for the check serial number passed.

Created : 7/25/2019 akj899 ASP-1193 CCNSD-8 CCN Project Team.... 
Changed : 
*****************************************************************************************/
IN_CHECK_SERIAL_NUMBER   IN   STORE_DRAFTS.CHECK_SERIAL_NUMBER%TYPE,
IN_TRANSACTION_DATE      IN   STORE_DRAFTS.TRANSACTION_DATE%TYPE DEFAULT NULL)
RETURN VARCHAR2;

FUNCTION GET_CHECK_SERIAL_NUMBER(
/*********************************************************************************
This is an overloading function and will return  10 digit check serial number for
the cost centger and draft number passed.

Created : 7/25/2019 akj899 ASP-1193 CCNSD-8 CCN Project Team.... 
Changed : 
***********************************************************************************/
IN_COST_CENTER_CODE  IN      SD_CHECK_NBR_PRNT_EXTRCT_DTLS.COST_CENTER_CODE%TYPE,
IN_DRAFT_NUMBER      IN      SD_CHECK_NBR_PRNT_EXTRCT_DTLS.CCN_CHECK_SERIAL_NUMBER%TYPE,
IN_TRANSACTION_DATE  IN      STORE_DRAFTS.TRANSACTION_DATE%TYPE DEFAULT NULL)
RETURN VARCHAR2;

FUNCTION GET_DRAFT_NUMBER(
/***********************************************************************
This function will return 5 digit draft number for the 10 digit
check serial number passed.

Created : 7/25/2019 akj899 ASP-1193 CCNSD-8 CCN Project Team.... 
Changed : 
************************************************************************/
IN_CHECK_SERIAL_NUMBER      IN      SD_CHECK_NBR_PRNT_EXTRCT_DTLS.CCN_CHECK_SERIAL_NUMBER%TYPE)
RETURN NUMBER;

END SD_CHECK_NBR_PRINT_SRVCS;