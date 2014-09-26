create or replace PACKAGE SD_BANK_FILE_SENT_DETAILS_PKG
/**********************************************************
	SD_BANK_FILE_SENT_DETAILS_PKG

	This Package is intended to deal with SD_BANK_FILE_SENT_DETAILS table

created : 09/19/2013 jxc517 CCN Project....
changed :
**********************************************************/
    AS
	
	 	TYPE REF_CURSOR IS REF CURSOR;

--
PROCEDURE SD_BANK_FILE_SENT_DETAILS_S_SP (
/*******************************************************************************
	SD_BANK_FILE_SENT_DETAILS_S_SP

	This procedure is intended to select records from SD_BANK_FILE_SENT_DETAILS table

Created : 09/22/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE SD_BANK_FILE_SENT_DETAILS_I_SP (
/*******************************************************************************
	SD_BANK_FILE_SENT_DETAILS_I_SP

	This procedure is intended to insert records into SD_BANK_FILE_SENT_DETAILS table

Created : 09/24/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

PROCEDURE SD_BANK_FILE_SENT_DETAILS_U_SP (
/*******************************************************************************
	SD_BANK_FILE_SENT_DETAILS_U_SP

	This procedure is intended to updates records in SD_BANK_FILE_SENT_DETAILS table

Created : 09/25/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

END SD_BANK_FILE_SENT_DETAILS_PKG;

