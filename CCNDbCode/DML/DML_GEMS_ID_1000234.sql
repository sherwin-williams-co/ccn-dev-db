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

-- Update given GEMS_ID and ManagerName
UPDATE HIERARCHY_DETAIL
       SET UPPER_LVL_VER_VALUE = XMLTYPE(REPLACE(EXTRACT(UPPER_LVL_VER_VALUE, '/attributes'),
                                                 '</attributes>', 
                                                 '<upper_lvl_ver_desc><Name>GEMS_ID</Name><Value>1000234</Value></upper_lvl_ver_desc>'||
                                                 '<upper_lvl_ver_desc><Name>ManagerName</Name><Value>John J Miller</Value></upper_lvl_ver_desc>'
                                                 ||'</attributes>'))
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
 WHERE DOMAIN             = '01'
   AND "GROUP"            = '01'
   AND DIVISION           = '08'
   AND DISTRICT           = '05'
   AND AREA               = '02'
   AND CITY_SALES_MANAGER = 'BB';