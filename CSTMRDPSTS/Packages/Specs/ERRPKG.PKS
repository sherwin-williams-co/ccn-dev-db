create or replace PACKAGE ERRPKG
AS
/*********************************************************** 
This package will hold all procedures/functions used to process business
and system errors throughout the entire Banking application

Created : 09/27/2015 sxh487 CCN Project....
Changed :
************************************************************/
TYPE ERROR_WARNINGS_RECORD_TYPE IS RECORD(ERR_CODE VARCHAR2(100),
                                          ERR_MSG VARCHAR2(500));
TYPE ERROR_WARNINGS_TABLE_TYPE IS TABLE OF ERROR_WARNINGS_RECORD_TYPE INDEX BY BINARY_INTEGER;
ERROR_WARNINGS_TABLE     ERROR_WARNINGS_TABLE_TYPE;

PROCEDURE raise_err(
/*********************************************************** 
This procedure will raise errors to the calling procedure/application
depending on the error number input data. 

Created : 09/27/2015 sxh487 CCN Project....
Changed :
************************************************************/
err_in      IN     INTEGER, 
err_proc_in IN     VARCHAR2,
err_text_in IN     VARCHAR2 := NULL);

FUNCTION errtext(
/*********************************************************** 
This function will determine correct message to be returned
depending on the error number input data. 

Created : 09/27/2015 sxh487 CCN Project....
Changed :
************************************************************/
err_in      IN     INTEGER,
err_proc_in IN     VARCHAR2,
err_text_in IN     VARCHAR2 := NULL) RETURN VARCHAR2;

PROCEDURE INSERT_ERROR_LOG_SP  (
/*******************************************************************************
This Procedure logs Processing Errors to the ERROR_LOG Table
  
created : 09/27/2017 sxh487 CCN Project....
changed :
*******************************************************************************/
    in_code                      IN   VARCHAR2
   ,in_proc                      IN   VARCHAR2
   ,in_errm                      IN   VARCHAR2  
   ,in_cost_center_code          IN   VARCHAR2
   ,in_customer_account_number   IN   VARCHAR2
   ,in_table_name                IN     VARCHAR2
   );
   
PROCEDURE STORE_WARNINGS(
/*******************************************************************************
  This Procedure logs Processing Warnings into the Memory Table
  
Created : 09/27/2015 sxh487 CCN Project....
Changed :
*******************************************************************************/
err_Code IN VARCHAR2,
err_Msg  IN VARCHAR2);

PROCEDURE RAISE_WARNINGS
/*******************************************************************************
  This Procedure raises first of the stored Warnings from the Memory Table
  
Created : 09/27/2015 sxh487 CCN Project....
Changed :
*******************************************************************************/
;

END ERRPKG;