CREATE OR REPLACE PACKAGE STORDRFT.SD_UI_INTERFACE_APP_PKG
AS
/**********************************************************
	SD_UI_INTERFACE_APP_PKG

	This Package is intended to be the wrapper for all Store draft
  related packages that are invoked from UI

created : 05/02/2013 jxc517 CCN Project....
changed :
**********************************************************/
	 	TYPE REF_CURSOR IS REF CURSOR;

PROCEDURE CUSTOMER_FORM_OF_PAY_UI_SP (
/*******************************************************************************
	CUSTOMER_FORM_OF_PAY_UI_SP

	This procedure is intended to RETURN a ref cursor with data from CUSTOMER_FORM_OF_PAY table

Created : 05/20/2014 nxk927 CCN Project....
Changed : 

<CUSTOMER_FORM_OF_PAY_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
   <CUSTOMER_FORM_OF_PAY>
    <COST_CENTER_CODE>702345</COST_CENTER_CODE>
    <TRANSACTION_DATE>03-30-2012</TRANSACTION_DATE>
    <TERM_NUMBER>12345</TERM_NUMBER>
    <TRANSACTION_NUMBER>12345</TRANSACTION_NUMBER>
    <SEGMENT_CODE>12</SEGMENT_CODE>
  	<SUB_SEGMENT_CODE>12</SUB_SEGMENT_CODE>
    </CUSTOMER_FORM_OF_PAY>
 </CUSTOMER_FORM_OF_PAY_UI_SP>
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE CUSTOMER_BANK_CARD_UI_SP (
/*******************************************************************************
	CUSTOMER_BANK_CARD_UI_SP

	This procedure is intended to RETURN a ref cursor with data from CUSTOMER_BANK_CARD table

Created : 05/20/2014 nxk927 CCN Project....
Changed : 


<CUSTOMER_BANK_CARD_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
  <CUSTOMER_BANK_CARD>
		<COST_CENTER_CODE>701221</COST_CENTER_CODE>
    <CUSTOMER_BANK_CARD_ID>436245</CUSTOMER_BANK_CARD_ID>
		<TRANSACTION_DATE>03-30-2012</TRANSACTION_DATE>
		<TERM_NUMBER>15767</TERM_NUMBER>
		<TRANSACTION_NUMBER>16086</TRANSACTION_NUMBER>
		<SEGMENT_CODE>07</SEGMENT_CODE>
		<SUB_SEGMENT_CODE>12</SUB_SEGMENT_CODE>
		</CUSTOMER_BANK_CARD>
 </CUSTOMER_BANK_CARD_UI_SP>
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE CUSTOMER_DETAILS_UI_SP (
/*******************************************************************************
	CUSTOMER_DETAILS_UI_SP

	This procedure is intended to RETURN a ref cursor with data from CUSTOMER_DETAILS table

Created : 05/20/2014 nxk927 CCN Project....
Changed : 

<CUSTOMER_DETAILS_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
 	<CUSTOMER_DETAILS>
    <CUSTOMER_DETAIL_ID>436236</CUSTOMER_DETAIL_ID>
		<COST_CENTER_CODE>701030</COST_CENTER_CODE>
		<TRANSACTION_DATE>03-30-2012</TRANSACTION_DATE>
		<TERM_NUMBER>10232</TERM_NUMBER>
		<TRANSACTION_NUMBER>07713</TRANSACTION_NUMBER>
		<SEGMENT_CODE>01</SEGMENT_CODE>
		<SALES_NUMBER>005849542</SALES_NUMBER>
  	</CUSTOMER_DETAILS>
 </CUSTOMER_DETAILS_UI_SP>
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE STORE_DRAFTS_UI_SP (
/*******************************************************************************
	STORE_DRAFTS_UI_SP

	This procedure is intended to RETURN a ref cursor with data from STORE_DRAFTS table

Created : 05/20/2014 nxk927 CCN Project....
Changed : 

<STORE_DRAFTS_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
 <STORE_DRAFTS>
  <COST_CENTER_CODE>701030</COST_CENTER_CODE>
  <CHECK_SERIAL_NUMBER>0103032009</CHECK_SERIAL_NUMBER>
  <TRANSACTION_DATE>03-30-2012</TRANSACTION_DATE>
 </STORE_DRAFTS>
</<STORE_DRAFTS_UI_SP>

*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE STORE_DRAFTS_DETAIL_UI_SP (
/*******************************************************************************
	STORE_DRAFTS_DETAIL_UI_SP

	This procedure is intended to RETURN a ref cursor with data from STORE_DRAFTS_DETAIL table

Created : 05/20/2014 nxk927 CCN Project....
Changed : 

<STORE_DRAFTS_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
 <STORE_DRAFTS_DETAIL>
  <STORE_DRAFTS_DETAIL_ID>436223</STORE_DRAFTS_DETAIL_ID>
  <COST_CENTER_CODE>701021</COST_CENTER_CODE>
  <CHECK_SERIAL_NUMBER>0102129509</CHECK_SERIAL_NUMBER>
  <TRANSACTION_DATE>03-30-2012</TRANSACTION_DATE>
 </STORE_DRAFTS_DETAIL>
</<STORE_DRAFTS_DETAIL_UI_SP>

*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE CUSTOMER_UI_SP (
/*******************************************************************************
    CUSTOMER_UI_SP

    This procedure is intended to RETURN a ref cursor with data from CUSTOMER table

Created : 05/22/2014 nxk927 CCN Project....
Changed : 06/16/2014 AXK326/SXT410 Added new filters(Transaction data filter tag
          and Issue date filter tag).
          
<CUSTOMER_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
 <CUSTOMER>
  <COST_CENTER_CODE>701030</COST_CENTER_CODE>
  <TRANSACTION_DATE>03-30-2012</TRANSACTION_DATE>
  <TRANSACTION_DATE_START>03-30-2012</TRANSACTION_DATE_START> 
  <TRANSACTION_DATE_END>05-18-2012</TRANSACTION_DATE_END>
  <TERMINAL_NUMBER>10232</TERMINAL_NUMBER>
  <TRANSACTION_NUMBER>95239</TRANSACTION_NUMBER>
  <ISSUE_DATE_START>03-30-2012</ISSUE_DATE_START>
  <ISSUE_DATE_END>05-18-2012</ISSUE_DATE_END>
 </CUSTOMER>
</<CUSTOMER_UI_SP>

*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE UNATTACHED_MNL_DRFT_DTL_UI_SP (
/*******************************************************************************
	UNATTACHED_MNL_DRFT_DTL_UI_SP

	This procedure is intended to RETURN a ref cursor with data from UNATTACHED_MNL_DRFT_DTL table

Created : 05/20/2014 nxk927 CCN Project....
Changed : 

<UNATTACHED_MNL_DRFT_DTL_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
 <UNATTACHED_MNL_DRFT_DTL>
  <COST_CENTER_CODE>701030</COST_CENTER_CODE>
  <CHECK_SERIAL_NUMBER>0103032009</CHECK_SERIAL_NUMBER>
  <TRANSACTION_DATE>03-30-2012</TRANSACTION_DATE>
  <TERM_NUMBER>10232</TERM_NUMBER>
 </UNATTACHED_MNL_DRFT_DTL>
</<UNATTACHED_MNL_DRFT_DTL_UI_SP>

*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE CUSTOMER_SALES_TAX_UI_SP (
/*******************************************************************************
	CUSTOMER_SALES_TAX_UI_SP

	This procedure is intended to RETURN a ref cursor with data from CUSTOMER_SALES_TAX table

Created : 05/20/2014 nxk927 CCN Project....
Changed : 

      
<CUSTOMER_SALES_TAX_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
 <CUSTOMER_SALES_TAX>
  <CUSTOMER_SALES_TAX_ID>45646</CUSTOMER_SALES_TAX_ID>
  <COST_CENTER_CODE>701030</COST_CENTER_CODE>
  <TRANSACTION_DATE>03-30-2012</TRANSACTION_DATE>
  <TERM_NUMBER>10232</TERM_NUMBER>
  <TRANSACTION_NUMBER>95239</TRANSACTION_NUMBER>
 </CUSTOMER_SALES_TAX>
</<CUSTOMER_SALES_TAX_UI_SP>

*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);


END SD_UI_INTERFACE_APP_PKG;