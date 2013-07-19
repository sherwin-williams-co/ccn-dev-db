CREATE OR REPLACE
PACKAGE errpkg 
/*********************************************************** 
This package will hold all procedures/functions used to process business
and system errors throughout the entire CCN applications

created : 12/02/11 blr CCN project
revisions: 

************************************************************/
IS
PROCEDURE raise_err (
/*********************************************************** 
This procedure will raise errors to the calling procedure/application
depending on the error number input data. 


created : 12/02/11 blr CCN project
revisions: 

************************************************************/
err_in IN INTEGER, 
err_proc_in IN VARCHAR2
,err_text_in IN VARCHAR2 := NULL)
;

--PROCEDURE recNstop (err_in IN INTEGER := SQLCODE,
--      msg_in IN VARCHAR2 := NULL);
--PROCEDURE recNgo (err_in IN INTEGER := SQLCODE,
--      msg_in IN VARCHAR2 := NULL);
FUNCTION errtext 
/*********************************************************** 
This function will determine correct message to be returned
depending on the error number input data. 


created : 12/02/11 blr CCN project
revisions: 

************************************************************/
(err_in IN INTEGER
,err_proc_in IN VARCHAR2
,err_text_in IN VARCHAR2 := NULL) 
RETURN VARCHAR2;
END errpkg;

/