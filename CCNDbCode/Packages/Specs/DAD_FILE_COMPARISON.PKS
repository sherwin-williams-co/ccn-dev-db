create or replace PACKAGE DAD_FILE_COMPARISON 
AS 

 PROCEDURE DAD_VALIDATION_I_SP
 /******************************************************************
 DAD_VALIDATION_I_SP
 This procedure is used to TRUNCATE and LOAD the DAD_VALIDATION table 
 from the temp table TEMP_DAD_VALIDATION when ever comparison file is 
 placed on the ccn db server by the mainframe
 created : 05/15/2015 AXK326 CCN Project....
 changed :
 ******************************************************************/
 ;
 
 PROCEDURE DAD_COMPARISON_FILE_SP
 /******************************************************************
 DAD_COMPARISON_FILE_SP
 This procedure is used to Create the final file from DAD_VALIDATION table
 created : 06/02/2015 AXK326 CCN Project....
 changed :
 ******************************************************************/
 ;
 
END DAD_FILE_COMPARISON;