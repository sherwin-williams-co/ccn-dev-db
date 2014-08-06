create or replace PACKAGE errpkg 
/*********************************************************** 
This package will hold all procedures/functions used to process business
and system errors throughout the entire CCN applications

created : 04/29/2013 jxc517 CCN Project....
changed :

************************************************************/
IS

TYPE ERROR_WARNINGS_RECORD_TYPE IS RECORD(ERR_CODE VARCHAR2(100),
                                          ERR_MSG VARCHAR2(500));
TYPE ERROR_WARNINGS_TABLE_TYPE IS TABLE OF ERROR_WARNINGS_RECORD_TYPE INDEX BY BINARY_INTEGER;
ERROR_WARNINGS_TABLE     ERROR_WARNINGS_TABLE_TYPE;

PROCEDURE raise_err (
/*********************************************************** 
This procedure will raise errors to the calling procedure/application
depending on the error number input data. 


created : 04/29/2013 jxc517 CCN Project....
changed :

************************************************************/
err_in IN INTEGER, 
err_proc_in IN VARCHAR2
,err_text_in IN VARCHAR2 := NULL)
;

FUNCTION errtext 
/*********************************************************** 
This function will determine correct message to be returned
depending on the error number input data. 


created : 04/29/2013 jxc517 CCN Project....
changed :

************************************************************/
(err_in IN INTEGER
,err_proc_in IN VARCHAR2
,err_text_in IN VARCHAR2 := NULL) 
RETURN VARCHAR2;

PROCEDURE insert_error_log_sp  (
/*******************************************************************************
  This Procedure logs Processing Errors to the ERROR_LOG Table
  
created : 04/29/2013 jxc517 CCN Project....
changed :
*******************************************************************************/
    in_code                IN   VARCHAR2
   ,in_proc                IN   VARCHAR2
   ,in_errm                IN   VARCHAR2  
   ,in_cost_center         IN   VARCHAR2
   ,in_check_serial_nbr    IN   VARCHAR2
   );
   
PROCEDURE STORE_WARNINGS(
/*******************************************************************************
  This Procedure logs Processing Warnings into the Memory Table
  
created : 04/29/2013 jxc517 CCN Project....
changed :
*******************************************************************************/
   err_Code IN VARCHAR2,
   err_Msg  IN VARCHAR2);

PROCEDURE RAISE_WARNINGS
/*******************************************************************************
  This Procedure raises first of the stored Warnings from the Memory Table
  
created : 04/29/2013 jxc517 CCN Project....
changed :
*******************************************************************************/
;

END errpkg;