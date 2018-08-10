create or replace PACKAGE          CCN_UI_INTERFACE_APP_PKG
    AS
-- PACKAGE SPEC
/****************************************************************************** 
This package is intended will return data for the cost_center table

created : 09/18/2012 TAL -- CCN coding project
changed : 09/21/2012 TAL -- Split into Table_UI and Interface_UI
        : 07/24/2018 kxm302 CCN Project Team...
		  Removed SELECT_AUDIT_LOG ,SELECT_HIERARCHY_AUDIT_LOG procedures as part of audit clean-up - ASP-1092
******************************************************************************/
	 	TYPE REF_CURSOR IS REF CURSOR;
--TESTING FOR JAVACODE WITH MULTIPLE CURSORS......REMOVE

PROCEDURE TEST_COST_CENTER_S_SP(
/******************************************************************************
	TEST_COST_CENTER_S_SP

	This procedure is intended to return a ref cursor with data from 
	from the cost center table.  

created : 
*******************************************************************************/
 in_COST_CENTER IN COST_CENTER.COST_CENTER_CODE%TYPE
, out_COST_CENTER_REF_CUR OUT REF_CURSOR
, out_STORE_REF_CUR OUT REF_CURSOR);
--TESTING DELETE LATER....


  PROCEDURE ADDRESS_UI_SP ( inCost_center IN COST_CENTER.cost_center_code%type
                           ,inCountry_code IN COST_CENTER.country_code%type
                           ,inAddressType	IN ADDRESS_USA.address_type%type DEFAULT NULL                                                 
                           ,out_ADDRESS_REF_CUR OUT sys_refcursor)
/*******************************************************************************
	ADDRESS_UI_SP

	This procedure is intended to return a ref cursor with data from 
	from the ADDRESS_USA,or ADDRESS_MEX or ADDRESS_CAN or ADDRESS_OTHER table.  

created :  09/05/2012 BLR CCN UI Project....
*******************************************************************************/
;


  PROCEDURE COST_CENTER_UI_SP ( IN_Cost_center IN COST_CENTER.cost_center_code%type
                 , OUT_COST_CENTER_REF_CUR  OUT sys_refcursor
                 , OUT_CC_CATEGORY_REF_CUR  OUT sys_refcursor
                 , OUT_STATUS_REF_CUR       OUT sys_refcursor
                 , OUT_TYPE_REF_CUR         OUT sys_refcursor
                 , OUT_MARKETING_REF_CUR    OUT sys_refcursor
                 , OUT_TAXWARE_REF_CUR      OUT sys_refcursor
                 , OUT_PHONE_REF_CUR        OUT sys_refcursor
                 , OUT_ADDRESS_REF_CUR      OUT sys_refcursor)
 /******************************************************************************
	COST_CENTER_UI_SP   --    Cost Center User Interface Procedure

	This procedure is intended to return a ref cursor with data from 
	from the COST_CENTER, ADMINISTRATION, STORE, OTHER, REAL_ESTATE, TERRITORY,
  STATUS, TYPE, MARKETING, PHONE, TAXWARE, and ADDRESS tables.  

created : 09/06/2012 MDH CCN Project....
*******************************************************************************/
;

PROCEDURE POLLING_UI_SP (
/*******************************************************************************
	POLLING_UI_SP   --    Polling User Interface Stored Procedure

	This procedure is intended to return a ref cursor with data from 
	from the POLLING, BANK_CARD, and TERMINAL tables.  

created : 09/05/2012 TAL CCN Project....
*******************************************************************************/
            in_cost_center            IN  polling.cost_center_code%type
 					, in_polling_status_code    IN  polling.polling_status_code%type
          , in_merchant_id_code       IN  bank_card.merchant_id%type
          , in_terminal_number        IN  terminal.terminal_number%type
					, out_polling_refcur        OUT sys_refcursor
 					, out_bank_card_refcur      OUT sys_refcursor
			    , OUT_TERMINAL_REFCUR       OUT SYS_REFCURSOR
          );   


PROCEDURE ADDRESS_UI_UPSERT_SP (
/*******************************************************************************
	ADDRESS_UI_UPSERT_SP   --    ADDRESS User Interface Update/Insert Procedure

	This procedure is intended to update the database for the following tables 
       used in the Address UI.

	Tables: 
            ADDRESS_CAN, 
            ADDRESS_USA, 
            ADDRESS_MEX, 
            ADDRESS_OTHER

created : 12/12/2012 TAL CCN Project....
revised :
*******************************************************************************/
 					in_row_data                IN  varchar2 
          );  


PROCEDURE POLLING_UI_UPSERT_SP (
/*******************************************************************************
	POLLING_UI_UPSERT_SP   --    POLLING User Interface Update/Insert Procedure

	This procedure is intended to update the database for the following tables 
       used in the Polling UI.

	Tables: 
            POLLING
          , BANK_CARD
          , TERMINAL

created : 11/09/2012 MDH CCN Project....
revised :
*******************************************************************************/
 					in_row_data                IN  varchar2 
          );  

PROCEDURE COST_CENTER_UI_UPSERT_SP ( 
 /******************************************************************************
	COST_CENTER_UI_UPSERT_SP   --    Cost Center User Interface Update delete
        Procedure

	This procedure is intended to update the database for the following tables used in
        Cost Center UI.
	Tables: 
              COST_CENTER
           ,  ADMINISTRATION, STORE, OTHER, REAL_ESTATE, TERRITORY,
            , STATUS
            , TYPE
            , MARKETING
            , PHONE
            , TAXWARE
            , ADDRESS tables.  

created : 10/26/2012 KDP CCN Project....
revised:   12/03/2012 BLR  CCN Project....
*******************************************************************************/

 in_row_data  IN varchar2);

 PROCEDURE VALIDATE_BUSINESS_RULES(
 /******************************************************************************
	VALIDATE_BUSINESS_RULES   --    User Interface Update delete business rules validator

	This procedure is intended to validate the business rules based on the flag sent using
  the input XML fragment.

created : 08/26/2013 CCN Project....
*******************************************************************************/
IN_FLAG      IN VARCHAR2,
IN_ROW_DATA  IN VARCHAR2);

FUNCTION TERMINAL_NUMBER_S
/*********************************************************************
TERMINAL_NUMBER_S
This function will return the next terminal number from the 
sequence terminal_number_seq
created : 08/04/2014 CCN Project
*************************************************************************/
RETURN NUMBER;

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

 PROCEDURE RELEASE_OBJECT(
 /******************************************************************************
 RELEASE_OBJECT

 This procedure will release the restriction on passed object based on passed 
 restriction ID

 IN_RESTRICTION_ID     - Restriction ID that needs to be released

 ******************************************************************************/
 IN_OBJECT_NAME     IN       CCN_RESTRICTION.OBJECT_NAME%TYPE);

PROCEDURE EMPLOYEE_DETAILS_S_SP (
/*******************************************************************************
	EMPLOYEE_DETAILS_S_SP

	This procedure is intended to select records from EMPLOYEE_DETAILS table

<?xml version="1.0" encoding="UTF-8" ?>
<EMPLOYEE_DETAILS_UI xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
<EMPLOYEE_DETAILS>
<EMPLOYEE_NUMBER>XXXXXXX</EMPLOYEE_NUMBER>
<COST_CENTER_CODE>XXXXXX</COST_CENTER_CODE>
<EMPLOYEE_NAME>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</EMPLOYEE_NAME>
<LAST_NAME>XXXXXXXXXXXXXXXXXXXX</LAST_NAME>
<FIRST_NAME>XXXXXXXXXXXXXXXXXXXX</FIRST_NAME>
<MIDDLE_INITIAL>XX</MIDDLE_INITIAL>
<HOME_ADDRESS_LINE1>XXXXXXXXXXXXXXXXXXXX</HOME_ADDRESS_LINE1>
<HOME_ADDRESS_LINE2>XXXXXXXXXXXXXXXXXXXX</HOME_ADDRESS_LINE2>
<HOME_CITY_STATE>XXXXXXXXXXXXXXXXXXXX</HOME_CITY_STATE>
<HOME_CITY>XXXXXXXXXXXXXXXXXXXX</HOME_CITY>
<HOME_STATE>XX</HOME_STATE>
<HOME_POSTAL_CODE>XXXXXXXXX</HOME_POSTAL_CODE>
<HOME_PHONE>XXXXXXXXXX</HOME_PHONE>
<COMPANY_CODE>XXX</COMPANY_CODE>
<SEX>X</SEX>
<EMP_PAYROLL_STATUS>X</EMP_PAYROLL_STATUS>
<EMP_ASSIGNMENT_STATUS>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</EMP_ASSIGNMENT_STATUS>
<EMP_DIVISION>XXXX</EMP_DIVISION>
<HIRE_DATE>MM-DD-RRRR</HIRE_DATE>
<TERM_DATE>MM-DD-RRRR</TERM_DATE>
<ADJUSTED_SERVICE_DATE>MM-DD-RRRR</ADJUSTED_SERVICE_DATE>
<JOB_CODE>XXXXX</JOB_CODE>
<JOB_DIVISION>XXXX</JOB_DIVISION>
<JOB_FAMILY>XXXXXXXXXX</JOB_FAMILY>
<JOB_TITLE>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</JOB_TITLE>
<JOB_TYPE>XXXXXXXXXXXXXXX</JOB_TYPE>
<JOB_LEVEL>XXXXXXXXXX</JOB_LEVEL>
<JOB_FUNCTION>XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX</JOB_FUNCTION>
<DAD_CODE>XXXXXXXX</DAD_CODE>
</EMPLOYEE_DETAILS>
</EMPLOYEE_DETAILS_UI>

Created : 06/16/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE EMPLOYEE_ADMIN_DETAILS_S_SP (
/*******************************************************************************
	EMPLOYEE_ADMIN_DETAILS_S_SP

	This procedure is intended to select records from EMPLOYEE_ADMIN_DETAILS table

<?xml version="1.0" encoding="UTF-8" ?>
<EMPLOYEE_ADMIN_DETAILS_UI xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
<EMPLOYEE_ADMIN_DETAILS>
<EMPLOYEE_NUMBER>XXXXXXX</EMPLOYEE_NUMBER>
<ADMIN_COST_CENTER_CODE>XXXXXX</ADMIN_COST_CENTER_CODE>
<EFFECTIVE_DATE>MM-DD-RRRR</EFFECTIVE_DATE>
<EXPIRATION_DATE>MM-DD-RRRR</EXPIRATION_DATE>
</EMPLOYEE_ADMIN_DETAILS>
</EMPLOYEE_ADMIN_DETAILS_UI>

Created : 06/23/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB
,OUT_REF_CUR     OUT REF_CURSOR);

PROCEDURE EMPLOYEE_ADMIN_DETAILS_UPSERT (
/*******************************************************************************
	EMPLOYEE_ADMIN_DETAILS_UPSERT

	This procedure is intended to insert/update records into EMPLOYEE_ADMIN_DETAILS table

<?xml version="1.0" encoding="UTF-8" ?>
<EMPLOYEE_ADMIN_DETAILS_UI xmlns:xsi="http://www.w3.org/2001/XMLSchema" xsi:nonamespaceSchemaLocation="http://www.oracle.com/Employee.xsd">
<EMPLOYEE_ADMIN_DETAILS>
<EMPLOYEE_NUMBER>XXXXXXXXX</EMPLOYEE_NUMBER>
<ADMIN_COST_CENTER_CODE>XXXXXX</ADMIN_COST_CENTER_CODE>
<EFFECTIVE_DATE>MM-DD-RRRR</EFFECTIVE_DATE>
<EXPIRATION_DATE>MM-DD-RRRR</EXPIRATION_DATE>
<ADMIN_JOB_CODE>XXXXX</ADMIN_JOB_CODE>
<EMPLOYEE_FIRST_NAME>XXXXXXXXXXXXXXXXXXXX</EMPLOYEE_FIRST_NAME>
<EMPLOYEE_LAST_NAME>XXXXXXXXXXXXXXXXXXXX</EMPLOYEE_LAST_NAME>
<EMPLOYEE_MIDDLE_NAME>XX</EMPLOYEE_MIDDLE_NAME>
</EMPLOYEE_ADMIN_DETAILS>
</EMPLOYEE_ADMIN_DETAILS_UI>

Created : 07/24/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME IN     VARCHAR2
,IN_ROW_DATA  IN     CLOB);

PROCEDURE BULK_TERR_TYP_BUSN_CD_UPD_PRCS(
/******************************************************************************
This procedure is the core process for updating the TERRITORY_TYPE_BUSN_CODE
column of TERRITORY table

IN_BLOB          - blob value delimited by , and termianted by new line character

Created by jxc517 02/19/2015
******************************************************************************/
IN_BLOB            IN       BLOB);

PROCEDURE PROCESSOR_UI_SP (
/******************************************************************************
This procedure is intended to return a ref cursor with data from 
from the PROCESSORS and PROCESSOR_STATES tables.  

Created : 04/08/2016 jxc517 CCN Project....
Changed : 10/18/2016 jxc517 CCN Project....
          Added/Modified the parameters as per new model
********************************************************************************/
    O_PROCESSORS                  OUT      SYS_REFCURSOR,
    O_PROCESSOR_GROUPS            OUT      SYS_REFCURSOR,
    O_PRCSR_STR_GRP_DTLS          OUT      SYS_REFCURSOR,
    O_PRCSR_STR_ADMN_GRP_DTLS     OUT      SYS_REFCURSOR,
    O_PRCSR_CANADA_GRP_DTLS       OUT      SYS_REFCURSOR,
    O_PRCSR_HEADQRTS_GRP_DTLS     OUT      SYS_REFCURSOR,
    O_PRCSR_RETIREES_GRP_DTLS     OUT      SYS_REFCURSOR,
    O_PRCSR_AUTO_GRP_DTLS         OUT      SYS_REFCURSOR,
    O_PRCSR_INTRNTL_GRP_DTLS      OUT      SYS_REFCURSOR);

PROCEDURE PROCESSORS_UI_UPSERT_SP (
/******************************************************************************
This procedure is intended to insert/update/delete data from 
from the PROCESSORS tables

<PROCESSORS_UI_UPSERT>
    <PROCESSORS>
            <PROCESSOR_ID>1</PROCESSOR_ID>
            <PROCESSOR_NAME>Camia Brown</PROCESSOR_NAME>
            <PHONE_NUMBER>2165661751</PHONE_NUMBER>
            <EFFECTIVE_DATE>10-18-2016</EFFECTIVE_DATE>
            <CREATED_BY>jxc517</CREATED_BY>
    </PROCESSORS>
    <PROCESSORS>
            <PROCESSOR_ID>2</PROCESSOR_ID>
            <PROCESSOR_NAME>DaNita Van-Leer Nicholson</PROCESSOR_NAME>
            <PHONE_NUMBER>2165662217</PHONE_NUMBER>
            <EFFECTIVE_DATE>10-18-2016</EFFECTIVE_DATE>
            <CREATED_BY>jxc517</CREATED_BY>
            <DELETE_FLAG>Y</DELETE_FLAG>
    </PROCESSORS>
</PROCESSORS_UI_UPSERT>

Created : 10/18/2016 jxc517 CCN Project....
Changed : 
********************************************************************************/
    IN_XML         IN            CLOB);

PROCEDURE PRCSR_GRP_DTLS_UI_UPSERT_SP (
/******************************************************************************
This procedure is intended to insert/update/delete data from 
from the below group detail tables.

PRCSR_STR_ADMN_GRP_DTLS
PRCSR_CANADA_GRP_DTLS
PRCSR_HEADQRTS_GRP_DTLS
PRCSR_RETIREES_GRP_DTLS
PRCSR_AUTO_GRP_DTLS
PRCSR_INTRNTL_GRP_DTLS

<PROCESSORS_UI_UPSERT>
    <PRCSR_STR_GRP_DTLS_TBL>
        <PRCSR_STR_GRP_DTLS>
            <GROUP_ID>1</GROUP_ID>
            <PROCESSOR_ID>1</PROCESSOR_ID>
            <EFFECTIVE_DATE>10-18-2016</EFFECTIVE_DATE>
            <CREATED_BY>jxc517</CREATED_BY>
            <STATE_CODE>NC</STATE_CODE>
        </PRCSR_STR_GRP_DTLS>
    </PRCSR_STR_GRP_DTLS_TBL>
    <PRCSR_STR_ADMN_GRP_DTLS_TBL>
        <PRCSR_STR_ADMN_GRP_DTLS>
            <GROUP_ID>2</GROUP_ID>
            <PROCESSOR_ID>1</PROCESSOR_ID>
            <EFFECTIVE_DATE>10-18-2016</EFFECTIVE_DATE>
            <CREATED_BY>jxc517</CREATED_BY>
        </PRCSR_STR_ADMN_GRP_DTLS>
    </PRCSR_STR_ADMN_GRP_DTLS_TBL>
    <PRCSR_CANADA_GRP_DTLS_TBL>
        <PRCSR_CANADA_GRP_DTLS>
            <GROUP_ID>3</GROUP_ID>
            <PROCESSOR_ID>1</PROCESSOR_ID>
            <EFFECTIVE_DATE>10-18-2016</EFFECTIVE_DATE>
            <CREATED_BY>jxc517</CREATED_BY>
        </PRCSR_CANADA_GRP_DTLS>
    </PRCSR_CANADA_GRP_DTLS_TBL>
    <PRCSR_HEADQRTS_GRP_DTLS_TBL>
        <PRCSR_HEADQRTS_GRP_DTLS>
            <GROUP_ID>4</GROUP_ID>
            <PROCESSOR_ID>1</PROCESSOR_ID>
            <EFFECTIVE_DATE>10-18-2016</EFFECTIVE_DATE>
            <CREATED_BY>jxc517</CREATED_BY>
        </PRCSR_HEADQRTS_GRP_DTLS>
    </PRCSR_HEADQRTS_GRP_DTLS_TBL>
    <PRCSR_RETIREES_GRP_DTLS_TBL>
        <PRCSR_RETIREES_GRP_DTLS>
            <GROUP_ID>5</GROUP_ID>
            <PROCESSOR_ID>1</PROCESSOR_ID>
            <EFFECTIVE_DATE>10-18-2016</EFFECTIVE_DATE>
            <CREATED_BY>jxc517</CREATED_BY>
        </PRCSR_RETIREES_GRP_DTLS>
    </PRCSR_RETIREES_GRP_DTLS_TBL>
    <PRCSR_AUTO_GRP_DTLS_TBL>
        <PRCSR_AUTO_GRP_DTLS>
            <GROUP_ID>6</GROUP_ID>
            <PROCESSOR_ID>1</PROCESSOR_ID>
            <EFFECTIVE_DATE>10-18-2016</EFFECTIVE_DATE>
            <CREATED_BY>jxc517</CREATED_BY>
        </PRCSR_AUTO_GRP_DTLS>
    </PRCSR_AUTO_GRP_DTLS_TBL>
    <PRCSR_INTRNTL_GRP_DTLS_TBL>
        <PRCSR_INTRNTL_GRP_DTLS>
            <GROUP_ID>7</GROUP_ID>
            <PROCESSOR_ID>1</PROCESSOR_ID>
            <EFFECTIVE_DATE>10-18-2016</EFFECTIVE_DATE>
            <CREATED_BY>jxc517</CREATED_BY>
        </PRCSR_INTRNTL_GRP_DTLS>
    </PRCSR_INTRNTL_GRP_DTLS_TBL>
</PROCESSORS_UI_UPSERT>

Created : 10/18/2016 jxc517 CCN Project....
Changed : 
********************************************************************************/
    IN_XML         IN            CLOB);

PROCEDURE GL_ACCOUNTS_PROG_UI_UPSERT_SP(
/******************************************************************************
This procedure takes XML which has GL_ACCOUNT_NUMBER and Inserts/Updates
the given PROGRAMS in the XML to the the GL_ACCOUNT_NUMBER Or Updates given GL
ACCOUNT information

<?xml version="1.0" encoding="UTF-8"?>
<ACCOUNTS_UI>
   <USER_ID>axt754</USER_ID>
   <GENERAL_LEDGER_ACCOUNTS_TBL>
      <GENERAL_LEDGER_ACCOUNTS>
            <GL_ACCOUNT_NUMBER>33388809</GL_ACCOUNT_NUMBER>
            </DESCRIPTION>
            <PROFIT_OR_LOSS>65</PROFIT_OR_LOSS>
            <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
            <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </GENERAL_LEDGER_ACCOUNTS>
    </GENERAL_LEDGER_ACCOUNTS_TBL>
    <PRGM_GL_ACCNT_RLTN_DTLS_TBL>
      <PRGM_GL_ACCNT_RLTN_DTLS>
           <PROGRAM_NAME>Test Example10</PROGRAM_NAME>
           <SORTED_SEQUENCE/>
           <SHARED>TRUE</SHARED>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PRGM_GL_ACCNT_RLTN_DTLS>
      <PRGM_GL_ACCNT_RLTN_DTLS>
           <PROGRAM_NAME>Test Example11</PROGRAM_NAME>
           <SORTED_SEQUENCE/>
           <SHARED>TRUE</SHARED>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PRGM_GL_ACCNT_RLTN_DTLS>
    </PRGM_GL_ACCNT_RLTN_DTLS_TBL>
</ACCOUNTS_UI>

Created : 03/15/2017 axt754 -- CCN Project Team
Modified: 08/17/2017 axt754 -- Separate UPSERT for ACCOUNTS, PROGRAMS and RELATION
        : 08/25/2017 axt754 -- No Insert of New Accounts
******************************************************************************/
    in_xml          IN          CLOB);

PROCEDURE GL_ACCOUNTS_PROG_UI_DELETE_SP(
/******************************************************************************
This procedure takes XML which has GL ACCOUNT NUMBER and DELETES
Programs information given in the XML, that were attached to GL ACCOUNT NUMBER

<?xml version="1.0" encoding="UTF-8"?>
<ACCOUNTS_UI>
    <GENERAL_LEDGER_ACCOUNTS_TBL>
      <GENERAL_LEDGER_ACCOUNTS>
            <GL_ACCOUNT_NUMBER>33388809</GL_ACCOUNT_NUMBER>
            </DESCRIPTION>
            <PROFIT_OR_LOSS>65</PROFIT_OR_LOSS>
            <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
            <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </GENERAL_LEDGER_ACCOUNTS>
    </GENERAL_LEDGER_ACCOUNTS_TBL>
    <PRGM_GL_ACCNT_RLTN_DTLS_TBL>
      <PRGM_GL_ACCNT_RLTN_DTLS>
           <PROGRAM_NAME>Test Example10</PROGRAM_NAME>
           <SORTED_SEQUENCE/>
           <SHARED>TRUE</SHARED>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PRGM_GL_ACCNT_RLTN_DTLS>
      <PRGM_GL_ACCNT_RLTN_DTLS>
           <PROGRAM_NAME>Test Example10</PROGRAM_NAME>
           <SORTED_SEQUENCE/>
           <SHARED>TRUE</SHARED>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PRGM_GL_ACCNT_RLTN_DTLS>
    </PRGM_GL_ACCNT_RLTN_DTLS_TBL>
</ACCOUNTS_UI>

Created : 03/15/2017 axt754 -- CCN Project Team
Modified: 08/17/2017 axt754 -- Separate DELETE for ACCOUNTS, PROGRAMS and RELATION
        : 08/25/2017 axt754 -- No Delete of Existing Accounts
******************************************************************************/
    in_xml          IN          CLOB);

PROCEDURE PROG_GL_ACCOUNTS_UI_UPSERT_SP(
/******************************************************************************
This procedure takes XML which has PROGRAM_NAME and Inserts/Updates
the given ACCOUNT_NUMBERS in the XML to the the PROGRAM Or Inserts/Updates
given PROGRAM related information

<?xml version="1.0" encoding="UTF-8"?>
<ACCOUNTS_UI>
   <USER_ID>axt754</USER_ID>
   <PROGRAMS_TBL>
      <PROGRAMS>
           <PROGRAM_NAME>Test Example10</PROGRAM_NAME>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PROGRAMS>
    </PROGRAMS_TBL>
    <PRGM_GL_ACCNT_RLTN_DTLS_TBL>
      <PRGM_GL_ACCNT_RLTN_DTLS>
           <GL_PS_ACCOUNT_NUMBER>33388809</GL_PS_ACCOUNT_NUMBER>
           <SORTED_SEQUENCE/>
           <SHARED>TRUE</SHARED>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PRGM_GL_ACCNT_RLTN_DTLS>
      <PRGM_GL_ACCNT_RLTN_DTLS>
           <GL_PS_ACCOUNT_NUMBER>33388810</GL_PS_ACCOUNT_NUMBER>
           <SORTED_SEQUENCE/>
           <SHARED>TRUE</SHARED>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PRGM_GL_ACCNT_RLTN_DTLS>
    </PRGM_GL_ACCNT_RLTN_DTLS_TBL>
</ACCOUNTS_UI>

Created : 03/15/2017 axt754 -- CCN Project Team
Modified: 08/17/2017 axt754 -- Separate UPSERT for ACCOUNTS, PROGRAMS and RELATION
******************************************************************************/
    in_xml          IN          CLOB) ;

PROCEDURE PROG_GL_ACCOUNTS_UI_DELETE_SP(
/******************************************************************************
This procedure takes XML as input Which has PROGRAM information
and Deletes the account information given in XML, attached to program

<?xml version="1.0" encoding="UTF-8"?>
<ACCOUNTS_UI>
   <PROGRAMS_TBL>
      <PROGRAMS>
           <PROGRAM_NAME>Test Example10</PROGRAM_NAME>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PROGRAMS>
    </PROGRAMS_TBL>
    <PRGM_GL_ACCNT_RLTN_DTLS_TBL>
      <PRGM_GL_ACCNT_RLTN_DTLS>
           <GL_PS_ACCOUNT_NUMBER>33388809</GL_PS_ACCOUNT_NUMBER>
           <SORTED_SEQUENCE/>
           <SHARED>TRUE</SHARED>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PRGM_GL_ACCNT_RLTN_DTLS>
      <PRGM_GL_ACCNT_RLTN_DTLS>
           <GL_PS_ACCOUNT_NUMBER>33388810</GL_PS_ACCOUNT_NUMBER>
           <SORTED_SEQUENCE/>
           <SHARED>TRUE</SHARED>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PRGM_GL_ACCNT_RLTN_DTLS>
    </PRGM_GL_ACCNT_RLTN_DTLS_TBL>
</ACCOUNTS_UI>

Created : 03/15/2017 axt754 -- CCN Project Team
Modified: 08/17/2017 axt754 -- Separate DELETE for ACCOUNTS, PROGRAMS and RELATION
        : 08/24/2017 axt754 -- If a Program has the accounts in relation donot delete program
******************************************************************************/
    in_xml          IN          CLOB);

PROCEDURE PROGRAM_UI_DELETE_SP(
/******************************************************************************
This procedure takes XML as input Which has PROGRAM information
and Deletes the PROGRAM related information

<?xml version="1.0" encoding="UTF-8"?>
<ACCOUNTS_UI>
   <PROGRAMS_TBL>
      <PROGRAMS>
           <PROGRAM_NAME>Test Example10</PROGRAM_NAME>
           <EFFECTIVE_DATE>MM-DD-YYYY</EFFECTIVE_DATE>
           <EXPIRATION_DATE>MM-DD-YYYY</EXPIRATION_DATE>
      </PROGRAMS>
    </PROGRAMS_TBL>
</ACCOUNTS_UI>

Created : 03/15/2017 axt754 -- CCN Project Team
Modified: 08/17/2017 axt754 -- Separate DELETE for ACCOUNTS, PROGRAMS and RELATION
        : 08/24/2017 axt754 -- If a Program has the accounts in relation donot delete program
******************************************************************************/
    in_xml          IN          CLOB);

PROCEDURE GL_ACCOUNTS_PROG_UI_S_SP(
/******************************************************************************
This procedures account number as input and retrives programs that were associated
with the given account and the account information as well.
Created : 08/15/2017 axt754 -- CCN Project Team

******************************************************************************/
    in_accnt_nbr             IN      VARCHAR2
    ,out_gl_accnt_refcursor     OUT  SYS_REFCURSOR
    ,out_prg_accnt_refcursor    OUT  SYS_REFCURSOR) ;

PROCEDURE PROG_GL_ACCOUNTS_UI_S_SP(
/******************************************************************************
This procedure program name as input and gives the accounts related to Program
related information

Created : 08/15/2017 axt754 -- CCN Project Team

******************************************************************************/
    in_prog_name             IN           VARCHAR2
    ,out_prg_refcursor          OUT       SYS_REFCURSOR
    ,out_prg_accnt_refcursor    OUT       SYS_REFCURSOR);

PROCEDURE PROGRAMS_UI_S_SP(
/******************************************************************************
This procedures takes program name as input and retrives the data from
PROGRAMS Table, if the program name is not passed then retrives all the program
names from PROGRAMS Table

Created : 08/16/2017 axt754 -- CCN Project Team

******************************************************************************/
    in_prog_name             IN           VARCHAR2
    ,out_prg_refcursor          OUT       SYS_REFCURSOR);

PROCEDURE GL_ACCOUNTS_UI_S_SP(
/******************************************************************************
This procedures takes GL_ACCOUNT_NUMBER as input and retrives the data from
GENERAL_LEDGER_ACCOUNTS Table, if the GL_ACCOUNT_NUMBER is not passed then retrives all the accounts
from GENERAL_LEDGER_ACCOUNTS Table

Created : 08/16/2017 axt754 -- CCN Project Team

******************************************************************************/
    in_accnt_nbr             IN           VARCHAR2
    ,out_gl_accnt_refcursor     OUT          SYS_REFCURSOR);

PROCEDURE COST_CENTER_DSC_CODES_SP(
/******************************************************************************
This procedure is intended to return a ref cursor with data from COST_CENTER_DSC_CODES 

Created : 12/13/2017 SXG151 CCN Project....
Modified:
*******************************************************************************/
  IN_COST_CENTER_CODE IN     COST_CENTER.COST_CENTER_CODE%TYPE,
  OUT_DSC_CODES          OUT REF_CURSOR);

FUNCTION ADMIN_COST_CNTR_FIELDS_ENBLE(
/*****************************************************************************
This procedure takes the cost center code as input and checks if type_code of cost center
is '41' and category is 'A', IF so returns 'Y' That indicates to show
ALLOCATION_CC and DIVISION_OFFSET Fields, else returns 'N',that indicates
continue as it is working now.

Created : 01/05/2018 axt754 CCN Project....
Modified:
******************************************************************************/
IN_COST_CENTER_CODE IN VARCHAR2) RETURN VARCHAR2;

PROCEDURE PROCESS_SQ_FT_LD(
/****************************************************************************** 
This procedures takes care of following things as part of batch load process from UI
  # Get the data from UI
  # Upload the file on DB SERVER
  # call the batch process

Created : 12/05/2017 axt754 -- CCN Project Team
Changes :
******************************************************************************/
IN_BLOB            IN       BLOB);

END CCN_UI_INTERFACE_APP_PKG;