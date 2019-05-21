create or replace PACKAGE          "COMMON_TOOLS" AS 
/*********************************************************** 
This package SPEC is intended to hold reuseable objects that are 
available to be used by the entire schema

-	DATE_BLANK(in_date)
		blank Date function to fill in default date to an oracle NULL for insert into tables
		this is created since oracle cannot handle blank strings being converted to 
		date fields
created : 08/24/2010 kdp Payroll reporting project.....
        : 09/13/2018 kxm302 CCN Project Team...
		: Removed GET_CC_MANAGER_NAME function ASP-1128
************************************************************/

PROCEDURE ALTER_ALL_TRIGGERS   
/*******************************************************************************
	ALTER_ALL_TRIGGERS   --    Alter all table(s) triggers

	This procedure will enable and/or disable all table(s) triggers based on an
  input "status" parameter.  

created : 11/14/2012 MDH CCN Project....
*******************************************************************************/
 ( IN_STATUS  IN VARCHAR2 );

FUNCTION CODE_DETAIL_VALID
/**********************************************************
	CODE_DETAIL_VALID(in_field_name, in_value_code)
		code_detail_valid function will be used to verify if a value is valid for a field.
    The field name and the field value must be passed.  
    This function will return a TRUE or FALSE condition. 

created : 08/15/2012 tal Cost Center Nucleus project.....
**********************************************************/
    ( in_field_name  IN  varchar2
    , in_value_code  IN  varchar2 ) 
    RETURN BOOLEAN;

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


PROCEDURE COUNTY_NAMES_S_SP (
/*******************************************************************************
	COUNTY_NAMES_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the COUNTY_NAME table. For a State_code entered a Ref_Cursor will be 
  returned pointing to a table of all the County_Names for that State_Code

created : 06/07/2013 tal CCN Project....
changed : 
*******************************************************************************/
     in_STATE_CODE  IN  COUNTY_NAMES.STATE_CODE%TYPE
		,out_REF_CUR    OUT sys_refcursor   );

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

PROCEDURE EMPLOYEE_DATA_S_SP   
/*******************************************************************************
	EMPLOYEE_DATA_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the EMP_DATA table.  Specifically, this procedure is intended to 
  return the Social Security Number (national Identifier), given the 
  GEMS Employee ID necessary for the Feed-Back Process into the IDMS
  System.

created : 10/22/2012 MDH CCN Project....
changed : 
*******************************************************************************/
 ( IN_GEMS_EMPLOYEE_ID   IN  EMP_DATA.EMPLOYEE_NUMBER%TYPE
                          , OUT_EMP_DATA_ROWTYPE OUT EMP_DATA%ROWTYPE);

PROCEDURE EXPIRE_DATA_SP (
/******************************************************************************
	EXPIRE_DATA_SP   --    Expire selected Table Rows Procedure

	This procedure is intended to expire specific row row(s) of data based on 
       table_name, Cost_Center, and Effective_Date. 

  This procedure is intended to be used for the follownig tables: 

            ADDRESS_CAN, ADDRESS_USA, ADDRESS_MEX, ADDRESS_OTHER
          , BANK_CARD
          , MARKETING
          , STATUS
          , TYPE

created : 12/04/2012 MDH CCN Project....
revised : 05/30/2013 MDH add ADDRESS_TYPE to procedure
*******************************************************************************/
--
  in_ROW_TABLE            IN  varchar2
, in_COST_CENTER          IN  COST_CENTER.COST_CENTER_CODE%TYPE
, in_EFFECTIVE_DATE       IN  date
, in_ADDRESS_TYPE         IN  ADDRESS_USA.ADDRESS_TYPE%TYPE DEFAULT NULL ); 

FUNCTION cost_center_look_up_fnc( 
/**********************************************************
This function will return 6 digit COST_CENTER_CODE
when the 4-digit code is passed

parameters: in

created : 04/19/2013 SH CCN Project
**********************************************************/
in_COST_CENTER IN COST_CENTER.COST_CENTER_CODE%TYPE 
)
RETURN VARCHAR2;   

FUNCTION country_look_up_fnc( 
/**********************************************************
This function will return COUNTRY_CODE


parameters: in

created : 05/17/2013 kdp CCN Project
**********************************************************/
in_COST_CENTER IN COST_CENTER.COST_CENTER_CODE%TYPE 
)
RETURN varchar2;

FUNCTION ADDRESS_LOOK_UP_FNC( 
/**********************************************************
This function will return ADDRESS TABLE NAME WHERE THE COST CENTER RESIDES

created : 08/18/2015 nxk927 CCN Project...
modified: 
**********************************************************/
IN_COST_CENTER IN VARCHAR2
)
RETURN VARCHAR2;

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
OUT OUT_REF_CURSOR

created : 09/04/2013 CCN Project
modified: 08/27/2014 jxc517 CCN Project
**********************************************************/
IN_USER_ID      IN     VARCHAR2,
OUT_REF_CURSOR     OUT CCN_COMMON_TOOLS.REF_CURSOR) RETURN VARCHAR2;

PROCEDURE CHECK_DUP_COST_CENTER(
/**********************************************************
	CHECK_DUP_COST_CENTER

	This procedure logs error if a cost center has a dup based on the last four digits

in_COST_CENTER_CODE - Input Cost Center to validate for duplication
in_CATEGORY_CODE    - Input category code

created : 09/11/2013 kdp CCN Project....
**********************************************************/
   in_COST_CENTER_CODE    IN VARCHAR2,
   in_CATEGORY_CODE       IN VARCHAR2);

PROCEDURE COPY_COST_CENTER(
/**********************************************************
	COPY_COST_CENTER

	This procedure will copy the OLD cost center into NEW cost center

IN_OLD_CC - Input Cost Center to be removed
IN_NEW_CC - Input Cost Center to be created

created : 09/11/2013 kdp CCN Project....
**********************************************************/
          IN_OLD_CC IN VARCHAR2,
          IN_NEW_CC IN VARCHAR2);

PROCEDURE BULK_COPY_COST_CENTER
/**********************************************************
	BULK_COPY_COST_CENTER

	This procedure will copy the OLD cost center into NEW cost center in batch as bulk

created : 02/21/2014 jxc517 CCN Project....
**********************************************************/
;

PROCEDURE BULK_COPY_COST_CENTER_PROCESS(
/******************************************************************************
BULK_COPY_COST_CENTER_PROCESS

This procedure is the core process for the cost center copying/correcting through UI
that invokes bulk load for copying cost centers from one another

IN_BLOB          - blob value delimited by , and termianted by new line character

Created by jxc517 02/24/2014
******************************************************************************/
IN_BLOB            IN       BLOB
);

PROCEDURE DELETE_COST_CENTER(
/**********************************************************
	DELETE_COST_CENTER

	This procedure will delete the passed cost center

IN_COST_CENTER - Input Cost Center to be removed

created : 01/29/2013 jxc517 CCN Project....
        : 04/28/2016 nxk927 CCN Project Team...
		      adding back delete procedure for cost center prefix fix
**********************************************************/
          IN_COST_CENTER IN VARCHAR2);

 FUNCTION BUILD_TAG(
/******************************************************************************
BUILD_TAG

This function will build the tag based on passed input parameters

******************************************************************************/
                      IN_VALUE     IN VARCHAR2,
                      IN_TAG_NAME  IN VARCHAR2,
                      IN_DATE_FLAG IN VARCHAR2 DEFAULT 'N')
   RETURN VARCHAR2;

PROCEDURE LOG_ERROR(
/******************************************************************************
LOG_ERROR

This procedure is an autonomous transaction that logs the errors and proceeds 
with the execution of rest of the cost centers

******************************************************************************/
                    IN_CC      IN VARCHAR2,
                    IN_MODULE  IN VARCHAR2,
                    IN_SQLERRM IN VARCHAR2,
                    IN_SQLCODE IN NUMBER);

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
IN_UNIX_COMMAND VARCHAR2) RETURN BOOLEAN;

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


FUNCTION GET_PHONE_NUMBER(
/***********************************************
Fucntion to get Pri, Scd, Fax phone_number using 
COST_CENTER_CODE and PHONE_NUMBER as Parameters

created : 04/10/2014  CCN Project
***********************************************/
IN_COST_CNTR_CD IN COST_CENTER.COST_CENTER_CODE%TYPE,
IN_PHONE_NO_TYP IN PHONE.PHONE_NUMBER_TYPE%TYPE)
RETURN VARCHAR2;

FUNCTION GET_CURR_LEV_VAL(
/***********************************************************
      GET_CURR_VAL 
      This Function will extract the value for
      current level from the passed HRCHY_HDR_NAME, 
      Level Name and the Cost Center Code/ HRCHY_DTL_CURR_ROW_VAL

Created : 02/04/2015 NXK927 CCN Project
************************************************************/
    IN_HRCHY_HDR_NAME             IN     VARCHAR2,
    IN_LEVEL_NAME                 IN     VARCHAR2,
    IN_HRCHY_DTL_CURR_ROW_VAL     IN     VARCHAR2)
RETURN VARCHAR2;

PROCEDURE BULK_TERR_TYP_BUSN_CD_UPD_PRCS(
/******************************************************************************
This procedure is the core process for updating the TERRITORY_TYPE_BUSN_CODE
column of TERRITORY table

IN_BLOB          - blob value delimited by , and termianted by new line character

Created by jxc517 02/19/2015
******************************************************************************/
IN_BLOB            IN       BLOB);

FUNCTION GET_UPPER_LVL_VER_VALUE
(
/*******************************************************************************
    This function will return Attributes for given Hierarchy Information

Created : 11/12/2015 SXT410 CCN Project...
Modified:
*******************************************************************************/
IN_HRCHY_HDR_NAME HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE,
IN_CURR_LVL_VAL   HIERARCHY_DETAIL.HRCHY_DTL_CURR_LVL_VAL%TYPE,
IN_NEXT_LVL_VAL   HIERARCHY_DETAIL.HRCHY_DTL_NEXT_LVL_VAL%TYPE,
IN_PREV_LVL_VAL   HIERARCHY_DETAIL.HRCHY_DTL_PREV_LVL_VAL%TYPE
)
RETURN XMLTYPE;

FUNCTION GET_FIPS_CODE(
/*******************************************************************************
    This function will get the FIPS code based on state 

Created : 09/07/2016 jxc517 CCN Project Team....
Modified:
*******************************************************************************/
    IN_STATE_CODE      IN    VARCHAR2,
    IN_COUNTY          IN    VARCHAR2,
    IN_CITY            IN    VARCHAR2,
    IN_ZIP_CODE        IN    VARCHAR2)
RETURN VARCHAR2;

FUNCTION GET_FORMATTED_PHONE_NUMBER(
/***********************************************
Fucntion to get formatted (###)###-#### Pri, Scd, Fax phone_number using 
COST_CENTER_CODE and PHONE_NUMBER as Parameters

created : 05/31/2017  rxa457 CCN Project..
***********************************************/
IN_COST_CNTR_CD IN COST_CENTER.COST_CENTER_CODE%TYPE,
IN_PHONE_NO_TYP IN PHONE.PHONE_NUMBER_TYPE%TYPE)
RETURN VARCHAR2;

FUNCTION GET_HOMESTORE(
/***********************************************
Function to get Homestore Information for the cost center 
based on the cost center's Category

created : 08/30/2017  rxa457 CCN Project..
***********************************************/
IN_COST_CNTR_CD   IN COST_CENTER.COST_CENTER_CODE%TYPE,
IN_COST_CNTR_CATG IN COST_CENTER.CATEGORY%TYPE)
RETURN VARCHAR2;

FUNCTION GET_TIMEZONE(
/***********************************************
Function to get Timezone Information for the cost center 

created : 08/28/2017  rxa457 CCN Project..
***********************************************/
IN_COST_CNTR_CD   IN COST_CENTER.COST_CENTER_CODE%TYPE,
IN_COST_CNTR_CATG IN COST_CENTER.CATEGORY%TYPE)
RETURN VARCHAR2;

FUNCTION GET_ACTIVE_STATUS(
/***********************************************
Function to get Active status record for a cost center

created : 09/25/2017  axt754 CCN Project..
***********************************************/
IN_COST_CENTER   IN COST_CENTER.COST_CENTER_CODE%TYPE)
RETURN STATUS%ROWTYPE;

FUNCTION IS_CC_HAVING_CSTMR_ACCNTS_FNC(
/**********************************************************
This function will check the cost center present in CUSTOMER_TAXID_VW_COSTCNTR Table
If the cost center is having active customer accoutns in CPR this function should
return "Y" else "N"

created : 11/17/2017 bxa919 CCN Project Team...
**********************************************************/
IN_COST_CENTER_CODE  IN  COST_CENTER.COST_CENTER_CODE%TYPE)
RETURN VARCHAR2; 

FUNCTION GET_COST_CENTER_GEO_LATD_LNGTD(
/**********************************************************
This Function is intended to return Latitude,longitude from CCN_ADDRESS_GEO_DETAILS

Created : 03/14/2018 rxv940 CCN Project.... ASP-976
Modified:
**********************************************************/
    IN_COST_CENTER    IN     COST_CENTER_DSC_CODES.COST_CENTER_CODE%TYPE,
    IN_GEO_TYPE       IN     VARCHAR2
    ) RETURN VARCHAR2;

FUNCTION IS_COST_CENTER_ARCHIVED (
/***********************************************************
This function will return "Y" if the Cost Center provided is Archived
Created : 11/27/2018, mxs216, CCN Project ASP-1158
************************************************************/
    IN_COST_CENTER_CODE IN VARCHAR2
) RETURN VARCHAR2;

FUNCTION IS_ARCHIVE_CC_FNC(
/***********************************************************
This function will return "Y" if the Cost Center provided is Archived

Created : 10/31/2018 jxc517 CCN Project ASP-971
Changed :
************************************************************/
    IN_COST_CENTER_CODE     IN       VARCHAR2)
RETURN VARCHAR2;

PROCEDURE SYNC_ALLOCATION_TYPE(
/******************************************************************************
This procedure syncs column PCC_PCL_STORE to column COLOR_CONSULTANT_TYPE

Created : 03/25/2019 mxs216 ASP-1200 CCN Project Team....
Changed :
 ******************************************************************************/
    IN_COLOR_CONSULTANT_TYPE IN XMLTYPE,
    IN_PCC_PCL_STORE         IN XMLTYPE,
    OUT_PCC_PCL_STORE        OUT VARCHAR2);

END COMMON_TOOLS;