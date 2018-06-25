create or replace PACKAGE CCN_ACCOUNTING_PKG AS
/****************************************************************************** 
This package is used to load the table into CCN_ACCOUNTING_TBL 
and generate report from CCN_ACCOUNTING_TBL attributes. 

created : 06/16/2017 axt754 -- CCN Project Team...

******************************************************************************/

PROCEDURE GEN_CCN_ACCOUNTING_REPORT
/****************************************************************************** 
This PROCEDURE is calls columns from CCN_ACCOUNTING_TBL and generate CLOB for
calling MAIL_PKG. 

created : 06/16/2017 axt754 -- CCN Project Team

******************************************************************************/
      ;
      
PROCEDURE LOAD_CCN_ACCOUNTING_TABLE(
/****************************************************************************** 
This PROCEDURE loads the data into CCN_ACCOUNTING_TBL

created : 06/16/2017 axt754 -- CCN Project Team

******************************************************************************/
IN_DATE IN DATE)
;

PROCEDURE SEND_EPM_FILES
/****************************************************************************** 
 This procedure will generate the Account Report and EPM Files and email the files.
Created : 05/31/2018 sxg151 -- CCN Project Team
Changed :
******************************************************************************/
;

END CCN_ACCOUNTING_PKG;