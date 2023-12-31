create or replace PACKAGE SD_UI_INTERFACE_APP_PKG
AS
/**********************************************************
	SD_UI_INTERFACE_APP_PKG

	This Package is intended to be the wrapper for all Store draft
  related packages that are invoked from UI

created : 05/02/2013 jxc517 CCN Project....
changed : 08/20/2019 axm868 CCN Project....
          CCNCC-9 Removed FSS_ON_DEMAND_BATCH_RUN procedure
          as part of code cleanup
**********************************************************/

TYPE REF_CURSOR IS REF CURSOR;

FUNCTION EXTRACT_TABLE_CLOB (
/*******************************************************************************
	EXTRACT_TABLE_CLOB

	This procedure will extract the required clob from passed XML clob
  and sends back the result as clob

Created : 05/07/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB) RETURN CLOB;

PROCEDURE CUSTOMER_FORM_OF_PAY_UI_SP (
/*******************************************************************************
	CUSTOMER_FORM_OF_PAY_UI_SP

	This procedure is intended to RETURN a ref cursor with data from CUSTOMER_FORM_OF_PAY table

<CUSTOMER_FORM_OF_PAY_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
   <CUSTOMER_FORM_OF_PAY>
    <COST_CENTER_CODE>702345</COST_CENTER_CODE>
    <TRANSACTION_DATE>03-30-2012</TRANSACTION_DATE>
    <TERMINAL_NUMBER>12345</TERMINAL_NUMBER>
    <TRANSACTION_NUMBER>12345</TRANSACTION_NUMBER>
    <SEGMENT_CODE>12</SEGMENT_CODE>
  	<SUB_SEGMENT_CODE>12</SUB_SEGMENT_CODE>
    </CUSTOMER_FORM_OF_PAY>
 </CUSTOMER_FORM_OF_PAY_UI_SP>

Created : 05/20/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE CUSTOMER_BANK_CARD_UI_SP (
/*******************************************************************************
	CUSTOMER_BANK_CARD_UI_SP

	This procedure is intended to RETURN a ref cursor with data from CUSTOMER_BANK_CARD table

<CUSTOMER_BANK_CARD_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
  <CUSTOMER_BANK_CARD>
		<COST_CENTER_CODE>701221</COST_CENTER_CODE>
    <CUSTOMER_BANK_CARD_ID>436245</CUSTOMER_BANK_CARD_ID>
		<TRANSACTION_DATE>03-30-2012</TRANSACTION_DATE>
		<TERMINAL_NUMBER>15767</TERMINAL_NUMBER>
		<TRANSACTION_NUMBER>16086</TRANSACTION_NUMBER>
		<SEGMENT_CODE>07</SEGMENT_CODE>
		<SUB_SEGMENT_CODE>12</SUB_SEGMENT_CODE>
		</CUSTOMER_BANK_CARD>
 </CUSTOMER_BANK_CARD_UI_SP>

Created : 05/20/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE CUSTOMER_DETAILS_UI_SP (
/*******************************************************************************
	CUSTOMER_DETAILS_UI_SP

	This procedure is intended to RETURN a ref cursor with data from CUSTOMER_DETAILS table

<CUSTOMER_DETAILS_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
 	<CUSTOMER_DETAILS>
    <CUSTOMER_DETAIL_ID>436236</CUSTOMER_DETAIL_ID>
		<COST_CENTER_CODE>701030</COST_CENTER_CODE>
		<TRANSACTION_DATE>03-30-2012</TRANSACTION_DATE>
		<TERMINAL_NUMBER>10232</TERMINAL_NUMBER>
		<TRANSACTION_NUMBER>07713</TRANSACTION_NUMBER>
		<SEGMENT_CODE>01</SEGMENT_CODE>
		<SALES_NUMBER>005849542</SALES_NUMBER>
  	</CUSTOMER_DETAILS>
 </CUSTOMER_DETAILS_UI_SP>

Created : 05/20/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE STORE_DRAFTS_UI_SP (
/*******************************************************************************
	STORE_DRAFTS_UI_SP

	This procedure is intended to RETURN a ref cursor with data from STORE_DRAFTS table

<STORE_DRAFTS_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
 <STORE_DRAFTS>
  <STORE_DRAFT_INDICATOR>NONE/PAID/VOID/STOP/OPEN/MNL_DRFT</STORE_DRAFT_INDICATOR>
  <COST_CENTER_CODE>701030</COST_CENTER_CODE>
  <CHECK_SERIAL_NUMBER>0103032009</CHECK_SERIAL_NUMBER>
  <CHECK_RANGE_START>0103032009</CHECK_RANGE_START>
  <CHECK_RANGE_END>0103032124</CHECK_RANGE_END>
  <TRANSACTION_DATE>03-30-2012</TRANSACTION_DATE>
  <TRANSACTION_DATE_START>03-30-2012</TRANSACTION_DATE_START>
  <TRANSACTION_DATE_END>05-18-2012</TRANSACTION_DATE_END>
  <PAID_DATE_START>03-30-2012</PAID_DATE_START>
  <PAID_DATE_END>05-18-2012</PAID_DATE_END>
  <ISSUE_DATE_START>03-30-2012</ISSUE_DATE_START>
  <ISSUE_DATE_END>05-18-2012</ISSUE_DATE_END>
 </STORE_DRAFTS>
</<STORE_DRAFTS_UI_SP>

Created : 05/20/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE STORE_DRAFTS_FILTER_UI_SP (
/*******************************************************************************
	STORE_DRAFTS_FILTER_UI_SP

	This procedure is intended to select records from STORE_DRAFTS & UNATTACHED_MNL_DRFT_DTL table
  with all fields part of the filtering

<STORE_DRAFTS_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
 <STORE_DRAFTS>
  <STORE_DRAFT_INDICATOR>NONE/PAID/VOID/STOP/OPEN/MNL_DRFT</STORE_DRAFT_INDICATOR>
  <COST_CENTER_CODE>701030</COST_CENTER_CODE>
  <CHECK_SERIAL_NUMBER>0103032009</CHECK_SERIAL_NUMBER>
  <CHECK_RANGE_START>0103032009</CHECK_RANGE_START>
  <CHECK_RANGE_END>0103032124</CHECK_RANGE_END>
  <TRANSACTION_DATE>03-30-2012</TRANSACTION_DATE>
  <TRANSACTION_DATE_START>03-30-2012</TRANSACTION_DATE_START>
  <TRANSACTION_DATE_END>05-18-2012</TRANSACTION_DATE_END>
  <PAID_DATE_START>03-30-2012</PAID_DATE_START>
  <PAID_DATE_END>05-18-2012</PAID_DATE_END>
  <ISSUE_DATE_START>03-30-2012</ISSUE_DATE_START>
  <ISSUE_DATE_END>05-18-2012</ISSUE_DATE_END>
  <TRANSACTION_CODE>13,19,31,82,94,98</TRANSACTION_CODE>
 </STORE_DRAFTS>
 <STORE_DRAFTS>
  <STORE_DRAFT_INDICATOR>NONE/PAID/VOID/STOP/OPEN/MNL_DRFT</STORE_DRAFT_INDICATOR>
  <COST_CENTER_CODE>701030</COST_CENTER_CODE>
  <CHECK_SERIAL_NUMBER>0103032009</CHECK_SERIAL_NUMBER>
  <CHECK_RANGE_START>0103032009</CHECK_RANGE_START>
  <CHECK_RANGE_END>0103032124</CHECK_RANGE_END>
  <TRANSACTION_DATE>03-30-2012</TRANSACTION_DATE>
  <TRANSACTION_DATE_START>03-30-2012</TRANSACTION_DATE_START>
  <TRANSACTION_DATE_END>05-18-2012</TRANSACTION_DATE_END>
  <PAID_DATE_START>03-30-2012</PAID_DATE_START>
  <PAID_DATE_END>05-18-2012</PAID_DATE_END>
  <ISSUE_DATE_START>03-30-2012</ISSUE_DATE_START>
  <ISSUE_DATE_END>05-18-2012</ISSUE_DATE_END>
  <TRANSACTION_CODE>13,19,31,82,94,98</TRANSACTION_CODE>
 </STORE_DRAFTS>
 </<STORE_DRAFTS_UI_SP>

Created : 10/27/2014 jxc517 CCN Project....
Changed : 03/04/2015 jxc517 CCN Project....
          Modified code to handle multiple filters at the same time and return
          the concatenated result set along with the total records count
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE STORE_DRAFTS_DETAIL_UI_SP (
/*******************************************************************************
	STORE_DRAFTS_DETAIL_UI_SP

	This procedure is intended to RETURN a ref cursor with data from STORE_DRAFTS_DETAIL table

<STORE_DRAFTS_DETAIL_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
 <STORE_DRAFTS_DETAIL>
  <STORE_DRAFTS_DETAIL_ID>436223</STORE_DRAFTS_DETAIL_ID>
  <COST_CENTER_CODE>701021</COST_CENTER_CODE>
  <CHECK_SERIAL_NUMBER>0102129509</CHECK_SERIAL_NUMBER>
  <TRANSACTION_DATE>03-30-2012</TRANSACTION_DATE>
 </STORE_DRAFTS_DETAIL>
</<STORE_DRAFTS_DETAIL_UI_SP>

Created : 05/20/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE STORE_DRAFTS_DTL_FILTER_UI_SP (
/*******************************************************************************
	STORE_DRAFTS_DTL_FILTER_UI_SP

	This procedure is intended to RETURN a ref cursor with data from STORE_DRAFTS_DETAIL table

<?xml version="1.0" encoding="UTF-8" ?>
<STORE_DRAFTS_DETAIL_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
<STORE_DRAFTS_DETAIL>
<STORE_DRAFTS_DETAIL_ID>XXXXXXXXXXXXXXXXXXXXXX</STORE_DRAFTS_DETAIL_ID>
<COST_CENTER_CODE>XXXXXXXXXXXXXXXXXXXXXXXX</COST_CENTER_CODE>
<CHECK_SERIAL_NUMBER>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</CHECK_SERIAL_NUMBER>
  <TRANSACTION_DATE>03-30-2012</TRANSACTION_DATE>
  <TRANSACTION_DATE_START>03-30-2012</TRANSACTION_DATE_START>
<TERMINAL_NUMBER>XXXXXXXXXXXXXXXXXXXX</TERMINAL_NUMBER>
<TRANSACTION_NUMBER>XXXXXXXXXXXXXXXXXXXX</TRANSACTION_NUMBER>
<CUSTOMER_ACCOUNT_NUMBER>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</CUSTOMER_ACCOUNT_NUMBER>
<CUSTOMER_JOB_NUMBER>XXXXXXXX</CUSTOMER_JOB_NUMBER>
<GL_PRIME_ACCOUNT_NUMBER>XXXXXXXXXXXXXXXX</GL_PRIME_ACCOUNT_NUMBER>
<GL_SUB_ACCOUNT_NUMBER>XXXXXXXXXXXX</GL_SUB_ACCOUNT_NUMBER>
<ITEM_QUANTITY>XXXXXXXXXXXXXXXXXXXXXX</ITEM_QUANTITY>
<ITEM_PRICE>XXXXXXXXXXXXXXXXXXXXXX</ITEM_PRICE>
<ITEM_EXT_AMOUNT>XXXXXXXXXXXXXXXXXXXXXX</ITEM_EXT_AMOUNT>
<BOOK_DATE_SEQUENCE>XXXXXXXXXXXXXXXXXXXX</BOOK_DATE_SEQUENCE>
<LBR_TRANSACTION_DATE>MM-DD-RRRR</LBR_TRANSACTION_DATE>
<LBR_TERMINAL_NUMBER>XXXXXXXXXXXXXXXXXXXX</LBR_TERMINAL_NUMBER>
<LBR_TRANSACTION_NUMBER>XXXXXXXXXXXXXXXXXXXX</LBR_TRANSACTION_NUMBER>
</STORE_DRAFTS_DETAIL>
</STORE_DRAFTS_DETAIL_UI_SP>

Created : 11/03/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE CUSTOMER_UI_SP (
/*******************************************************************************
    CUSTOMER_UI_SP

    This procedure is intended to RETURN a ref cursor with data from CUSTOMER table

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

Created : 05/22/2014 nxk927 CCN Project....
Changed : 06/16/2014 AXK326/SXT410 Added new filters(Transaction data filter tag
          and Issue date filter tag).
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE UNATTACHED_MNL_DRFT_DTL_UI_SP (
/*******************************************************************************
	UNATTACHED_MNL_DRFT_DTL_UI_SP

	This procedure is intended to RETURN a ref cursor with data from UNATTACHED_MNL_DRFT_DTL table

<UNATTACHED_MNL_DRFT_DTL_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
 <UNATTACHED_MNL_DRFT_DTL>
  <COST_CENTER_CODE>701030</COST_CENTER_CODE>
  <CHECK_SERIAL_NUMBER>0103032009</CHECK_SERIAL_NUMBER>
  <TRANSACTION_DATE>03-30-2012</TRANSACTION_DATE>
  <TERMINAL_NUMBER>10232</TERMINAL_NUMBER>
 </UNATTACHED_MNL_DRFT_DTL>
</<UNATTACHED_MNL_DRFT_DTL_UI_SP>

Created : 05/20/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE CUSTOMER_SALES_TAX_UI_SP (
/*******************************************************************************
	CUSTOMER_SALES_TAX_UI_SP

	This procedure is intended to RETURN a ref cursor with data from CUSTOMER_SALES_TAX table

<CUSTOMER_SALES_TAX_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
 <CUSTOMER_SALES_TAX>
  <CUSTOMER_SALES_TAX_ID>45646</CUSTOMER_SALES_TAX_ID>
  <COST_CENTER_CODE>701030</COST_CENTER_CODE>
  <TRANSACTION_DATE>03-30-2012</TRANSACTION_DATE>
  <TERMINAL_NUMBER>10232</TERMINAL_NUMBER>
  <TRANSACTION_NUMBER>95239</TRANSACTION_NUMBER>
 </CUSTOMER_SALES_TAX>
</<CUSTOMER_SALES_TAX_UI_SP>

Created : 05/20/2014 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE HST_STORE_DRAFTS_UI_SP (
/*******************************************************************************
	HST_STORE_DRAFTS_UI_SP

	This procedure is intended to select records from HST_STORE_DRAFTS table

<?xml version="1.0" encoding="UTF-8" ?>
<HST_STORE_DRAFTS_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
<HST_STORE_DRAFTS>
<COST_CENTER_CODE>XXXXXXXXXXXXXXXXXXXXXXXX</COST_CENTER_CODE>
<CHECK_SERIAL_NUMBER>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</CHECK_SERIAL_NUMBER>
<TRANSACTION_DATE>MM-DD-RRRR</TRANSACTION_DATE>
<TERMINAL_NUMBER>XXXXXXXXXXXXXXXXXXXX</TERMINAL_NUMBER>
<TRANSACTION_NUMBER>XXXXXXXXXXXXXXXXXXXX</TRANSACTION_NUMBER>
<CUSTOMER_ACCOUNT_NUMBER>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</CUSTOMER_ACCOUNT_NUMBER>
<CUSTOMER_JOB_NUMBER>XXXXXXXX</CUSTOMER_JOB_NUMBER>
<POS_TRANSACTION_CODE>XXXXXXXX</POS_TRANSACTION_CODE>
<POS_TRANSACTION_TIME>XXXXXXXXXXXXXXXX</POS_TRANSACTION_TIME>
<BANK_NUMBER>XXXXXXXXXXXX</BANK_NUMBER>
<BANK_ACCOUNT_NUMBER>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</BANK_ACCOUNT_NUMBER>
<BANK_REFERENCE>XXXXXXXXXXXXXXXXXXXXXXXX</BANK_REFERENCE>
<PAYEE_NAME>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</PAYEE_NAME>
<ADDRESS_LINE_1>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</ADDRESS_LINE_1>
<ADDRESS_LINE_2>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</ADDRESS_LINE_2>
<CITY>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</CITY>
<STATE_CODE>XXXXXXXX</STATE_CODE>
<ZIP_CODE_PREFIX>XXXXXXXXXXXXXXXXXXXXXXXX</ZIP_CODE_PREFIX>
<ZIP_CODE_SUFFIX>XXXXXXXXXXXXXXXX</ZIP_CODE_SUFFIX>
<PHONE_AREA_CODE>XXXXXXXXXXXX</PHONE_AREA_CODE>
<PHONE_NUMBER>XXXXXXXXXXXXXXXXXXXXXXXXXXXX</PHONE_NUMBER>
<EMPLOYEE_NUMBER>XXXXXXXX</EMPLOYEE_NUMBER>
<ISSUE_DATE>MM-DD-RRRR</ISSUE_DATE>
<PAID_DATE>MM-DD-RRRR</PAID_DATE>
<STOP_PAY_DATE>MM-DD-RRRR</STOP_PAY_DATE>
<STOP_PAY_REMOVE_DATE>MM-DD-RRRR</STOP_PAY_REMOVE_DATE>
<VOID_DATE>MM-DD-RRRR</VOID_DATE>
<AMOUNT_CHANGE_DATE>MM-DD-RRRR</AMOUNT_CHANGE_DATE>
<GROSS_AMOUNT>XXXXXXXXXXXXXXXXXXXXXX</GROSS_AMOUNT>
<RETAIN_AMOUNT>XXXXXXXXXXXXXXXXXXXXXX</RETAIN_AMOUNT>
<NET_AMOUNT>XXXXXXXXXXXXXXXXXXXXXX</NET_AMOUNT>
<ORIGINAL_NET_AMOUNT>XXXXXXXXXXXXXXXXXXXXXX</ORIGINAL_NET_AMOUNT>
<BANK_PAID_AMOUNT>XXXXXXXXXXXXXXXXXXXXXX</BANK_PAID_AMOUNT>
<TRANSACTION_SOURCE>XXXX</TRANSACTION_SOURCE>
<CHANGE_DATE>MM-DD-RRRR</CHANGE_DATE>
<CHANGE_SOURCE>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</CHANGE_SOURCE>
<SLS_BOOK_DATE>XXXXXXXXXXXXXXXX</SLS_BOOK_DATE>
<CYCLE_RUN_NUMBER>XXXXXXXX</CYCLE_RUN_NUMBER>
<BOOK_DATE_SEQUENCE>XXXXXXXXXXXXXXXXXXXX</BOOK_DATE_SEQUENCE>
<REASON_CODE>XXXXXXXX</REASON_CODE>
<DRAFT_NUMBER>XXXXXXXXXXXXXXXX</DRAFT_NUMBER>
<VOID_INDICATOR>X</VOID_INDICATOR>
<PAY_INDICATOR>X</PAY_INDICATOR>
<STOP_INDICATOR>X</STOP_INDICATOR>
<OPEN_INDICATOR>X</OPEN_INDICATOR>
</HST_STORE_DRAFTS>
</HST_STORE_DRAFTS_UI_SP>

Created : 09/16/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE HST_STORE_DRAFTS_DETAIL_UI_SP (
/*******************************************************************************
	HST_STORE_DRAFTS_DETAIL_UI_SP

	This procedure is intended to select records from HST_STORE_DRAFTS_DETAIL table

<?xml version="1.0" encoding="UTF-8" ?>
<HST_STORE_DRAFTS_DETAIL_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
<HST_STORE_DRAFTS_DETAIL>
<STORE_DRAFTS_DETAIL_ID>XXXXXXXXXXXXXXXXXXXXXX</STORE_DRAFTS_DETAIL_ID>
<COST_CENTER_CODE>XXXXXXXXXXXXXXXXXXXXXXXX</COST_CENTER_CODE>
<CHECK_SERIAL_NUMBER>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</CHECK_SERIAL_NUMBER>
<TRANSACTION_DATE>MM-DD-RRRR</TRANSACTION_DATE>
<TERMINAL_NUMBER>XXXXXXXXXXXXXXXXXXXX</TERMINAL_NUMBER>
<TRANSACTION_NUMBER>XXXXXXXXXXXXXXXXXXXX</TRANSACTION_NUMBER>
<CUSTOMER_ACCOUNT_NUMBER>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</CUSTOMER_ACCOUNT_NUMBER>
<CUSTOMER_JOB_NUMBER>XXXXXXXX</CUSTOMER_JOB_NUMBER>
<GL_PRIME_ACCOUNT_NUMBER>XXXXXXXXXXXXXXXX</GL_PRIME_ACCOUNT_NUMBER>
<GL_SUB_ACCOUNT_NUMBER>XXXXXXXXXXXX</GL_SUB_ACCOUNT_NUMBER>
<ITEM_QUANTITY>XXXXXXXXXXXXXXXXXXXXXX</ITEM_QUANTITY>
<ITEM_PRICE>XXXXXXXXXXXXXXXXXXXXXX</ITEM_PRICE>
<ITEM_EXT_AMOUNT>XXXXXXXXXXXXXXXXXXXXXX</ITEM_EXT_AMOUNT>
<BOOK_DATE_SEQUENCE>XXXXXXXXXXXXXXXXXXXX</BOOK_DATE_SEQUENCE>
<LBR_TRANSACTION_DATE>MM-DD-RRRR</LBR_TRANSACTION_DATE>
<LBR_TERMINAL_NUMBER>XXXXXXXXXXXXXXXXXXXX</LBR_TERMINAL_NUMBER>
<LBR_TRANSACTION_NUMBER>XXXXXXXXXXXXXXXXXXXX</LBR_TRANSACTION_NUMBER>
</HST_STORE_DRAFTS_DETAIL>
</HST_STORE_DRAFTS_DETAIL_UI_SP>

Created : 09/16/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE SD_BANK_FILE_SENT_DTLS_UI_SP (
/*******************************************************************************
	SD_BANK_FILE_SENT_DTLS_UI_SP

	This procedure is intended to select records from SD_BANK_FILE_SENT_DETAILS table

<?xml version="1.0" encoding="UTF-8" ?>
<SD_BANK_FILE_SENT_DETAILS_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
<SD_BANK_FILE_SENT_DETAILS>
<COST_CENTER_CODE>XXXXXX</COST_CENTER_CODE>
<CHECK_SERIAL_NUMBER>XXXXXXXXXX</CHECK_SERIAL_NUMBER>
<PROCESS_DATE>MM-DD-RRRR</PROCESS_DATE>
<SENT_DATE>MM-DD-RRRR</SENT_DATE>
</SD_BANK_FILE_SENT_DETAILS>
</SD_BANK_FILE_SENT_DETAILS_UI_SP>

Created : 09/22/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE STORE_DRAFTS_UI_UPSERT (
/*******************************************************************************
	STORE_DRAFTS_UI_UPSERT

	This procedure is intended to INSERT/UPDATE data in STORE_DRAFTS table

Created : 07/02/2014 jxc517 CCN Project....
Changed : 

<?xml version="1.0" encoding="UTF-8" ?>
<STORE_DRAFTS_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
<STORE_DRAFTS>
<COST_CENTER_CODE>XXXXXXXXXXXXXXXXXXXXXXXX</COST_CENTER_CODE>
<CHECK_SERIAL_NUMBER>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</CHECK_SERIAL_NUMBER>
<TRANSACTION_DATE>MM-DD-RRRR</TRANSACTION_DATE>
<TERMINAL_NUMBER>XXXXXXXXXXXXXXXXXXXX</TERMINAL_NUMBER>
<TRANSACTION_NUMBER>XXXXXXXXXXXXXXXXXXXX</TRANSACTION_NUMBER>
<CUSTOMER_ACCOUNT_NUMBER>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</CUSTOMER_ACCOUNT_NUMBER>
<CUSTOMER_JOB_NUMBER>XXXXXXXX</CUSTOMER_JOB_NUMBER>
<POS_TRANSACTION_CODE>XXXXXXXX</POS_TRANSACTION_CODE>
<POS_TRANSACTION_TIME>XXXXXXXXXXXXXXXX</POS_TRANSACTION_TIME>
<BANK_NUMBER>XXXXXXXXXXXX</BANK_NUMBER>
<BANK_ACCOUNT_NUMBER>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</BANK_ACCOUNT_NUMBER>
<BANK_REFERENCE>XXXXXXXXXXXXXXXXXXXXXXXX</BANK_REFERENCE>
<PAYEE_NAME>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</PAYEE_NAME>
<ADDRESS_LINE_1>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</ADDRESS_LINE_1>
<ADDRESS_LINE_2>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</ADDRESS_LINE_2>
<CITY>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</CITY>
<STATE_CODE>XXXXXXXX</STATE_CODE>
<ZIP_CODE_PREFIX>XXXXXXXXXXXXXXXXXXXXXXXX</ZIP_CODE_PREFIX>
<ZIP_CODE_SUFFIX>XXXXXXXXXXXXXXXX</ZIP_CODE_SUFFIX>
<PHONE_AREA_CODE>XXXXXXXXXXXX</PHONE_AREA_CODE>
<PHONE_NUMBER>XXXXXXXXXXXXXXXXXXXXXXXXXXXX</PHONE_NUMBER>
<EMPLOYEE_NUMBER>XXXXXXXX</EMPLOYEE_NUMBER>
<ISSUE_DATE>MM-DD-RRRR</ISSUE_DATE>
<PAID_DATE>MM-DD-RRRR</PAID_DATE>
<STOP_PAY_DATE>MM-DD-RRRR</STOP_PAY_DATE>
<STOP_PAY_REMOVE_DATE>MM-DD-RRRR</STOP_PAY_REMOVE_DATE>
<VOID_DATE>MM-DD-RRRR</VOID_DATE>
<AMOUNT_CHANGE_DATE>MM-DD-RRRR</AMOUNT_CHANGE_DATE>
<GROSS_AMOUNT>XXXXXXXXXXXXXXXXXXXXXX</GROSS_AMOUNT>
<RETAIN_AMOUNT>XXXXXXXXXXXXXXXXXXXXXX</RETAIN_AMOUNT>
<NET_AMOUNT>XXXXXXXXXXXXXXXXXXXXXX</NET_AMOUNT>
<ORIGINAL_NET_AMOUNT>XXXXXXXXXXXXXXXXXXXXXX</ORIGINAL_NET_AMOUNT>
<BANK_PAID_AMOUNT>XXXXXXXXXXXXXXXXXXXXXX</BANK_PAID_AMOUNT>
<TRANSACTION_SOURCE>XXXX</TRANSACTION_SOURCE>
<CHANGE_DATE>MM-DD-RRRR</CHANGE_DATE>
<CHANGE_SOURCE>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</CHANGE_SOURCE>
<SLS_BOOK_DATE>XXXXXXXXXXXXXXXX</SLS_BOOK_DATE>
<CYCLE_RUN_NUMBER>XXXXXXXX</CYCLE_RUN_NUMBER>
<BOOK_DATE_SEQUENCE>XXXXXXXXXXXXXXXXXXXX</BOOK_DATE_SEQUENCE>
<REASON_CODE>XXXXXXXX</REASON_CODE>
<DRAFT_NUMBER>XXXXXXXXXXXXXXXX</DRAFT_NUMBER>
<VOID_INDICATOR>X</VOID_INDICATOR>
<PAY_INDICATOR>X</PAY_INDICATOR>
<STOP_INDICATOR>X</STOP_INDICATOR>
<OPEN_INDICATOR>X</OPEN_INDICATOR>
</STORE_DRAFTS>
</STORE_DRAFTS_UI_SP>

*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

PROCEDURE SD_BANK_FILE_SNT_DTL_UI_UPSERT (
/*******************************************************************************
	SD_BANK_FILE_SNT_DTL_UI_UPSERT

	This procedure is intended to INSERT/UPDATE data in SD_BANK_FILE_SENT_DETAILS table

<?xml version="1.0" encoding="UTF-8" ?>
<SD_BANK_FILE_SENT_DETAILS_UI_SP xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
<SD_BANK_FILE_SENT_DETAILS>
<COST_CENTER_CODE>XXXXXX</COST_CENTER_CODE>
<CHECK_SERIAL_NUMBER>XXXXXXXXXX</CHECK_SERIAL_NUMBER>
<PROCESS_DATE>MM-DD-RRRR</PROCESS_DATE>
<SEND_INDICATOR>X</SEND_INDICATOR>
</SD_BANK_FILE_SENT_DETAILS>
<SD_BANK_FILE_SENT_DETAILS>
<COST_CENTER_CODE>XXXXXX</COST_CENTER_CODE>
<CHECK_SERIAL_NUMBER>XXXXXXXXXX</CHECK_SERIAL_NUMBER>
<PROCESS_DATE>MM-DD-RRRR</PROCESS_DATE>
<SEND_INDICATOR>X</SEND_INDICATOR>
</SD_BANK_FILE_SENT_DETAILS>
<SD_BANK_FILE_SENT_DETAILS>
<COST_CENTER_CODE>XXXXXX</COST_CENTER_CODE>
<CHECK_SERIAL_NUMBER>XXXXXXXXXX</CHECK_SERIAL_NUMBER>
<PROCESS_DATE>MM-DD-RRRR</PROCESS_DATE>
<SEND_INDICATOR>X</SEND_INDICATOR>
</SD_BANK_FILE_SENT_DETAILS>
</SD_BANK_FILE_SENT_DETAILS_UI_SP>

Created : 07/02/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

FUNCTION IS_AUTHORIZED_USER(
/**********************************************************
This function will authorize the user based on SECURITY_MATRIX table


parameters:

IN  IN_USER_ID
OUT OUT_REF_CURSOR

created : 08/27/2014 jxc517 CCN Project
modified: 
**********************************************************/
IN_USER_ID      IN     VARCHAR2,
OUT_REF_CURSOR     OUT CCN_COMMON_TOOLS.REF_CURSOR) RETURN VARCHAR2;

PROCEDURE SD_1099_CONSOLIDATED_RPT(
/******************************************************************************
  This procedure is a wrapper for store draft 1099 info feed to AP report.
  This will be generating all the 4 reports for 1099. Matched, unmatched, no vendor
  and 1099_TXPYR_ID_AP_TRNS.
  
  Parameters : 
    IN_START_DATE  : This will be the start date from when, the report is to be generated.
    IN_END_DATE    : This will be end date for the report till which, the report is expected
        
Created : 12/09/2015 nxk927 CCN Project....
Changed : 06/16/2016 jxc517 CCN Project Team....
          changed the parameters from IN_FSS_SENT_ST_DT and IN_FSS_SENT_END_DT
          to IN_START_DATE and IN_END_DATE
*******************************************************************************/
IN_START_DATE      IN     DATE,
IN_END_DATE        IN     DATE);

PROCEDURE GET_SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS(
/******************************************************************************
This procedure will get 
1) all check run type details if no input is passed
2) specific run type details if run type is passed

Created : 01/01/2019 jxc517 CCN Project Team....
Changed : 
******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
    IN_COST_CENTER_CODE                 IN     VARCHAR2,
    OUT_SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS    OUT SYS_REFCURSOR);

PROCEDURE GET_STORE_CHECK_DRAFTS_PRINT_DETAILS(
/******************************************************************************
This procedure will get 
1) get run type details and store check order details for COST_CENTER or TERMINAL_NUMBER passed.

Created : 01/01/2019 jxc517 CCN Project Team....
Changed : 
******************************************************************************/
    IN_COST_CENTER_CODE            IN     VARCHAR2,
    IN_TERMINAL_NUMBER             IN     VARCHAR2,
    OUT_STORE_RUN_TYPE_DETAILS    OUT SYS_REFCURSOR,
    OUT_SD_CHECK_NBR_TRCKNG_DTLS      OUT SYS_REFCURSOR);

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
 </SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS>
 <SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS>
   <STORE_DRAFT_CHECK_RUN_TYPE>L</STORE_DRAFT_CHECK_RUN_TYPE>
   <NO_OF_BOOKS>2</NO_OF_BOOKS>
   <CHECKS_PER_BOOK>76</CHECKS_PER_BOOK>
   <STORE_DRFT_THRESHOLD>40</STORE_DRFT_THRESHOLD>
   <BANK_ACCOUNT_NBR>9823469237</BANK_ACCOUNT_NBR>
   <BANK_ROUTING_NBR>242352353456</BANK_ROUTING_NBR>
   <CREATED_BY_USER_ID>kxm302</CREATED_BY_USER_ID>
 </SD_CHECK_NBR_RUN_TYPE_PRNT_DTLS>
</SD_CHECK_NBR_PRNT_UI>

Created : 1/11/2019 kxm302 CCN Project Team.... 
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

Created : 1/11/2019 kxm302 CCN Project Team.... 
Changed : 
**********************************************************/ 
    IN_XML                CLOB);    

PROCEDURE GET_UNUSED_DRAFTS_PRINT_DETAILS(
/******************************************************************************
This procedure will get 
1) all store check order details
2) specific store check order details if run type is passed

Created : 01/01/2019 jxc517 CCN Project Team....
Changed : 
******************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
    IN_COST_CENTER_CODE            IN     VARCHAR2,
    OUT_UNUSED_DRAFT_PRINT_DTLS       OUT SYS_REFCURSOR);

PROCEDURE SD_CHECK_NBR_PRINT_PROCESS(
/**********************************************************
This procedure will go ahead and place draft print order if unused drafts less then threshold.

Created : 1/11/2019 kxm302 CCN Project Team.... 
Changed : 9/12/2019 akj899 CCN Project Team...
          Added IN_DESIRED_ARRIVAL_TIME required for XML file generated
          as part of print check order process.
**********************************************************/
    IN_COST_CENTER_CODE            IN     VARCHAR2,
    IN_DESIRED_ARRIVAL_DATE        IN     DATE DEFAULT SYSDATE);

FUNCTION GET_DESIRED_ARRIVAL_DATE(
/**********************************************************
a.	Due date for RUSH orders will be 2nd working day from the day it is ordered (before 2 PM)
b.	Due date for RUSH orders will be 3rd working day from the day it is ordered (after 2 PM)
c.	Due date for NO-RUSH orders will always be 5th working day from the day it is ordered

Created : 10/10/2019 jxc517 CCN Project Team.... CCNSD-25
Changed : 
**********************************************************/
    IN_RUSH_IND    IN   VARCHAR2 DEFAULT 'N')
RETURN DATE;

END SD_UI_INTERFACE_APP_PKG;