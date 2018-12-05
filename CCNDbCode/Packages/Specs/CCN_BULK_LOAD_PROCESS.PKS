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

created : 11/30/2018, sxg151, CCN Project.... ASP-1156

*******************************************************************************/
    IN_BULK_LOAD_PROCESS_ID   IN     NUMBER,
    OUT_CLOB                     OUT CLOB,
    OUT_FILE_NAME                OUT VARCHAR2
);

PROCEDURE BULK_LOAD_PROCESSES_UI_SP(
/*******************************************************************************
This procedure is to get the details from the BULK_LOAD_PROCESSES table

created : 11/30/2018, sxg151, CCN Project.... ASP-1156

*******************************************************************************/
    OUT_BULK_PRC_DETAILS           OUT  SYS_REFCURSOR)
;
END CCN_BULK_LOAD_PROCESS;