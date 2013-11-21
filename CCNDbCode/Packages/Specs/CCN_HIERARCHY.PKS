create or replace 
PACKAGE CCN_HIERARCHY
    AS
	 	TYPE REF_CURSOR IS REF CURSOR;
--Declaring global level exception
CC_EXISTS_ERR       EXCEPTION;

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
  in_hierarchy_detail_row IN hierarchy_detail%rowtype);

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
**********************************************************/

				IN_HEADER_NAME 			IN HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE
			    ,	IN_LEVEL			IN HIERARCHY_DETAIL.HRCHY_DTL_LEVEL%TYPE
			    ,	IN_COMPOSITE_KEY	IN HIERARCHY_DETAIL.HRCHY_DTL_PREV_LVL_VAL%TYPE
			    ,   OUT_HIERARCHY_REF_CUR IN OUT REF_CURSOR
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
      <HRCHY_HDR_NAME>DAD STRUCTURE</HRCHY_HDR_NAME> 
      <HRCHY_DTL_LVL>4</HRCHY_DTL_LVL> 
      <HRCHY_LEVEL1>04</HRCHY_LEVEL1> 
      <HRCHY_LEVEL2>02</HRCHY_LEVEL2>
      <HRCHY_LEVEL3>35</HRCHY_LEVEL3>
      <HRCHY_LEVEL4>708113</HRCHY_LEVEL4>
  </row_data>
</HIERARCHY_DETAIL>

created : 02/13/2013 SH CCN Project....
**********************************************************/
  in_XML                VARCHAR2,
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
    IN_XML                VARCHAR2);

PROCEDURE BUILD_COMPOSITE_KEYS(
/***********************************************************
      BUILD_COMPOSITE_KEYS 
      This Procedure will build composite keys for the Transfer
      or INSERT Procedures

Input :-

<HIERARCHY_DETAIL>
  <row_data>
        <HRCHY_HDR_NAME>DAD STRUCTURE</HRCHY_HDR_NAME> 
        <HRCHY_DTL_LEVEL>4</HRCHY_DTL_LEVEL> 
        <FROM_HIERARCHY>
            <HRCHY_LEVEL1>05</HRCHY_LEVEL1> 
            <HRCHY_LEVEL2>02</HRCHY_LEVEL2> 
            <HRCHY_LEVEL3>95</HRCHY_LEVEL3>
        </FROM_HIERARCHY>
	<TRANSFER_TO>
        	<TO_HIERARCHY>
       		     <HRCHY_LEVEL1>04</HRCHY_LEVEL1> 
       		     <HRCHY_LEVEL2>02</HRCHY_LEVEL2> 
       		     <HRCHY_LEVEL3>35</HRCHY_LEVEL3>
       		     <HRCHY_LEVEL4>784659</HRCHY_LEVEL4>
       		     <HRCHY_DTL_EFF_DATE>01-APR-2014</HRCHY_DTL_EFF_DATE>
       		     <HRCHY_DTL_EXP_DATE>01-APR-2015</HRCHY_DTL_EXP_DATE>
			        <attributes>
			             <upper_lvl_ver_desc> 
			                  <Name>statement_type</Name>
			                  <Description>pkListValue</Description>
			                  <Value>US1</Value>
			             </upper_lvl_ver_desc>
			             <upper_lvl_ver_desc> 
			                  <Name>ManagerName</Name>
			                  <Description>CC Mgr Name</Description>
			                  <Value>Some Name1</Value>
			             </upper_lvl_ver_desc>
			             <upper_lvl_ver_desc> 
			                  <Name>state_code</Name>
			                  <Description>pkListValue</Description>
			                  <Value>CA1</Value>
			             </upper_lvl_ver_desc>
			        </attributes>
                     <HRCHY_DTL_DESC>LAS VEGAS-RANCHO</HRCHY_DTL_DESC>
       		 </TO_HIERARCHY>
                 <TO_HIERARCHY>
       		     <HRCHY_LEVEL1>04</HRCHY_LEVEL1> 
        	     <HRCHY_LEVEL2>03</HRCHY_LEVEL2> 
        	     <HRCHY_LEVEL3>99</HRCHY_LEVEL3>
        	     <HRCHY_LEVEL4>784987</HRCHY_LEVEL4>
		     <HRCHY_DTL_EFF_DATE>01-MAY-2014</HRCHY_DTL_EFF_DATE>
		     <HRCHY_DTL_EXP_DATE>01-MAY-2015</HRCHY_DTL_EXP_DATE>
			        <attributes>
			             <upper_lvl_ver_desc> 
			                  <Name>statement_type</Name>
			                  <Description>pkListValue</Description>
			                  <Value>US2</Value>
			             </upper_lvl_ver_desc>
			             <upper_lvl_ver_desc> 
			                  <Name>ManagerName</Name>
			                  <Description>CC Mgr Name</Description>
			                  <Value>Some Name2</Value>
			             </upper_lvl_ver_desc>
			             <upper_lvl_ver_desc> 
			                  <Name>state_code</Name>
			                  <Description>pkListValue</Description>
			                  <Value>CA2</Value>
			             </upper_lvl_ver_desc>
			        </attributes>
                     <HRCHY_DTL_DESC>WEST PACIFIC NW PF REP</HRCHY_DTL_DESC>
        	 </TO_HIERARCHY>
                 <TO_HIERARCHY>
       		     <HRCHY_LEVEL1>04</HRCHY_LEVEL1> 
        	     <HRCHY_LEVEL2>04</HRCHY_LEVEL2> 
        	     <HRCHY_LEVEL3>05</HRCHY_LEVEL3>
        	     <HRCHY_LEVEL4>786892</HRCHY_LEVEL4>
		     <HRCHY_DTL_EFF_DATE>01-JUN-2014</HRCHY_DTL_EFF_DATE>
		     <HRCHY_DTL_EXP_DATE>01-JUN-2015</HRCHY_DTL_EXP_DATE>
			        <attributes>
			             <upper_lvl_ver_desc> 
			                  <Name>statement_type</Name>
			                  <Description>pkListValue</Description>
			                  <Value>US3</Value>
			             </upper_lvl_ver_desc>
			             <upper_lvl_ver_desc> 
			                  <Name>ManagerName</Name>
			                  <Description>CC Mgr Name</Description>
			                  <Value>Some Name3</Value>
			             </upper_lvl_ver_desc>
			             <upper_lvl_ver_desc> 
			                  <Name>state_code</Name>
			                  <Description>pkListValue</Description>
			                  <Value>CA3</Value>
			             </upper_lvl_ver_desc>
			        </attributes>
                     <HRCHY_DTL_DESC>02/11 WEST PF REP</HRCHY_DTL_DESC>
        	 </TO_HIERARCHY>
	</TRANSFER_TO>

  </row_data>
</HIERARCHY_DETAIL>
**************************************************************
<HIERARCHY_DETAIL>
  <row_data>
      <HRCHY_HDR_NAME>DAD STRUCTURE</HRCHY_HDR_NAME> 
      <HRCHY_DTL_LEVEL>4</HRCHY_DTL_LEVEL> 
      <HRCHY_LEVEL1>05</HRCHY_LEVEL1> 
      <HRCHY_LEVEL2>04</HRCHY_LEVEL2> 
      <HRCHY_LEVEL3>86</HRCHY_LEVEL3>
      <HRCHY_LEVEL4>785900</HRCHY_LEVEL4>
      <HRCHY_DTL_DESC>PF WEST REGION</HRCHY_DTL_DESC>
      <HRCHY_DTL_EFF_DATE>01-JAN-2013</HRCHY_DTL_EFF_DATE>
      <HRCHY_DTL_EXP_DATE>01-JAN-9999</HRCHY_DTL_EXP_DATE>
      <UPPER_LVL_VER_VALUE>01</UPPER_LVL_VER_VALUE>
  </row_data>
</HIERARCHY_DETAIL>


      IN_FLAG          'TO' or  'FROM' or  'INSERT'
      IN_COUNT         This corresponds to particular "TO" XML Portion
      IN_LAST_LEVEL    This is a flag to tell if this is the last level composite key generation or not
Created : 08/02/2013  CCN Project
************************************************************/
            IN_FLAG                  IN     VARCHAR2,
            IN_XML                   IN     VARCHAR2,
            IN_HRCHY_HDR_NAME        IN     VARCHAR2,
            IN_HRCHY_DTL_LEVEL       in     varchar2,
            IN_COUNT                 IN     NUMBER,
            IN_LAST_LEVEL            IN     VARCHAR2,
            OUT_HIERARCHY_DETAIL_ROW OUT HIERARCHY_DETAIL%ROWTYPE);

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

PROCEDURE DELETE_PROCESS(
/***********************************************************
      DELETE_PROCESS 
      This Procedure will perform the following checks
      and then calls the wrapper for UPDATE or DELETE
      based on the in_flag
     
      a) if CURRENT_LVL_EXISTS
      b) delete the record
      c) get the Previous level record
      d) get the count to see if it is the last record or has more children
      d) if it is the last level, UPDATE  else DELETE
Created : 08/02/2013 CCN Project
************************************************************/
IN_HIST_FLAG            IN VARCHAR2,
IN_HIERARCHY_DETAIL_ROW IN HIERARCHY_DETAIL%ROWTYPE);

PROCEDURE INSERT_PROCESS(
/***********************************************************
      INSERT_PROCESS 
      This Procedure will perform the core insert process that involves below steps
      If the passed flag is TO/INSERT : Inserts records into HIERARCHY_DETAIL table recursively
      --Step 1 : Insert TO Hierarchy details into the Detail Table, recursively
      --Step 1.1 : Update/Insert the previous level record's next level value with current level value
      If the passed flag is FROM : Inserts records into HIERARCHY_DETAIL_HST table recursively
      Also Deletes records from HIERARCHY_DETAIL table
      --Step 1 : Insert FROM Hierarchy details into the History Table, recursively
      --Step 2 : Delete FROM Hierarchy details from Detail Table
      --Step 2.1 : Update/Delete the previous level record's
      
Created : 08/02/2013 CCN Project
************************************************************/
                         IN_FLAG                 IN VARCHAR2,
                         IN_HIST_FLAG            IN VARCHAR2,
                         IN_XML                  IN VARCHAR2,
                         IN_HRCHY_HDR_NAME       IN VARCHAR2,
                         IN_HRCHY_DTL_LEVEL      IN VARCHAR2,
                         IN_COUNT                IN NUMBER,
                         IN_LAST_LEVEL           IN VARCHAR2);

PROCEDURE HIERARCHY_TRANSFER_PROCESS(
/***********************************************************
      HIERARCHY_TRANSFER_PROCESS 
      This Procedure will perform the core transfer process that involves below steps
      --Step 1 : Insert TO Hierarchy details into the Detail Table, recursively
      --Step 1.1 : Update/Insert the previous level record's next level value with current level value
      --Step 2 : Insert FROM Hierarchy details into the History Table, recursively
      --Step 3 : Delete FROM Hierarchy details from Detail Table
      --Step 3.1 : Update/Delete the previous level record's
      
Created : 08/02/2013 CCN Project
************************************************************/
IN_XML IN VARCHAR2);

PROCEDURE HIERARCHY_DETAIL_INSERT(
/**********************************************************
	HIERARCHY_DETAIL_INSERT

      This Procedure will perform the core transfer process that involves below steps
      --Step 1 : Insert XML Hierarchy details into the Detail Table, recursively
      --Step 1.1 : Update/Insert the previous level record's next level value with current level value
        
<HIERARCHY_DETAIL>
  <row_data>
      <HRCHY_HDR_NAME>DAD Structure</HRCHY_HDR_NAME> 
      <HRCHY_DTL_LEVEL>3</HRCHY_DTL_LEVEL> 
      <HRCHY_LEVEL1>01</HRCHY_LEVEL1> 
      <HRCHY_LEVEL2>02</HRCHY_LEVEL2> 
      <HRCHY_LEVEL3>10</HRCHY_LEVEL3>
      <HRCHY_DTL_DESC>Ohio</HRCHY_DTL_DESC>
      <HRCHY_DTL_EFF_DATE>01-10-2013</HRCHY_DTL_EFF_DATE>
      <HRCHY_DTL_EXP_DATE/>
      <attributes>
         <upper_lvl_ver_desc>
         <Name>statement_type</Name> 
         <Description>pkListValue</Description> 
         <Value>US</Value> 
         </upper_lvl_ver_desc>
      </attributes>
  </row_data>
</HIERARCHY_DETAIL>

created : 02/13/2013 SH CCN Project....
**********************************************************/
    IN_XML                VARCHAR2);

PROCEDURE HIERARCHY_HDR_PICKLIST(	
/**********************************************************
	HIERARCHY_HDR_DESC_PICKLIST

	This procedure will return the data in ref cursor
        from HIERARCHY_HEADER and HIERARCHY_DESCRIPTION
        

created : 04/25/2013 kdp CCN Project....
**********************************************************/
  OUT_HIERARCHY_REF_CUR OUT REF_CURSOR
  );

END CCN_HIERARCHY;
/

