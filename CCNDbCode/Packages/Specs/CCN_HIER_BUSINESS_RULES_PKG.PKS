CREATE OR REPLACE PACKAGE CCN_HIER_BUSINESS_RULES_PKG AS
/******************************************************************************
	CCN_HIER_BUSINESS_RULES_PKG

	This Package is intended to validate business rules for
	all the Hierarchies

created :SH 5/17/2013 

*******************************************************************************/

FUNCTION GET_HDR_LVL_NBR_SP(
/*******************************************************************************
 GET_GLOBAL_LVL_NBR_SP  
   
  This procedure will return the Level number of a HIERARCHY for the 
  corresponding Description of the level

created : SH 05/17//2013
********************************************************************************/
IN_HRCHY_HDR_NAME     IN HIERARCHY_DESCRIPTION.HRCHY_HDR_NAME%TYPE,
IN_HRCHY_HDR_LVL_DESC IN HIERARCHY_DESCRIPTION.HRCHY_HDR_LVL_DESC%TYPE
) return varchar2;

FUNCTION GET_HDR_LVL_DESC_SP(
/*******************************************************************************
 GET_HDR_LVL_NBR_SP  
   
  This procedure will return the Level description of a HIERARCHY for the 
  corresponding Dtl level

created : SH 07/03/2013
********************************************************************************/
in_HRCHY_HDR_NAME      IN HIERARCHY_DESCRIPTION.HRCHY_HDR_NAME%TYPE,
in_HRCHY_HDR_LVL_NBR   IN HIERARCHY_DESCRIPTION.HRCHY_HDR_LVL_NBR%TYPE
) RETURN VARCHAR2;

PROCEDURE Header_Lvl_Validation_sp (
/*******************************************************************************
 Hier_Business_Rules_sp  
   
  This procedure will validate the business rules for any Hierarchy    

created : MDH 10/04//2012
******************************************************************************/	
    in_row_data                VARCHAR2
 );

procedure cost_center_change_Rules(
/*******************************************************************************
 cost_center_change_Rules  
   
  This procedure will validate the business rules for any Hierarchy   
  i.e, If a Global Hierarchy is changed for a Cost Center, other hierarchies 
  such as the  Alternate D-A-D, SGL Division, or COA Division must be checked for 
  possible changes for the same cost center. This will be a Warning message to 
  check or verify other hierarchies for the same cost center

created : SH 05/30/2013

  <HIERARCHY_RULES>
      <HRCHY_HDR_NAME>GLOBAL_HIERARCHY</HRCHY_HDR_NAME> 
      <HRCHY_DTL_LEVEL>9</HRCHY_DTL_LEVEL> 
      <HRCHY_HDR_DESC>Div Area Dist Structure</HRCHY_HDR_DESC>  
      <STATEMENT_TYPE>CN</STATEMENT_TYPE>
  <HIERARCHY_RULES>
********************************************************************************/
in_HRCHY_HDR_NAME  HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE,
in_HRCHY_DTL_LEVEL HIERARCHY_DETAIL.HRCHY_DTL_LEVEL%TYPE);

procedure Stmnt_Type_Validation_Rules(
/*******************************************************************************
 Stmnt_Type_Validation_Rules  
   
  This procedure will validate the business rules for Statement Type   
  i.e, When a higher node¿s Statement_Type changes, all lower nodes will be checked 
  to make sure that they adhere to business rules. The only exception is the ¿NULL¿ 
  which allows all the lower levels and thus does not need validation

created : SH 05/31/2013

  <HIERARCHY_RULES>
      <HRCHY_HDR_NAME>GLOBAL_HIERARCHY</HRCHY_HDR_NAME> 
      <HRCHY_HDR_LVL_NBR>09</HRCHY_HDR_LVL_NBR> 
      <HRCHY_DTL_LEVEL>5</HRCHY_HDR_LVL_NBR> 
      <HRCHY_HDR_DESC>Div Area Dist Structure</HRCHY_HDR_DESC>  
      <STATEMENT_TYPE>CN</STATEMENT_TYPE>
  <HIERARCHY_RULES>
********************************************************************************/
IN_HIERARCHY_DETAIL_ROW IN HIERARCHY_DETAIL%ROWTYPE);

procedure Lower_Level_Exp_Rules(
/*******************************************************************************
 Lower_Level_Exp_Rules  
   
  This procedure will validate the business rules that before allowing the expiring 
  of any level (i.e. division or area) all lower nodes (area, district, cost center)
  must have been expired previously!

created : SH 06/04/2013

  <HIERARCHY_RULES>
      <HRCHY_HDR_NAME>GLOBAL_HIERARCHY</HRCHY_HDR_NAME> 
      <HRCHY_DTL_EXP_DATE>09</HRCHY_DTL_EXP_DATE> 
      <HRCHY_DTL_LEVEL>4</HRCHY_DTL_LEVEL> 
      <HRCHY_HDR_DESC>Div Area Dist Structure</HRCHY_HDR_DESC>  
      <STATEMENT_TYPE>CN</STATEMENT_TYPE>
  <HIERARCHY_RULES>
********************************************************************************/
in_HRCHY_HDR_NAME     hierarchy_detail.hrchy_hdr_name%TYPE, 
in_HRCHY_DTL_LEVEL    hierarchy_detail.hrchy_dtl_level%TYPE, 
in_HRCHY_DTL_EXP_DATE hierarchy_detail.hrchy_dtl_exp_date%TYPE);

procedure District_Duplication_Rules(
/*******************************************************************************
 District_Duplication_Rules  
   
  This procedure will validate the business rules for Reporting_DAD, City DAD, 
  or Alternate DAD that - duplication of a district number across all divisions 
  and Areas is not allowed

created : SH 05/31/2013

  <HIERARCHY_RULES>
      <HRCHY_HDR_NAME>REPORTING_DAD</HRCHY_HDR_NAME> 
      <HRCHY_DTL_LEVEL>3</HRCHY_DTL_LEVEL> 
      <HRCHY_HDR_DESC>Div Area Dist Structure</HRCHY_HDR_DESC>  
      <STATEMENT_TYPE>CN</STATEMENT_TYPE>
  <HIERARCHY_RULES>
********************************************************************************/
in_HRCHY_HDR_NAME          hierarchy_detail.hrchy_hdr_name%TYPE,
in_HRCHY_DTL_LEVEL         hierarchy_detail.hrchy_dtl_level%TYPE,
in_HRCHY_DTL_CURR_ROW_VAL  hierarchy_detail.hrchy_dtl_curr_row_val%TYPE);

procedure CC_Duplication_Rules(
/*******************************************************************************
 CC_Duplication_Rules  
   
  This procedure will validate the business rules for Reporting_DAD or City DAD, 
  - duplication of a Cost Center across  areas or divisions is not allowed

created : SH 06/03/2013

  <HIERARCHY_RULES>
      <HRCHY_HDR_NAME>REPORTING_DAD</HRCHY_HDR_NAME> 
      <HRCHY_DTL_LEVEL>3</HRCHY_DTL_LEVEL> 
      <HRCHY_HDR_DESC>Div Area Dist Structure</HRCHY_HDR_DESC>  
      <STATEMENT_TYPE>CN</STATEMENT_TYPE>
  <HIERARCHY_RULES>
********************************************************************************/
in_HRCHY_HDR_NAME          hierarchy_detail.hrchy_hdr_name%TYPE,
in_HRCHY_DTL_LEVEL         hierarchy_detail.hrchy_dtl_level%TYPE,
in_HRCHY_DTL_CURR_ROW_VAL  hierarchy_detail.hrchy_dtl_curr_row_val%TYPE);

procedure DUPLICATE_COST_CENTER(
/*******************************************************************************
 DUPLICATE_COST_CENTER  
   
  This procedure will validate the business rules same Hierarchy, 
  where duplication of a Cost Center in the same hierarchy is not allowed

created : SH 06/27/2013
*********************************************************************************/
in_HRCHY_HDR_NAME             HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE,
in_HRCHY_DTL_LEVEL            HIERARCHY_DETAIL.HRCHY_DTL_LEVEL%TYPE, 
in_HRCHY_DTL_CURR_ROW_VAL     HIERARCHY_DETAIL.HRCHY_DTL_CURR_ROW_VAL%TYPE);

FUNCTION VALIDATE_HIERARCHY(
/*******************************************************************************
 VALIDATE_HIERARCHY  
   
  This procedure will validate the hierarchy from bottom to top and raise 
  corresponding error if particular level value doesn't exist

created : JXC517 11/14/2013
********************************************************************************/
    IN_HRCHY_HDR_NAME         VARCHAR2,
    IN_HRCHY_DTL_CURR_LVL_VAL VARCHAR2) RETURN VARCHAR;

PROCEDURE HIER_BUSINESS_RULES_MAIN(
/*******************************************************************************
 HIER_BUSINESS_RULES_MAIN  
  
  This procedure is intended to be the "main" Business Rules procedure.  This
  routine will be excuted both by Batch and our UI Screens.
  
  Its purposes is to execute each of the individual Business Rules as defined
  in the Technical Document

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
 
created : 06/27/2013 SH CCN
********************************************************************************/
IN_HIERARCHY_DETAIL_ROW IN HIERARCHY_DETAIL%ROWTYPE);
END CCN_HIER_BUSINESS_RULES_PKG;

