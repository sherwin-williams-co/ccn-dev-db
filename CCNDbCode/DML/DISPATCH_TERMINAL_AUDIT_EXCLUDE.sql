/***************************************************************************
   This script disables audit back feed for DISPATCH_TERMINAL by inserting into CCN_AUDIT_EXCLUDED_TABLES
   The purpose is to disable backfeed for DISPATCH_terminal and send the backfeed on DISPATCH_TERMINAL TO MAinframe as A "STORE" record.
   Created : 06/23/2017 rxa457
****************************************************************************/

REM INSERTING into CCN_AUDIT_EXCLUDED_TABLES
SET DEFINE OFF;
Insert into CCN_AUDIT_EXCLUDED_TABLES (TABLE_NAME,EXCLUDED_INDICATOR) values ('DISPATCH_TERMINAL','Y');
