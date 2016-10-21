CREATE OR REPLACE PACKAGE COSTCNTR.CCN_HIERARCHY
    AS
	 	TYPE REF_CURSOR IS REF CURSOR;

PROCEDURE ELIMINATE_SPECIAL_CHRS(
/**********************************************************
This procedure will elminate special characters

Created : 06/23/2013 jxc517 CCN Project....
**********************************************************/
    IO_HIERARCHY_DETAIL_ROW IN OUT HIERARCHY_DETAIL%ROWTYPE);

PROCEDURE update_cc_global_hrchy_ind(
/***********************************************************
      update_cc_global_hrchy_ind 
      This Procedure will update COST_CENTER.GLOBAL_HIERARCHY_IND 
      based on passed input cost center
      
Created : 09/12/2013 CCN Project
************************************************************/
in_COST_CENTER_CODE   IN   VARCHAR2);

PROCEDURE hierarchy_insert_wrapper
( in_ind IN VARCHAR2,
  in_hierarchy_detail_row IN hierarchy_detail%ROWTYPE);

/**********************************************************
	RETURN_HIERARCHY

	This procedure will return a ref cursor with data from 
	from the hierarchy_detail table based on header name, current value , traverse ( UP or DOWN DEFAULT is UP)
	and level
	ex. CCN_HIERARCHY.RETURN_HIERARCHY('DAD Structure','703252','DOWN',OUT_DEFINED_REF_CURSOR)

created : 03/22/2012 OD CCN Project....
**********************************************************/
		PROCEDURE RETURN_HIERARCHY (	
						IN_HEADER_NAME 		IN HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE
			    , 	IN_CURR_ROW_VAL	IN HIERARCHY_DETAIL.HRCHY_DTL_CURR_ROW_VAL%TYPE
			    ,	IN_LEVEL		IN HIERARCHY_DETAIL.HRCHY_DTL_LEVEL%TYPE
			    ,	IN_TRAVERSE		IN VARCHAR2 DEFAULT 'UP'
			    ,   OUT_HIERARCHY_REF_CUR IN OUT REF_CURSOR
         --    ,   OUT_HIERARCHY_REF_CUR IN OUT SYS_REFCURSOR
					   );


PROCEDURE RETURN_HIERARCHY_LAST_LVL (	
/**********************************************************
	RETURN_HIERARCHY

	This procedure will return a ref cursor with data from 
	from the hierarchy_detail lowest level table based on header name, current value , t
	

created : 06/22/2012 kdp CCN Project....
Modified: 10/16/2014 Axk326 CCN Project....
**********************************************************/

				IN_HEADER_NAME 			IN HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE
			    ,	IN_LEVEL			IN HIERARCHY_DETAIL.HRCHY_DTL_LEVEL%TYPE
			    ,	IN_COMPOSITE_KEY	IN HIERARCHY_DETAIL.HRCHY_DTL_PREV_LVL_VAL%TYPE
			    ,   OUT_HIERARCHY_REF_CUR IN OUT REF_CURSOR
			   );


PROCEDURE RETURN_HIERARCHY_DETAIL_CC_LVL (	
/**********************************************************
	RETURN_HIERARCHY_DETAIL_CC_LVL

	This procedure will return a ref cursor with data from 
	from the hierarchy_detail lowest level table based on header name, current value , t


created : 02/20/2012 kdp CCN Project....Phase 1.1
**********************************************************/

				IN_HEADER_NAME 				IN HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE
			    ,	IN_LEVEL				IN HIERARCHY_DETAIL.HRCHY_DTL_LEVEL%TYPE
			    ,	IN_COST_CENTER_CODE		IN HIERARCHY_DETAIL.HRCHY_DTL_CURR_ROW_VAL%TYPE
			    ,   OUT_HIERARCHY_REF_CUR 	IN OUT REF_CURSOR
			   );

/**********************************************************
	RETURN_HIERARCHY

	This procedure will return a ref cursor with data from 
	from the hierarchy_detail table based on header name, current value , traverse ( UP or DOWN DEFAULT is UP)
	and structure as of history date (NULL if you want current structure which is also the DEFAULT)
	ex. CCN_HIERARCHY.RETURN_HIERARCHY('DAD Structure','703252','DOWN',TO_DATE(03/24/2011','MM/DD/YYYY'),OUT_DEFINED_REF_CURSOR)

created : 03/22/2012 OD CCN Project....
**********************************************************/
		PROCEDURE RETURN_HIERARCHY_HIST (	
						IN_HEADER_NAME 	IN HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE
					    , 	IN_CURR_ROW_VAL	IN HIERARCHY_DETAIL.HRCHY_DTL_CURR_ROW_VAL%TYPE
					    ,	IN_LEVEL	IN HIERARCHY_DETAIL.HRCHY_DTL_LEVEL%TYPE
					    ,	IN_TRAVERSE	IN VARCHAR2 DEFAULT 'UP'
					    ,	IN_HIST_DATE	IN HIERARCHY_DETAIL.HRCHY_DTL_EFF_DATE%TYPE DEFAULT NULL
					    ,   OUT_HIERARCHY_REF_CUR OUT REF_CURSOR
					   );
		PROCEDURE RETURN_HIERARCHY_UP (	
/**********************************************************
	RETURN_DAD

	This procedure will return a ref cursor with DAD data from 
	from the hierarchy_detail table based on just the header name, cost center or last level value
	ex. CCN_HIERARCHY.RETURN_HIERARCHY('DAD Structure','703252','DOWN',OUT_DEFINED_REF_CURSOR)

created : 07/22/2012 OD CCN Project....
**********************************************************/
						IN_HEADER_NAME 	IN HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE
					    , 	IN_ROW_VAL	IN HIERARCHY_DETAIL.HRCHY_DTL_CURR_ROW_VAL%TYPE
					    ,   OUT_HIERARCHY_REF_CUR IN OUT REF_CURSOR
					   );
PROCEDURE HIERARCHY_PICKLIST(	
/**********************************************************
	HIERARCHY_PICKLIST

	This procedure will return data in ref_cursor 
        from HIERARCHY_DETAIL depending on the input params
        Ex - If all the Areas need to be returned for a Given 
        Division then the XML from the UI will have Hierarchy Name
        and Hierarchy Detail level '2' and current division ='04'
        
<HIERARCHY_DETAIL>
  <row_data>
      <USER_ID>xxxxxx</USER_ID> 
      <HRCHY_HDR_NAME>DAD STRUCTURE</HRCHY_HDR_NAME> 
      <HRCHY_DTL_LEVEL>4</HRCHY_DTL_LEVEL> 
      <HRCHY_LEVEL1>04</HRCHY_LEVEL1> 
      <HRCHY_LEVEL2>02</HRCHY_LEVEL2>
      <HRCHY_LEVEL3>35</HRCHY_LEVEL3>
      <HRCHY_LEVEL4>708113</HRCHY_LEVEL4>
  </row_data>
</HIERARCHY_DETAIL>

created : 02/13/2013 SH CCN Project....
modified: 09/25/2014 jxc517 CCN Project.....passing user_id to restrict users with only territory access
**********************************************************/
  in_XML                VARCHAR2,--XMLTYPE,
  OUT_HIERARCHY_REF_CUR OUT REF_CURSOR);

PROCEDURE HIERARCHY_STMNT_TYPE_PICKLIST(	
/**********************************************************
	HIERARCHY_STMNT_TYPE_PICKLIST

	This procedure will return data in ref_cursor 
        for statement type from HIERARCHY_DETAIL depending 
        on the input params
        Ex - If all the Areas need to be returned for a Given 
        Division then the XML from the UI will have Hierarchy Name
        and Hierarchy Detail level '2' and current division ='04'
        
<HIERARCHY_DETAIL>
  <row_data>
      <HRCHY_HDR_NAME>DAD STRUCTURE</HRCHY_HDR_NAME> 
      <HRCHY_DTL_LEVEL>4</HRCHY_DTL_LEVEL> 
      <HRCHY_LEVEL1>04</HRCHY_LEVEL1> 
      <HRCHY_LEVEL2>02</HRCHY_LEVEL2>
      <HRCHY_LEVEL3>35</HRCHY_LEVEL3>
      <HRCHY_LEVEL4>708113</HRCHY_LEVEL4>
  </row_data>
</HIERARCHY_DETAIL>

created : 02/13/2013 SH CCN Project....
**********************************************************/
  in_XML                VARCHAR2,--XMLTYPE,
  OUT_HIERARCHY_REF_CUR OUT REF_CURSOR);
  
PROCEDURE HIERARCHY_HDR_DESC_PICKLIST(	
/**********************************************************
	HIERARCHY_HDR_DESC_PICKLIST

	This procedure will return the data in ref cursor
        from HIERARCHY_HEADER and HIERARCHY_DESCRIPTION

<HIERARCHY_DETAIL>
  <row_data>
      <HRCHY_HDR_NAME>DAD STRUCTURE</HRCHY_HDR_NAME> 
  </row_data>
</HIERARCHY_DETAIL>
created : 02/13/2013 SH CCN Project....
**********************************************************/
  in_XML                VARCHAR2,
  OUT_HIERARCHY_REF_CUR OUT REF_CURSOR
  );
 
PROCEDURE HIERARCHY_HEADER_INSERT(
/**********************************************************
	HIERARCHY_HEADER_INSERT

	This procedure will insert into the table HIERARCHY_HEADER
        
<HIERARCHY_HEADER>
  <row_data>
      <HRCHY_HDR_NAME>DAD STRUCTURE</HRCHY_HDR_NAME> 
      <HRCHY_HDR_LEVELS>04</HRCHY_HDR_LEVELS> 
      <HRCHY_HDR_DESC>Div Area Dist Structure</HRCHY_HDR_DESC> 
      <UPPER_LVL_VER_DESC>Statement Type</UPPER_LVL_VER_DESC>
  </row_data>
</HIERARCHY_HEADER>

created : 02/13/2013 SH CCN Project....
**********************************************************/
    in_XML                VARCHAR2);

PROCEDURE HIERARCHY_HEADER_ATTR_UPDATE(
/**********************************************************
	HIERARCHY_HEADER_ATTR_UPDATE

	This procedure will update the attributes in the table HIERARCHY_HEADER 
        
<HIERARCHY_HEADER>
  <row_data>
      <HRCHY_HDR_NAME>DAD STRUCTURE</HRCHY_HDR_NAME> 
      <HRCHY_HDR_LEVELS>04</HRCHY_HDR_LEVELS> 
      <HRCHY_HDR_DESC>Div Area Dist Structure</HRCHY_HDR_DESC> 
      <attributes>
	   <upper_lvl_ver_desc> 
	      <Name>statement_type</Name>
	      <Description>pkListValue</Description>
	   </upper_lvl_ver_desc>
           <upper_lvl_ver_desc> 
	      <Name>ManagerName</Name>
              <Description>CC Mgr Name</Description>
	   </upper_lvl_ver_desc>
           <upper_lvl_ver_desc> 
	       <Name>state_code</Name>
	       <Description>pkListValue</Description>
	   </upper_lvl_ver_desc>
      </attributes>
  </row_data>
</HIERARCHY_HEADER>

created : 02/24/2014 jxc517 CCN Project. . . 
**********************************************************/
    in_XML                CLOB);

PROCEDURE HIERARCHY_DESCRIPTION_INSERT(
/**********************************************************
	HIERARCHY_DESCRIPTION_INSERT

	This procedure will insert into the table HIERARCHY_DESCRIPTION 
        
<HIERARCHY_DESCRIPTION>
  <row_data>
      <HRCHY_HDR_NAME>DAD STRUCTURE</HRCHY_HDR_NAME> 
      <HRCHY_HDR_LEVEL_NBR>04</HRCHY_HDR_LEVELS> 
      <HRCHY_HDR_LVL_DESC>Div Area Dist Structure</HRCHY_HDR_DESC> 
  </row_data>
</HIERARCHY_DESCRIPTION>

created : 02/13/2013 SH CCN Project....
**********************************************************/
    IN_XML                CLOB);

PROCEDURE HIERARCHY_DSCRPTN_ATTR_UPDATE(
/**********************************************************
	HIERARCHY_DSCRPTN_ATTR_UPDATE

	This procedure will update the attributes in the table HIERARCHY_DESCRIPTION 
        
<HIERARCHY_DESCRIPTION>
  <row_data>
    <HRCHY_LEVELS>
      <HRCHY_HDR_NAME>DAD STRUCTURE</HRCHY_HDR_NAME> 
      <HRCHY_HDR_LVL_NBR>03</HRCHY_HDR_LVL_NBR> 
      <HRCHY_HDR_LVL_DESC>AREA</HRCHY_HDR_LVL_DESC>
      <HRCHY_GLOBAL_LVL_NBR>9</HRCHY_GLOBAL_LVL_NBR>
      <LVL_VALUE_SIZE>2</LVL_VALUE_SIZE>
      <attributes>
	   <upper_lvl_ver_desc> 
	      <Name>statement_type</Name>
	      <Description>pkListValue</Description>
	   </upper_lvl_ver_desc>
           <upper_lvl_ver_desc> 
	      <Name>ManagerName</Name>
              <Description>CC Mgr Name</Description>
	   </upper_lvl_ver_desc>
           <upper_lvl_ver_desc> 
	       <Name>state_code</Name>
	       <Description>pkListValue</Description>
	   </upper_lvl_ver_desc>
      </attributes>
    </HRCHY_LEVELS> 
  	<HRCHY_LEVELS>
      <HRCHY_HDR_NAME>DAD STRUCTURE</HRCHY_HDR_NAME> 
      <HRCHY_HDR_LVL_NBR>04</HRCHY_HDR_LVL_NBR> 
      <HRCHY_HDR_LVL_DESC>DIST</HRCHY_HDR_LVL_DESC> 
      <HRCHY_GLOBAL_LVL_NBR>9</HRCHY_GLOBAL_LVL_NBR>
      <LVL_VALUE_SIZE>2</LVL_VALUE_SIZE>
      <attributes>
	   <upper_lvl_ver_desc> 
	      <Name>statement_type</Name>
	      <Description>pkListValue</Description>
	   </upper_lvl_ver_desc>
           <upper_lvl_ver_desc> 
	      <Name>ManagerName</Name>
              <Description>CC Mgr Name</Description>
	   </upper_lvl_ver_desc>
           <upper_lvl_ver_desc> 
	       <Name>state_code</Name>
	       <Description>pkListValue</Description>
	   </upper_lvl_ver_desc>
      </attributes>
    </HRCHY_LEVELS> 
  </row_data>
</HIERARCHY_DESCRIPTION>

created : 02/03/2014 JXC517 CCN Project....
**********************************************************/
    in_XML                CLOB);

FUNCTION CURRENT_LVL_EXISTS (
/***********************************************************
      CURRENT_LVL_EXISTS 
      This Procedure will check for the current record 
      before the insert for Duplicates

      IN_FLAG          'H' for History table and NULL for Detail table
      
Created : 07/25/2013 CCN Project
************************************************************/
IN_FLAG                  IN  VARCHAR2,
IN_HIERARCHY_DETAIL_ROW  IN  HIERARCHY_DETAIL%ROWTYPE)
RETURN VARCHAR2;

PROCEDURE GET_PREVIOUS_LVL(
/***********************************************************
      GET_PREVIOUS_LVL 
      This Procedure get the previous record 

      IN_FLAG          'H' for History table and NULL for Detail table

Created : 07/25/2013 CCN Project
************************************************************/
  IN_FLAG                  IN  VARCHAR2,
  IN_HIERARCHY_DETAIL_ROW  IN  HIERARCHY_DETAIL%ROWTYPE,
  OUT_HIERARCHY_DETAIL_ROW OUT HIERARCHY_DETAIL%ROWTYPE);

FUNCTION HIERARCHY_DESC_RETURN (
/***********************************************************
      HIERARCHY_DESC_RETURN 
      This Procedure will return the Hierarchy level DESC 
      from HIERARCHY_DETAIL for any curr val passed and for any
      level. This is used for the insert into hist for Transfer 
      process.
input param : in_HRCHY_DTL_CURR_LVL_VAL
Created : 03/19/2013 SH CCN Project
revised : 05/02/2013 kdp ccn Header Name to query 
************************************************************/
IN_HIERARCHY_DETAIL_ROW IN HIERARCHY_DETAIL%ROWTYPE)
RETURN VARCHAR2;

FUNCTION HIERARCHY_ATTRIBUTE_RETURN (
/***********************************************************
      HIERARCHY_ATTRIBUTE_RETURN 
      This Procedure will return the Hierarchy level Attributes 
      from HIERARCHY_DETAIL for any curr val passed and for any
      level. 

input param : in_HRCHY_DTL_CURR_LVL_VAL
Created : 08/02/2013 CCN Project
************************************************************/
IN_HIERARCHY_DETAIL_ROW IN HIERARCHY_DETAIL%ROWTYPE)
RETURN XMLTYPE;

FUNCTION COST_CENTER_DESCRIPTION(
/***********************************************************
COST_CENTER_DESCRIPTION
      This function will return the COST_CENTER_NAME 
      from COST_CENTER into HRCHY_DTL_DESC
Created : 08/23/2013 CCN Project
************************************************************/
IN_COST_CENTER_CODE IN VARCHAR2)
RETURN VARCHAR2;

FUNCTION GET_MGR_NAME_FNC(
/***********************************************************
GET_MGR_NAME_FNC
      This function will return the MANAGER_NAME 
      from COST_CENTER into HRCHY_DTL_DESC
Created : 10/07/2014 axk326 ccn project
************************************************************/
IN_COST_CENTER_CODE IN EMPLOYEE_DETAILS.COST_CENTER_CODE%TYPE)
RETURN VARCHAR2;

FUNCTION GET_TYPE_FNC(
/***********************************************************
GET_TYPE_FNC
      This function will return the MANAGER_NAME 
      from COST_CENTER into HRCHY_DTL_DESC
Created : 10/07/2014 axk326 ccn project
************************************************************/
IN_COST_CENTER_CODE IN VARCHAR2)
RETURN VARCHAR2;

FUNCTION GET_CATEGORY_FNC(
/***********************************************************
GET_CATEGORY_FNC
      This function will return the MANAGER_NAME 
      from COST_CENTER into HRCHY_DTL_DESC
Created : 10/07/2014 axk326 ccn project
************************************************************/
IN_COST_CENTER_CODE IN VARCHAR2)
RETURN VARCHAR2;

FUNCTION COST_CENTER_STATEMENT_TYPE(
/***********************************************************
COST_CENTER_STATEMENT_TYPE
      This function will return the upper_lvl_ver_valeu
      with STATEMENT_TYPE replaced with the cost center STATEMENT_TYPE
Created : 09/18/2013 CCN Project
************************************************************/
       IN_UPPER_LVL_VER_VALUE  IN HIERARCHY_DETAIL.UPPER_LVL_VER_VALUE%TYPE,
       IN_COST_CENTER_CODE     IN VARCHAR2)
RETURN VARCHAR2;

FUNCTION GET_COST_CENTER_STMNT_TYP_FNC(
/***********************************************************
GET_COST_CENTER_STMNT_TYP_FNC
      This function will return the statement type for the cost center passed in

Created : 10/28/2013 CCN Project
************************************************************/
       IN_COST_CENTER_CODE     IN VARCHAR2) RETURN VARCHAR2;

FUNCTION HIERARCHY_EFF_DATE_RETURN (
/***********************************************************
      HIERARCHY_EFF_DATE_RETURN 
      This Procedure will return the Hierarchy level Effective Date 
      from HIERARCHY_DETAIL for any curr val passed and for any
      level. 

input param : IN_HIERARCHY_DETAIL_ROW
Created : 08/02/2013 CCN Project
************************************************************/
IN_HIERARCHY_DETAIL_ROW IN HIERARCHY_DETAIL%ROWTYPE)
RETURN DATE;

FUNCTION HIERARCHY_EXP_DATE_RETURN (
/***********************************************************
      HIERARCHY_EXP_DATE_RETURN 
      This Procedure will return the Hierarchy level Expiration Date 
      from HIERARCHY_DETAIL for any curr val passed and for any
      level. 

input param : IN_HIERARCHY_DETAIL_ROW
Created : 08/02/2013 CCN Project
************************************************************/
IN_HIERARCHY_DETAIL_ROW IN HIERARCHY_DETAIL%ROWTYPE)
RETURN DATE;

PROCEDURE HIERARCHY_DELETE_WRAPPER(
/***********************************************************
      HIERARCHY_DELETE_WRAPPER 
      This Procedure will delete from HIERARCHY_DETAIL or
      HIERARCHY_DETAIL_HST based on the in_flag
      level. 

      IN_FLAG                  IN  VARCHAR2,

input param : in_HRCHY_DTL_CURR_LVL_VAL
Created : 08/02/2013 CCN Project
************************************************************/
IN_FLAG                 IN VARCHAR2,
IN_HIERARCHY_DETAIL_ROW IN HIERARCHY_DETAIL%ROWTYPE);

PROCEDURE HIERARCHY_UPDATE_WRAPPER(
/***********************************************************
      HIERARCHY_UPDATE_WRAPPER 
      This Procedure will update from HIERARCHY_DETAIL or
      HIERARCHY_DETAIL_HST based on the in_flag
      level. 
      
      IN_FLAG                  IN  VARCHAR2,
  
input param : in_HRCHY_DTL_CURR_LVL_VAL
Created : 08/02/2013 CCN Project
************************************************************/
IN_FLAG                 IN VARCHAR2,
IN_HIERARCHY_DETAIL_ROW IN HIERARCHY_DETAIL%ROWTYPE);

PROCEDURE HIERARCHY_TRANSFER_PROCESS(
/***********************************************************
This procedure will be called from UI to transfer particular cost center
from one hierarchy to another

Example Input:
<?xml version="1.0" encoding="UTF-8"?>
<HIERARCHY_DETAIL>
    <row_data>
        <HRCHY_HDR_NAME>ADMIN_TO_SALES_AREA</HRCHY_HDR_NAME>
        <HRCHY_DTL_LEVEL>5</HRCHY_DTL_LEVEL>
        <FROM_HIERARCHY>
            <HRCHY_LEVEL1>01</HRCHY_LEVEL1>
            <HRCHY_LEVEL2>01</HRCHY_LEVEL2>
            <HRCHY_LEVEL3>01</HRCHY_LEVEL3>
            <HRCHY_LEVEL4>01</HRCHY_LEVEL4>
        </FROM_HIERARCHY>
        <TRANSFER_TO>
            <TO_HIERARCHY>
                <HRCHY_LEVEL1>01</HRCHY_LEVEL1>
                <HRCHY_LEVEL2>01</HRCHY_LEVEL2>
                <HRCHY_LEVEL3>01</HRCHY_LEVEL3>
                <HRCHY_LEVEL4>06</HRCHY_LEVEL4>
                <HRCHY_LEVEL5>800411</HRCHY_LEVEL5>
                <HRCHY_DTL_EFF_DATE>07-29-2013</HRCHY_DTL_EFF_DATE>
                <HRCHY_DTL_EXP_DATE></HRCHY_DTL_EXP_DATE>
                <HRCHY_DTL_DESC>WAREHOUSING-25</HRCHY_DTL_DESC>
                <attributes>
                    <upper_lvl_ver_desc>
                        <Name>statement_type</Name>
                        <Description>pkListValue</Description>
                        <Value>JM</Value>
                    </upper_lvl_ver_desc>
                </attributes>
            </TO_HIERARCHY>
            <TO_HIERARCHY>
                <HRCHY_LEVEL1>01</HRCHY_LEVEL1>
                <HRCHY_LEVEL2>01</HRCHY_LEVEL2>
                <HRCHY_LEVEL3>01</HRCHY_LEVEL3>
                <HRCHY_LEVEL4>06</HRCHY_LEVEL4>
                <HRCHY_LEVEL5>800412</HRCHY_LEVEL5>
                <HRCHY_DTL_EFF_DATE>07-29-2013</HRCHY_DTL_EFF_DATE>
                <HRCHY_DTL_EXP_DATE></HRCHY_DTL_EXP_DATE>
                <HRCHY_DTL_DESC>WAREHOUSING-26</HRCHY_DTL_DESC>
                <attributes>
                    <upper_lvl_ver_desc>
                        <Name>statement_type</Name>
                        <Description>pkListValue</Description>
                        <Value>JM</Value>
                    </upper_lvl_ver_desc>
                </attributes>
            </TO_HIERARCHY>
        </TRANSFER_TO>
    </row_data>
</HIERARCHY_DETAIL>

Created : 01/17/2014 jxc517 CCN Project Team....
update  : 09/18/2014 NXK927  -- Hier territory cost center tranfer(mail) 
modified: 02/02/2015 axk326 CCN Project Team...
          Added Upper() function while selecting from any table 
          based on COST_CENTER_CODE
Modified: 10/14/2015 SXT410 CCN Project Team...
          Adding HRCHY_DTL_EXP_DATE As Sysdate For Expired Hierarchy Level.
Modified: 03/31/2016 jxc517 CCN Project....
          Added parameter to deal with futures
          Added code to push the record into future tables, if it is a future record
          Added business rule to stop creating a future if a future already exists
************************************************************/
    IN_XML                IN     CLOB,
    IN_OVERWRITE_FLAG     IN     VARCHAR2 DEFAULT 'N');

PROCEDURE HIERARCHY_DETAIL_INSERT(
/**********************************************************
This procedure will be called from UI to insert particular hierarchy

Example Input:
<?xml version="1.0" encoding="UTF-8"?>
<HIERARCHY_DETAIL>
    <userId>pxp301</userId>
    <row_data>
        <HRCHY_HDR_NAME>GLOBAL_HIERARCHY</HRCHY_HDR_NAME>
        <HRCHY_DTL_LEVEL>9</HRCHY_DTL_LEVEL>
        <HRCHY_LEVEL1>01</HRCHY_LEVEL1>
        <HRCHY_LEVEL2>01</HRCHY_LEVEL2>
        <HRCHY_LEVEL3>01</HRCHY_LEVEL3>
        <HRCHY_LEVEL4>01</HRCHY_LEVEL4>
        <HRCHY_LEVEL5>01</HRCHY_LEVEL5>
        <HRCHY_LEVEL6>01</HRCHY_LEVEL6>
        <HRCHY_LEVEL7>01</HRCHY_LEVEL7>
        <HRCHY_LEVEL8>01</HRCHY_LEVEL8>
        <HRCHY_LEVEL9>70DDDD</HRCHY_LEVEL9>
        <HRCHY_DTL_DESC>Cuyahoga</HRCHY_DTL_DESC>
        <HRCHY_DTL_EFF_DATE>01-24-2014</HRCHY_DTL_EFF_DATE>
        <HRCHY_DTL_EXP_DATE>01-31-2014</HRCHY_DTL_EXP_DATE>
        <attributes>
            <upper_lvl_ver_desc>
                <Name>Statement Type</Name>
                <Description>Picklist Value</Description>
                <Value>US</Value>
            </upper_lvl_ver_desc>
        </attributes>
    </row_data>
</HIERARCHY_DETAIL>

Created : 01/17/2014 jxc517 CCN Project Team....
Modified: 03/31/2016 jxc517 CCN Project....
          Added parameter to deal with futures
          Added code to push the record into future tables, if it is a future record
          Added business rule to stop creating a future if a future already exists
**********************************************************/
    IN_XML                IN     CLOB,
    IN_OVERWRITE_FLAG     IN     VARCHAR2 DEFAULT 'N');

PROCEDURE HIERARCHY_HDR_PICKLIST(	
/**********************************************************
	HIERARCHY_HDR_DESC_PICKLIST

	This procedure will return the data in ref cursor
        from HIERARCHY_HEADER and HIERARCHY_DESCRIPTION
        

created : 04/25/2013 kdp CCN Project....
modified: 08/27/2014 jxc517 CCN Project
**********************************************************/
  IN_USER_ID         IN     VARCHAR2,
  OUT_HIERARCHY_REF_CUR OUT REF_CURSOR
  );

FUNCTION VALIDATE_HIERARCHY(
/*******************************************************************************
 VALIDATE_HIERARCHY  
   
  This procedure will validate the hierarchy from bottom to top and raise 
  corresponding error if particular level value doesn't exist

created : JXC517 11/14/2013
revised : kdp 11/21/2013 Changed to return y/n
********************************************************************************/
    IN_HRCHY_HDR_NAME         VARCHAR2,
    IN_HRCHY_DTL_CURR_LVL_VAL VARCHAR2) RETURN VARCHAR;

PROCEDURE HIERARCHY_DETAIL_DELETE(
/**********************************************************
	HIERARCHY_DETAIL_DELETE

	This procedure will be called from UI to delete particular hierarchy

Inputs:
IN_XML - XML that contains the details of the hierarchy to be deleted

Example Input:
<?xml version="1.0" encoding="UTF-8"?>
<HIERARCHY_DETAIL>
    <userId>pxp301</userId>
    <row_data>
        <HRCHY_HDR_NAME>GLOBAL_HIERARCHY</HRCHY_HDR_NAME>
        <HRCHY_DTL_LEVEL>9</HRCHY_DTL_LEVEL>
        <HRCHY_LEVEL1>01</HRCHY_LEVEL1>
        <HRCHY_LEVEL2>01</HRCHY_LEVEL2>
        <HRCHY_LEVEL3>01</HRCHY_LEVEL3>
        <HRCHY_LEVEL4>01</HRCHY_LEVEL4>
        <HRCHY_LEVEL5>01</HRCHY_LEVEL5>
        <HRCHY_LEVEL6>01</HRCHY_LEVEL6>
        <HRCHY_LEVEL7>01</HRCHY_LEVEL7>
        <HRCHY_LEVEL8>01</HRCHY_LEVEL8>
        <HRCHY_LEVEL9>70DDDD</HRCHY_LEVEL9>
        <HRCHY_DTL_DESC>Cuyahoga</HRCHY_DTL_DESC>
        <HRCHY_DTL_EFF_DATE>01-24-2014</HRCHY_DTL_EFF_DATE>
        <HRCHY_DTL_EXP_DATE>01-31-2014</HRCHY_DTL_EXP_DATE>
        <attributes>
            <upper_lvl_ver_desc>
                <Name>Statement Type</Name>
                <Description>Picklist Value</Description>
                <Value>US</Value>
            </upper_lvl_ver_desc>
        </attributes>
    </row_data>
</HIERARCHY_DETAIL>

Created : 01/17/2014 JXC517
**********************************************************/
    IN_XML                CLOB);

PROCEDURE TRANSFER_LOAD_PROCESS(
/******************************************************************************
TRANSFER_LOAD_PROCESS

This procedure is the core process for the cost center transfer through UI
that invokes bulk load for transfer

IN_BLOB          - blob value delimited by , and termianted by new line character

Created by Kdp 01/22/2014
******************************************************************************/
IN_BLOB            IN       BLOB
);

PROCEDURE INSERT_LOAD_PROCESS(
/******************************************************************************
INSERT_LOAD_PROCESS

This procedure is the core process for the cost center insert through UI
that invokes bulk load for insert

IN_BLOB          - blob value delimited by , and termianted by new line character

Created by jxc 03/11/2014
******************************************************************************/
IN_BLOB            IN       BLOB
);

PROCEDURE HIERARCHY_HIST_INSERT(
/**********************************************************
This procedure will check and insert the history records accordingly
Also deletes the expired record

Inputs:
IN_HIERARCHY_DETAIL_REC     -      HIERARCHY_DETAIL%ROWTYPE

Created : 10/12/2015 jxc517
Revised : 
**********************************************************/
IN_HIERARCHY_DETAIL_REC     IN     HIERARCHY_DETAIL%ROWTYPE);

PROCEDURE HIERARCHY_DETAIL_UPDATE(
/**********************************************************
	HIERARCHY_DETAIL_UPDATE

	This procedure will be called from UI to update particular hierarchy record

Inputs:
IN_XML - XML that contains the details of the hierarchy to be updated

Example Input:
<?xml version="1.0" encoding="UTF-8"?>
<HIERARCHY_DETAIL>
    <userId>pxp301</userId>
    <row_data>
        <HRCHY_HDR_NAME>GLOBAL_HIERARCHY</HRCHY_HDR_NAME>
        <HRCHY_DTL_LEVEL>9</HRCHY_DTL_LEVEL>
        <HRCHY_LEVEL1>01</HRCHY_LEVEL1>
        <HRCHY_LEVEL2>01</HRCHY_LEVEL2>
        <HRCHY_LEVEL3>01</HRCHY_LEVEL3>
        <HRCHY_LEVEL4>01</HRCHY_LEVEL4>
        <HRCHY_LEVEL5>01</HRCHY_LEVEL5>
        <HRCHY_LEVEL6>01</HRCHY_LEVEL6>
        <HRCHY_LEVEL7>01</HRCHY_LEVEL7>
        <HRCHY_LEVEL8>01</HRCHY_LEVEL8>
        <HRCHY_LEVEL9>70DDDD</HRCHY_LEVEL9>
        <HRCHY_DTL_DESC>Cuyahoga</HRCHY_DTL_DESC>
        <HRCHY_DTL_EFF_DATE>01-24-2014</HRCHY_DTL_EFF_DATE>
        <HRCHY_DTL_EXP_DATE>01-31-2014</HRCHY_DTL_EXP_DATE>
        <attributes>
            <upper_lvl_ver_desc>
                <Name>Statement Type</Name>
                <Description>Picklist Value</Description>
                <Value>US</Value>
            </upper_lvl_ver_desc>
        </attributes>
    </row_data>
</HIERARCHY_DETAIL>

Created : 01/17/2014 JXC517

**********************************************************/
    IN_XML                CLOB);
    
PROCEDURE GET_RQSTD_ATTRIBUTE_VALUE(
/***********************************************************
      GET_RQSTD_ATTRIBUTE_VALUE 
      This Procedure will get the requested attribute value for from
      the passed UPPER_LVL_VER_DESC XML
      
Created : 30/14/2014 jxc517 CCN Project
************************************************************/
    IN_UPPER_LVL_VER_VALUE  IN     HIERARCHY_DETAIL.UPPER_LVL_VER_VALUE%TYPE,
    IN_ATTRIBUTE_NAME       IN     VARCHAR2,
    OUT_ATTRIBUTE_VALUE        OUT VARCHAR2);

FUNCTION GET_RQSTD_ATTRIBUTE_VALUE(
/***********************************************************
      This function will return the requested attribute value for 
      the passed UPPER_LVL_VER_DESC XML
      
Created : 04/23/2015 jxc517 CCN Project
************************************************************/
    IN_UPPER_LVL_VER_VALUE  IN     HIERARCHY_DETAIL.UPPER_LVL_VER_VALUE%TYPE,
    IN_ATTRIBUTE_NAME       IN     VARCHAR2) RETURN VARCHAR2;

PROCEDURE DCO_COSTCENTER_LOOKUP(
/***********************************************************
This procedure will validate the passed cost center code and 
return the corresponding record from COST_CENTER table

Created : 08/23/2016 vxv336 CCN Project
Modified: 08/23/2016 vxv336 
          Return a ref cursor instead of rowtype
************************************************************/
in_COST_CENTER IN COST_CENTER.COST_CENTER_CODE%TYPE,
OUT_COST_CENTER_REF_CUR OUT REF_CURSOR
);

END CCN_HIERARCHY;
