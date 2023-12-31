create or replace PACKAGE             CCN_COMMON_TOOLS AS 
/*********************************************************** 
This package SPEC is intended to hold reuseable objects that are 
available to be used by the entire schema

-    DATE_BLANK(in_date)
        blank Date function to fill in default date to an oracle NULL for insert into tables
        this is created since oracle cannot handle blank strings being converted to 
        date fields
created : 08/24/2010 kdp Payroll reporting project.....
modified: 08/16/2019 axm868 CCN Project CCNCC-9
          removed EXECUTE_UNIX_COMMAND Function as part of cleanup
************************************************************/

         TYPE REF_CURSOR IS REF CURSOR;

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

FUNCTION IS_AUTHORIZED_USER(
/**********************************************************
This function will authorize the user based on SECURITY_MATRIX table


parameters:

IN  IN_USER_ID
IN  IN_APP_CODE
OUT  OUT_REF_CURSOR

created : 09/04/2013 CCN Project
modified: 08/27/2014 jxc517 CCN Project
**********************************************************/
IN_USER_ID      IN     VARCHAR2,
IN_APP_CODE     IN     VARCHAR2,
OUT_REF_CURSOR     OUT REF_CURSOR) RETURN BOOLEAN;

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

pVal  IN - value that needs to be decrypted

created : 07/30/2014 CCN Project
**********************************************************/
pVal         IN varchar2) RETURN VARCHAR2;

FUNCTION VALIDATE_DATA_BEFORE_LOAD(
/*****************************************************************************
    VALIDATE_DATA_BEFORE_LOAD

    This function will validate if the value is some default value in idms
  which should go as NULL in database.  

created : 04/29/2013 jxc517 CCN Project....
changed :
*****************************************************************************/
    IN_VALUE     IN    VARCHAR2) RETURN VARCHAR2;

FUNCTION RETURN_NUMBER(
/*****************************************************************************
    RETURN_NUMBER

    This function will return the number based on precision and scale passed

created : 04/29/2013 jxc517 CCN Project....
changed :
*****************************************************************************/
    IN_VALUE     IN    VARCHAR2,
    IN_PRECISION IN    NUMBER,
    IN_SCALE     IN    NUMBER) RETURN NUMBER;

FUNCTION GET_DATE_VALUE(
/*****************************************************************************
    VALIDATE_DATA_BEFORE_LOAD

    This function will get the date value for the input passed.  

created : 06/11/2014 jxc517 CCN Project....
changed :
*****************************************************************************/
    IN_VALUE     IN    VARCHAR2,
    IN_FORMAT    IN    VARCHAR2) RETURN DATE;

FUNCTION MODULUS_10 (inValidate_nbr IN varchar)
/******************************************************************************
    MODULUS_10

    This function will calculate the check digit for a number
    passed in.  DO NOT PASS THE CHECK DIGIT WITH THE NUMBER.

created : KDP 4/26/2012modulu
******************************************************************************/    
RETURN number;

FUNCTION VALIDATE_EMPLOYEE_FNC(
/*******************************************************************************
    VALIDATE_EMPLOYEE_FNC
    This function will validate the employee name from the employee table and return
    True if the employee exists or return False if the employee doesnt exists.
    manager_flag checks if a employee is manager and validate against the
    manager employee table.

Created On  : 09/18/2014  SXT410 CCN Project
Modified On :
*******************************************************************************/
    IN_EMP_NO   IN     MANAGER_EMPLOYEE.GEMS_ID_NUMBER%TYPE,
    IN_MGR_FLAG IN     VARCHAR2,
    OUT_VALID      OUT VARCHAR2) RETURN VARCHAR2;

FUNCTION GET_TRANSLATED_CODE_DETAIL_VAL(
/**********************************************************
This procedure will return all the translated code detail value
based on the input header name and detail value from
TRANSLATION_DETAIL table

Created : 12/03/2015 jxc517 CCN Project....
Modified: 
**********************************************************/
IN_CODE_HEADER_NAME      IN     VARCHAR2,
IN_CODE_DETAIL_VALUE     IN     VARCHAR2) RETURN VARCHAR2;

FUNCTION GET_DATAFILE_PATH_FNC(
/**************************************************************** 
  This Function is used to get the UTL_FILE Directory path for the 
  Given Schema User.

created : 05/02/2016 AXD783 
changed :
*****************************************************************/
in_SCHEMA     IN   VARCHAR2)
RETURN VARCHAR2;

PROCEDURE WRITE_CLOB_ON_SERVER(
/******************************************************************************
This procedure will create file on server and dump the passed BLOB data Into the file created
IN_FILEPATH  - Directory path
IN_FILENAME  - Name of the file
IN_CLOB      - File data
created : 12/21/2016 vxv336 CCN Project
Modified:
******************************************************************************/
IN_DIRECTORY    IN       VARCHAR2,
IN_FILENAME    IN       VARCHAR2,
IN_CLOB        IN       CLOB);

FUNCTION RETURN_HEADER_STRING(
/***********************************************************************
        This Function is used to return the file header for a passed table name.

created : 12/21/2016 MXK766/NXK927 POS XML Conversion
changed :
************************************************************************/
IN_TABLE_NAME IN VARCHAR2)
RETURN VARCHAR2;

FUNCTION RETURN_FIRST_WKDAY_OF_MNTH(
/******************************************************************
This procedure will return the first week day of the month for the date
passed

Created : 01/13/2017 nxk927 CCN Project....
Changed :
******************************************************************/
    IN_DATE      IN    DATE) RETURN DATE;

FUNCTION FORMAT_INPUT_FOR_FILE(
/*****************************************************************************
This function will return the formatted data as requested

Created : gxg192 CCN Project....
Changed :
*****************************************************************************/
IN_VALUE         IN VARCHAR2,
IN_PADDING_VALUE IN VARCHAR2,
IN_LENGTH        IN NUMBER,
IN_PRECISION     IN NUMBER DEFAULT 0
) RETURN VARCHAR2;

PROCEDURE GET_APPLICATION_CREDENTIALS(
/*****************************************************************************
	This function will return the formatted data as requested

Created : 11/02/2017 jxc517 CCN Project Team....
Modified: 
*****************************************************************************/
    IN_APPLICATION_NAME   IN      VARCHAR2,
    IN_APPLICATION_PRCS   IN      VARCHAR2,
    OUT_USER_NAME            OUT  VARCHAR2,
    OUT_PASSWORD             OUT  VARCHAR2);

FUNCTION GET_COST_CENTER_DSC_CODES(
/**********************************************************
This Function is intended to return PRIMARY_DSC, SECONDARY_DSC Codes from
from COST_CENTER_DSC_CODES 
Created : 02/22/2018 SXG151 CCN Project....
Modified:
**********************************************************/
    IN_COST_CENTER    IN     COST_CENTER_DSC_CODES.COST_CENTER_CODE%TYPE,
    IN_DSC_TYPE       IN     VARCHAR2
    ) RETURN NUMBER;

FUNCTION CHK_POS_NEW_STORES_BYPASS(
/**********************************************************
	This function is intended to check whether the cost center 
	that needs to be bypassed exists in the table POS_NEW_STORES_VALIDATION_BYPASS
    This function will return -
    TRUE if cost center was found in the POS_NEW_STORES_VALIDATION_BYPASS table
    FALSE if cost center was not found in the POS_NEW_STORES_VALIDATION_BYPASS table 

Created : 04/01/2019 dxp896 CCN Project....
Changed : 
**********************************************************/
    IN_COST_CENTER_CODE    IN  COST_CENTER.COST_CENTER_CODE%TYPE)
RETURN BOOLEAN;

FUNCTION GET_DESIGNATED_TERMINAL_NUMBER(
/******************************************************************************
This function will return the first assigned terminal number for a given store     

Created : 06/21/2019 axm868 --  CCN Project....
Changed :
******************************************************************************/
         IN_COST_CENTER_CODE    IN     COST_CENTER.COST_CENTER_CODE%TYPE)
RETURN STORE.DESIGNATED_TERMINAL_NUMBER%TYPE;

FUNCTION GET_NTH_WORKING_DAYS(
/******************************************************************************
This function will return the Nth working day from the date passed in
NOTE: N can be positive or negative

Created : 10/10/2019 jxc517 CCN Project Team.... CCNSD-25
Changed :
******************************************************************************/
    IN_WORKING_DAYS    IN     PLS_INTEGER,
    IN_START_DATE      IN     DATE         DEFAULT SYSDATE)
RETURN DATE;

END CCN_COMMON_TOOLS;