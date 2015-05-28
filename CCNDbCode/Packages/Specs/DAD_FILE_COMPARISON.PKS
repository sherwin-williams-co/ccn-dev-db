--------------------------------------------------------
--  File created - Wednesday-May-27-2015   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Package DAD_FILE_COMPARISON
--------------------------------------------------------

  CREATE OR REPLACE PACKAGE "COSTCNTR"."DAD_FILE_COMPARISON" 
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
 
END DAD_FILE_COMPARISON;

/
