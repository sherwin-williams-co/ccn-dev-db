---FIXING HRCHY_DTL_NEXT_LVL_VAL for 8th level for GLOBAL_HIERARCHY
--nxk927 CCN Project....
/********************************************
SELECT * FROM HIERARCHY_DETAIL 
where HRCHY_DTL_CURR_LVL_VAL IN 
('0101050282AA010178Q790','0101050282AA0101786124','0101050282AA0101786463',
'0101050282AA0101786788','0101050282AA0101784475','0101050282AA0101784834',
'0101050282AA0101784851','0101050282AA0101784973','0101050282AA0101786195');

   
SELECT * FROM HIERARCHY_DETAIL WHERE HRCHY_DTL_CURR_LVL_VAL ='0101050282AA0101';

********************************************/
BEGIN
    CCN_BATCH_PKG.LOCK_DATABASE_SP();
END;
/
SET DEFINE OFF;  
--Updating Hierarchy_detail table  to fix the HRCHY_DTL_NEXT_LVL_VAL  for the cost center 78Q790 
UPDATE HIERARCHY_DETAIL
  SET HRCHY_DTL_NEXT_LVL_VAL = '0101050282AA010178Q790'
 WHERE HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY'
   AND HRCHY_DTL_LEVEL = '8'
   AND HRCHY_DTL_PREV_LVL_VAL = '0101050282AA01' 
   AND HRCHY_DTL_CURR_LVL_VAL = '0101050282AA0101'
   AND HRCHY_DTL_NEXT_LVL_VAL = '~~~'
   and HRCHY_DTL_EFF_DATE = '11-FEB-2016'
   and HRCHY_DTL_CURR_ROW_VAL = '01';

-- insert into Hierarchy_detail table  to fix the HRCHY_DTL_NEXT_LVL_VAL  for the cost centers 
-- 786124,786463,786788,784475,784834,784851,784973,786195
-- where HRCHY_DTL_NEXT_LVL_VAL is '~~~' in global hierarchy.   
INSERT INTO HIERARCHY_DETAIL VALUES
('GLOBAL_HIERARCHY','8','0101050282AA01','0101050282AA0101','0101050282AA0101786124','11-FEB-2016',NULL,'*OPEN SPECIAL ROLL ASSIGNMENT*','01','<attributes>
  <upper_lvl_ver_desc>
    <Name>Statement Type</Name>
    <Description>pkListValue</Description>
    <Value>**</Value>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>ManagerName</Name>
    <Description>pkListValue</Description>
    <Value/>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>GEMS_ID</Name>
    <Description>pkListValue</Description>
    <Value/>
  </upper_lvl_ver_desc>
</attributes>');  

INSERT INTO HIERARCHY_DETAIL VALUES
('GLOBAL_HIERARCHY','8','0101050282AA01','0101050282AA0101','0101050282AA0101786463','11-FEB-2016',NULL,'*OPEN SPECIAL ROLL ASSIGNMENT*','01','<attributes>
  <upper_lvl_ver_desc>
    <Name>Statement Type</Name>
    <Description>pkListValue</Description>
    <Value>**</Value>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>ManagerName</Name>
    <Description>pkListValue</Description>
    <Value/>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>GEMS_ID</Name>
    <Description>pkListValue</Description>
    <Value/>
  </upper_lvl_ver_desc>
</attributes>');

INSERT INTO HIERARCHY_DETAIL VALUES
('GLOBAL_HIERARCHY','8','0101050282AA01','0101050282AA0101','0101050282AA0101786788','11-FEB-2016',NULL,'*OPEN SPECIAL ROLL ASSIGNMENT*','01','<attributes>
  <upper_lvl_ver_desc>
    <Name>Statement Type</Name>
    <Description>pkListValue</Description>
    <Value>**</Value>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>ManagerName</Name>
    <Description>pkListValue</Description>
    <Value/>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>GEMS_ID</Name>
    <Description>pkListValue</Description>
    <Value/>
  </upper_lvl_ver_desc>
</attributes>');

INSERT INTO HIERARCHY_DETAIL VALUES
('GLOBAL_HIERARCHY','8','0101050282AA01','0101050282AA0101','0101050282AA0101784475','11-FEB-2016',NULL,'*OPEN SPECIAL ROLL ASSIGNMENT*','01','<attributes>
  <upper_lvl_ver_desc>
    <Name>Statement Type</Name>
    <Description>pkListValue</Description>
    <Value>**</Value>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>ManagerName</Name>
    <Description>pkListValue</Description>
    <Value/>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>GEMS_ID</Name>
    <Description>pkListValue</Description>
    <Value/>
  </upper_lvl_ver_desc>
</attributes>');

INSERT INTO HIERARCHY_DETAIL VALUES
('GLOBAL_HIERARCHY','8','0101050282AA01','0101050282AA0101','0101050282AA0101784834','11-FEB-2016',NULL,'*OPEN SPECIAL ROLL ASSIGNMENT*','01','<attributes>
  <upper_lvl_ver_desc>
    <Name>Statement Type</Name>
    <Description>pkListValue</Description>
    <Value>**</Value>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>ManagerName</Name>
    <Description>pkListValue</Description>
    <Value/>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>GEMS_ID</Name>
    <Description>pkListValue</Description>
    <Value/>
  </upper_lvl_ver_desc>
</attributes>');

INSERT INTO HIERARCHY_DETAIL VALUES
('GLOBAL_HIERARCHY','8','0101050282AA01','0101050282AA0101','0101050282AA0101784851','11-FEB-2016',NULL,'*OPEN SPECIAL ROLL ASSIGNMENT*','01','<attributes>
  <upper_lvl_ver_desc>
    <Name>Statement Type</Name>
    <Description>pkListValue</Description>
    <Value>**</Value>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>ManagerName</Name>
    <Description>pkListValue</Description>
    <Value/>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>GEMS_ID</Name>
    <Description>pkListValue</Description>
    <Value/>
  </upper_lvl_ver_desc>
</attributes>');

INSERT INTO HIERARCHY_DETAIL VALUES
('GLOBAL_HIERARCHY','8','0101050282AA01','0101050282AA0101','0101050282AA0101784973','11-FEB-2016',NULL,'*OPEN SPECIAL ROLL ASSIGNMENT*','01','<attributes>
  <upper_lvl_ver_desc>
    <Name>Statement Type</Name>
    <Description>pkListValue</Description>
    <Value>**</Value>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>ManagerName</Name>
    <Description>pkListValue</Description>
    <Value/>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>GEMS_ID</Name>
    <Description>pkListValue</Description>
    <Value/>
  </upper_lvl_ver_desc>
</attributes>');


INSERT INTO HIERARCHY_DETAIL VALUES
('GLOBAL_HIERARCHY','8','0101050282AA01','0101050282AA0101','0101050282AA0101786195','11-FEB-2016',NULL,'*OPEN SPECIAL ROLL ASSIGNMENT*','01','<attributes>
  <upper_lvl_ver_desc>
    <Name>Statement Type</Name>
    <Description>pkListValue</Description>
    <Value>**</Value>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>ManagerName</Name>
    <Description>pkListValue</Description>
    <Value/>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>GEMS_ID</Name>
    <Description>pkListValue</Description>
    <Value/>
  </upper_lvl_ver_desc>
</attributes>');

COMMIT;

BEGIN
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP();
END;
/

