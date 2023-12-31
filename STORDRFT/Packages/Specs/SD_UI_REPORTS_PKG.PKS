create or replace PACKAGE SD_UI_REPORTS_PKG
/**************************************************************** 
This package will be used by UI for reporting purpose
created : 11/03/2014 jxc517 CCN Project....
changed : 04/16/2015 jxc517 CCN Project
          Removed SD_FILTER_RECORD_TYPE and LOAD_FILTER_TABLE 
*****************************************************************/
IS

PROCEDURE STORE_DRAFTS_FILTER_S_SP (
/*******************************************************************************
	STORE_DRAFTS_FILTER_S_SP

	This procedure is intended to select records from STORE_DRAFTS & UNATTACHED_MNL_DRFT_DTL table
  with all fields part of the filtering

Created : 10/27/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT SD_TABLE_IU_PKG.REF_CURSOR);

PROCEDURE STORE_DRAFTS_DTL_FILTER_S_SP (
/*******************************************************************************
	STORE_DRAFTS_DTL_FILTER_S_SP

	This procedure is intended to select records from STORE_DRAFTS_DETAIL table

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

Created : 11/03/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT SD_TABLE_IU_PKG.REF_CURSOR);

PROCEDURE SD_1099_CONSOLIDATED_RPT(
/******************************************************************************
  This procedure is a wrapper for store draft 1099 info feed to ap report

Created : 06/09/2015 jxc517 CCN Project....
Changed : 06/16/2016 jxc517 CCN Project Team....
          changed the parameters from IN_FSS_SENT_ST_DT and IN_FSS_SENT_END_DT
          to IN_START_DATE and IN_END_DATE
*******************************************************************************/
IN_START_DATE       IN     DATE,
IN_END_DATE         IN     DATE);

END SD_UI_REPORTS_PKG;