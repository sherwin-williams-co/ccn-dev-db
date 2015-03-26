
-- insert into Hierarchy_detail table  to fix the city/sales manager level  for the cost center where detail level is 37 in global hierarchy.  
SET DEFINE OFF;  
Insert into HIERARCHY_DETAIL
(HRCHY_HDR_NAME,HRCHY_DTL_LEVEL,HRCHY_DTL_PREV_LVL_VAL,HRCHY_DTL_CURR_LVL_VAL,HRCHY_DTL_NEXT_LVL_VAL,HRCHY_DTL_EFF_DATE,HRCHY_DTL_DESC,HRCHY_DTL_CURR_ROW_VAL,UPPER_LVL_VER_VALUE)
values
('GLOBAL_HIERARCHY','5','01010904','0101090437','010109043701','18-JUN-13','* OPEN CITY MANAGER ASSIGNMENT *','37','<attributes><upper_lvl_ver_desc><Name>Statement Type</Name><Description>Picklist Value</Description><Value>AU</Value></upper_lvl_ver_desc></attributes>');

-- 1 row inserted
COMMIT;

