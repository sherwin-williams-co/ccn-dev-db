/*
     Created: 02/16/2018 axt754 CCN Project Team..
     DML script for inserting Gems ID 1000234 and employee name 'John J Miller'
     to GLOBAL_HIERARCHY at district level i.e., level 6 for HRCHY_DTL_CURR_LVL_VAL '0101080502BB'
*/

-- Select UPPER_LVL_VER_VALUE for GEMS_ID and ManagerName

SELECT UPPER_LVL_VER_VALUE 
  FROM HIERARCHY_DETAIL
 WHERE HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY'
       AND HRCHY_DTL_LEVEL = 6
       AND HRCHY_DTL_CURR_LVL_VAL = '0101080502BB';

-- Select the values from  GLOBAL_HIERARCHY_ATTRBT_VW and look for the GEMS_ID and ManagerName before update
SELECT *
  FROM GLOBAL_HIERARCHY_ATTRBT_VW
 WHERE COST_CENTER_CODE  = '776338';

-- Update given GEMS_ID and ManagerName
UPDATE HIERARCHY_DETAIL
       SET UPPER_LVL_VER_VALUE =
  XMLTYPE(
'<attributes>
  <upper_lvl_ver_desc>
    <Name>GEMS_ID</Name>
    <Description>pkListValue</Description>
    <Value>1000234</Value>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>ManagerName</Name>
    <Description>pkListValue</Description>
    <Value>John J Miller</Value>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>Statement Type</Name>
    <Description>pkListValue</Description>
    <Value>CN</Value>
  </upper_lvl_ver_desc>
</attributes>')
     WHERE HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY'
       AND HRCHY_DTL_LEVEL = 6
       AND HRCHY_DTL_CURR_LVL_VAL = '0101080502BB';
       
-- Select UPPER_LVL_VER_VALUE for GEMS_ID and ManagerName to see if properly updated       
SELECT UPPER_LVL_VER_VALUE
  FROM HIERARCHY_DETAIL
 WHERE HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY'
       AND HRCHY_DTL_LEVEL = 6
       AND HRCHY_DTL_CURR_LVL_VAL = '0101080502BB';


-- Commit The Transaction
COMMIT;

-- Select the values from  GLOBAL_HIERARCHY_ATTRBT_VW and look for the GEMS_ID and ManagerName is updated for everything.      
SELECT *
  FROM GLOBAL_HIERARCHY_ATTRBT_VW
 WHERE COST_CENTER_CODE  = '776338';