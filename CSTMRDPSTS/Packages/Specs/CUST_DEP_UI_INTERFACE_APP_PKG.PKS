create or replace PACKAGE CUST_DEP_UI_INTERFACE_APP_PKG
   AS
-- package spec
/******************************************************************************
This package is intended will return data for the customer_deposit_details table

created : 09/08/2017 sxp130 -- ccn coding project
******************************************************************************/

TYPE ref_cursor IS REF CURSOR;

PROCEDURE CUSTOMER_DEPOSIT_HDR_UI_SP (
/*******************************************************************************
	CUSTOMER_DEPOSIT_HDR_UI_SP

	This procedure is intended to select records from CUSTOMER_DEPOSIT_HEADER table
<?xml version="1.0" encoding="UTF-8"?>
<CUSTOMER_DEPOSIT_UI>
    <CUSTOMER_DEPOSIT_HEADER>
        <CUSTOMER_ACCOUNT_NUMBER>280184482</CUSTOMER_ACCOUNT_NUMBER>
    </CUSTOMER_DEPOSIT_HEADER>
</CUSTOMER_DEPOSIT_UI>

Created : 03/06/2018 sxh487 CCN Project....
*******************************************************************************/
    IN_TABLE_NAME IN     VARCHAR2,
    IN_ROW_DATA   IN     CLOB,
    OUT_REF_CUR      OUT REF_CURSOR);

PROCEDURE CUSTOMER_DEPOSIT_DET_UI_SP (
/*******************************************************************************
	CUSTOMER_DEPOSIT_DET_UI_SP

	This procedure is intended to select records from CUSTOMER_DEPOSIT_DETAILS table

<CUSTOMER_DEPOSIT_DETAILS>
  <TRANSACTION_DATE_START>17-JUL-2017</TRANSACTION_DATE_START>
  <TRANSACTION_DATE_END>05-AUG-2017</TRANSACTION_DATE_END>
  <CUSTOMER_ACCOUNT_NUMBER>280184482</CUSTOMER_ACCOUNT_NUMBER>
</CUSTOMER_DEPOSIT_DETAILS>

Created : 01/16/2018 sxh487 CCN Project....
*******************************************************************************/
    IN_TABLE_NAME IN     VARCHAR2,
    IN_ROW_DATA   IN     CLOB,
    OUT_REF_CUR      OUT REF_CURSOR);

PROCEDURE CUSTOMER_DEPOSIT_UI_UPSERT_SP (
/****************************************************************************** 
This procedure takes XML for customer deposit details information 
and Inserts/Updates the DB with the information from UI
 DETAL XML :
<?xml version="1.0" encoding="UTF-8"?>
<CUSTOMER_DEPOSIT_UI>
    <CUSTOMER_DEPOSIT_TRANSACTION_DTL>
        <COST_CENTER_CODE>707149</COST_CENTER_CODE>
        <TRANSACTION_DATE>02-07-2019</TRANSACTION_DATE>
        <TERMINAL_NUMBER>14103</TERMINAL_NUMBER>
        <TRANSACTION_NUMBER>92458</TRANSACTION_NUMBER>
        <TRANSACTION_GUID>95EE8A9BA5E30F8AE7116E9D40A8EE47</TRANSACTION_GUID>
        <CUSTOMER_ACCOUNT_NUMBER>320224215</CUSTOMER_ACCOUNT_NUMBER>
        <POS_TRANSACTION_CODE>31</POS_TRANSACTION_CODE>
        <TRAN_TIMESTAMP></TRAN_TIMESTAMP>
        <TRANSACTION_TYPE>MANUAL</TRANSACTION_TYPE>
        <CSTMR_DPST_SALES_LN_ITM_AMT>100</CSTMR_DPST_SALES_LN_ITM_AMT>
        <DEPOSIT_REMAINING_BAL></DEPOSIT_REMAINING_BAL>
        <CLOSED_DATE></CLOSED_DATE>
        <REFERENCE_NUMBER></REFERENCE_NUMBER>
        <CLEARED_REASON></CLEARED_REASON>
        <NOTES></NOTES>
        <RLS_RUN_CYCLE></RLS_RUN_CYCLE>
       <LOAD_DATE></LOAD_DATE>
       <ADJUSTED_DATE></ADJUSTED_DATE>
       <GL_DIVISION></GL_DIVISION>
    </CUSTOMER_DEPOSIT_TRANSACTION_DTL>
</CUSTOMER_DEPOSIT_UI>
This is a wrapper for the customer deposit upsert procedure
created : 05/04/2018 sxh487 -- CCN Project Team
Modified: 02/07/2019 pxa852 CCN Project Team...
          Modified code to remove header xml as CCN is not updtaing the header data
******************************************************************************/
    IN_CUST_DETAIL_XML  IN   CLOB);
FUNCTION GET_GL_DIVISION(
/******************************************************************************
GET_GL_DIVISION 
     Wrapper. This Function will get the GL_DIVISION

Created : 05/17/2019 SXH487/SXS484 CCN Project Team...
******************************************************************************/
IN_COST_CENTER_CODE IN CUSTOMER_DEPOSIT_TRANSACTION_DTL.COST_CENTER_CODE%TYPE
) RETURN VARCHAR2;    

END CUST_DEP_UI_INTERFACE_APP_PKG;