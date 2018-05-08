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
  <CUSTOMER_DEPOSIT_DETAILS>
    <CUSTOMER_ACCOUNT_NUMBER>100046887</CUSTOMER_ACCOUNT_NUMBER>
    <TOTAL_SALES>41.15</TOTAL_SALES>
    <ADJUSTED_DATE>27-FEB-2018</ADJUSTED_DATE>
  </CUSTOMER_DEPOSIT_DETAILS>
</CUSTOMER_DEPOSIT_UI>
    
Created : 03/06/2018 sxh487 CCN Project....
*******************************************************************************/
 IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE CUSTOMER_DEPOSIT_DET_UI_SP (
/*******************************************************************************
	CUSTOMER_DEPOSIT_DET_UI_SP

	This procedure is intended to select records from CUSTOMER_DEPOSIT_DETAILS table

<CUSTOMER_DEPOSIT_DETAILS>
  <TRANSACTION_DATE_START>17-JUL-2017</TRANSACTION_DATE>
  <TRANSACTION_DATE_END>05-AUG-2017</TRANSACTION_DATE_END>
  <CUSTOMER_ACCOUNT_NUMBER>280184482</CUSTOMER_ACCOUNT_NUMBER>
</CUSTOMER_DEPOSIT_DETAILS>
    
Created : 01/16/2018 sxh487 CCN Project....
*******************************************************************************/
 IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE CUSTOMER_DEPOSIT_UI_UPSERT_SP (
/****************************************************************************** 
This procedure takes XML for customer deposit details information 
and Inserts/Updates the DB with the information from UI

This is a wrapper for the customer deposit upsert procedure
created : 05/04/2018 sxh487 -- CCN Project Team
******************************************************************************/
IN_CUST_HEADERXML   IN CLOB,
IN_CUST_DETAIL_XML  IN CLOB);

END CUST_DEP_UI_INTERFACE_APP_PKG;