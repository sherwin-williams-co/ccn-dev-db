create or replace PACKAGE CCN_ACCOUNTING_PKG AS
/****************************************************************************** 
This package is used to create report from CCN_ACCOUNTING_VIEW attributes. 

created : 06/16/2017 axt754 -- CCN Project Team...

******************************************************************************/
PROCEDURE GEN_CCN_ACCOUNTING_REPORT
/****************************************************************************** 
This PROCEDURE is calls columns from CCN_ACCOUNTING_VIEW and generate CLOB for
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
     
END CCN_ACCOUNTING_PKG;