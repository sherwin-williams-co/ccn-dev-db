create or replace PACKAGE ROYAL_BANK_REPORT_LOAD as 
/*******************************************************************************
This package is intended to load Royal Bank Report files from mainframe into the 
Royal Bank Report Main tables

created : 10/20/2016 mxr916 CCN project
modified:
*******************************************************************************/

PROCEDURE ROYAL_BANK_REPORT_DBT_LOAD_SP
/******************************************************************************
This Procedure loads Royal bank report data into ROYAL_BANK_RPT_MAIN table.

created : 11/17/207SXH487 CCN PROJECT..
*******************************************************************************/
;

PROCEDURE ROYAL_BANK_REPORT_DTL_LOAD_SP
/******************************************************************************
This Procedure loads Royal bank report data into ROYAL_BANK_RPT_MAIN table.

created : 11/17/207SXH487 CCN PROJECT..
*******************************************************************************/
;

PROCEDURE ROYAL_BANK_REPORT_LOAD_MAIN_SP
/******************************************************************************
This Procedure loads Royal bank report data into ROYAL_BANK_RPT_MAIN table from 
    1. ROYAL_BANK_DEBITS_EXT_TBL
    2. ROYAL_BANK_DTL_EXT_TBL

created : 11/17/207SXH487 CCN PROJECT..
*******************************************************************************/
;

END ROYAL_BANK_REPORT_LOAD;