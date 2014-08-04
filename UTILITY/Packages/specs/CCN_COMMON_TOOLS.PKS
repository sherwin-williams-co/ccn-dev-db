create or replace PACKAGE CCN_COMMON_TOOLS AS 
/*********************************************************** 
This package SPEC is intended to hold reuseable objects that are 
available to be used by the entire schema

-	DATE_BLANK(in_date)
		blank Date function to fill in default date to an oracle NULL for insert into tables
		this is created since oracle cannot handle blank strings being converted to 
		date fields
created : 08/24/2010 kdp Payroll reporting project.....
************************************************************/
   
FUNCTION COMPUTE_EXPIRATION_DATE
/******************************************************************************
	COMPUTE_EXPIRATOIN_DATE (in_date)
  
		This function will be used to read in a date and subtract one day
    from that date (effective) and return a new date (expiration) which
    is one day prior.
    
    The an input date must be passed.  
    This function will return a new (expiration) date. 

created : 12/04/2012 mdh Cost Center Nucleus project.....
revised:
******************************************************************************/
  ( in_date  IN  date 
   ) RETURN date; 

FUNCTION DATE_BLANK
/**********************************************************
	DATE_BLANK(in_date)
		blank Date function to fill in default date to an oracle NULL for insert into tables
		this is created since oracle cannot handle blank strings being converted to 
		date fields

created : 08/24/2010 kdp Payroll reporting project.....
**********************************************************/
    (in_date IN varchar2)
    RETURN varchar2;
    
FUNCTION ELIMINATE_SPECIAL_CHRCTRS(
/**********************************************************
This function will replace special characters from input text


parameters:

IO_TEXT_STRING  IN OUT

created : 08/08/2013 CCN Project
**********************************************************/
IO_TEXT_STRING    IN    VARCHAR2) RETURN VARCHAR2;

FUNCTION IS_AUTHERIZED_USER(
/**********************************************************
This function will authorize the user based on SECURITY_MATRIX table


parameters:

IN  IN_USER_ID

created : 09/04/2013 CCN Project
**********************************************************/
IN_USER_ID    IN    VARCHAR2,
IN_ROLE_CODE  IN    VARCHAR2) RETURN BOOLEAN;

FUNCTION BUILD_TAG(
/******************************************************************************
BUILD_TAG

This function will build the tag based on passed input parameters

******************************************************************************/
                      IN_VALUE     IN VARCHAR2,
                      IN_TAG_NAME  IN VARCHAR2,
                      IN_DATE_FLAG IN VARCHAR2 DEFAULT 'N')
   RETURN VARCHAR2;

FUNCTION CONVERT_SPECIAL_CHRCTRS(
/**********************************************************
This function will build special characters from input text

parameters:

IO_TEXT_STRING  IN

created : 03/04/2014 CCN Project
**********************************************************/
IO_TEXT_STRING    IN    VARCHAR2) RETURN VARCHAR2;

FUNCTION EXECUTE_UNIX_COMMAND(
/**********************************************************
This function will build special characters from input text

parameters:

IN_UNIX_COMMAND  IN - Command to be executed

created : 03/13/2014 CCN Project
**********************************************************/
IN_UNIX_COMMAND VARCHAR2,
IN_DIRECTORY    VARCHAR2 DEFAULT 'CCN_DATAFILES') RETURN BOOLEAN;

FUNCTION convert_to_clob(
/**********************************************************
This function will convert blob to clob

parameters:

IN_BLOB  IN - BLOB that needs to be converted into CLOB

created : 03/28/2014 CCN Project
**********************************************************/
IN_BLOB IN BLOB) RETURN CLOB;

FUNCTION convert_to_blob(
/**********************************************************
This function will convert blob to clob

parameters:

IN_CLOB  IN - CLOB that needs to be converted into BLOB

created : 03/28/2014 CCN Project
**********************************************************/
IN_CLOB IN CLOB) RETURN BLOB;

FUNCTION DecryptSQL (
/**********************************************************
This function will decrypt the input value

parameters:

p_text  IN - RAW that needs to be decrypted

created : 07/30/2014 CCN Project
**********************************************************/
pVal         in varchar2,
in_key_value in varchar2) RETURN VARCHAR2;

END CCN_COMMON_TOOLS;

