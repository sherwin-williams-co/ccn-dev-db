create or replace PACKAGE   CCN_BULK_LOAD_PROCESS	AS
/***********************************************************
This package spec will have procedures and functions related
to the Dowload Templates for Bulk Load
Created  : 11/30/2018, sxg151, CCN Project...ASP-1156
Modified : 
************************************************************/
PROCEDURE BULK_LOAD_PRCSS_FILE_DTLS_UI_SP(
/*******************************************************************************
This procedure is to returns the clob built based on table and file name

Example input/output for process ID "x"

Input  :
Output : 


Created : 11/30/2018, sxg151, CCN Project.... ASP-1156
Changed :
*******************************************************************************/
    IN_BULK_LOAD_PROCESS_ID   IN       NUMBER,
    OUT_CLOB                     OUT   CLOB,
    OUT_FILE_NAME                OUT   VARCHAR2);

PROCEDURE BULK_LOAD_PROCESSES_UI_SP(
/*******************************************************************************
This procedure provides details about all bulk load processes currently existing in CCN Cost Center Schema
--UI will pass the user Id
<BATCH_PROCESS_UI>
    <USER_ID>sxg151</USER_ID>
</BATCH_PROCESS_UI>
Created : 11/30/2018, sxg151, CCN Project.... ASP-1156
Changed :
*******************************************************************************/
    in_XML                IN      VARCHAR2,
    OUT_BULK_PRC_DETAILS     OUT  SYS_REFCURSOR);

END CCN_BULK_LOAD_PROCESS;