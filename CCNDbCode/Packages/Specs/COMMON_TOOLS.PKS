create or replace PACKAGE COMMON_TOOLS as 
/*********************************************************** 
This package SPEC is intended to hold reuseable objects that are 
available to be used by the entire schema

-	DATE_BLANK(in_date)
		blank Date function to fill in default date to an oracle NULL for insert into tables
		this is created since oracle cannot handle blank strings being converted to 
		date fields
created : 08/24/2010 kdp Payroll reporting project.....
************************************************************/
   
procedure ALTER_ALL_TRIGGERS   
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
    ( in_field_name  in  varchar2
    , in_value_code  in  varchar2 ) 
    return boolean;
    
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
  ( in_date  in  date 
   ) return date; 


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
    (in_date in varchar2)
    return varchar2;
    
procedure EMPLOYEE_DATA_S_SP   
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
                          , OUT_EMP_DATA_ROWTYPE OUT EMP_DATA%rowtype);
                                                    
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

function cost_center_look_up_fnc( 
/**********************************************************
This function will return 6 digit COST_CENTER_CODE
when the 4-digit code is passed

parameters: in

created : 04/19/2013 SH CCN Project
**********************************************************/
in_COST_CENTER IN COST_CENTER.COST_CENTER_CODE%TYPE 
)
RETURN VARCHAR2;   

function country_look_up_fnc( 
/**********************************************************
This function will return COUNTRY_CODE


parameters: in

created : 05/17/2013 kdp CCN Project
**********************************************************/
in_COST_CENTER IN COST_CENTER.COST_CENTER_CODE%TYPE 
)
return varchar2;

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

PROCEDURE DELETE_COST_CENTER(
/**********************************************************
	DELETE_COST_CENTER

	This procedure will delete the passed cost center

IN_COST_CENTER - Input Cost Center to be removed

created : 01/29/2013 jxc517 CCN Project....
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
                    IN_SQLERRM IN VARCHAR2,
                    IN_SQLCODE IN NUMBER);

PROCEDURE SEND_MAIL(
/**********************************************************
	SEND_MAIL

	This procedure will send emails based on the category of the mail
  Currently we have below categories:
                    INIT_LOAD_START
                    INIT_LOAD_END
                    HIER_LOAD_START
                    HIER_LOAD_END
                    STOP_JBOSS
                    START_JBOSS
                    INCOMPLETE_CC
                    
   For more details around the above category please look into MAILING table

IN_MAIL_CATEGORY - Input Category for which email needs to be sent

created : 09/11/2013 jxc517 CCN Project....
**********************************************************/
   IN_MAIL_CATEGORY VARCHAR2)
;


END COMMON_TOOLS;

