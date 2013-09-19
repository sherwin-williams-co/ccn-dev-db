PACKAGE TEST_INSERT_TRANSFER AS

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

END TEST_INSERT_TRANSFER;
/

