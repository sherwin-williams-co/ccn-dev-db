/****************************
Created : nxk927 09/21/2016 
          updating the TERRITORY HOME COST CENTER FOR COST CENTER 75Q926  TO 702835 in TERRITORY table
          and updating the statement type to have BB and country code to BRB



*******************************/

BEGIN
    CCN_BATCH_PKG.LOCK_DATABASE_SP();
END;
/
----UPDATING THE TERRITORY HOME_STORE
SELECT * FROM TERRITORY WHERE COST_CENTER_CODE = '75Q926';

UPDATE TERRITORY SET HOME_STORE = '702835' WHERE COST_CENTER_CODE ='75Q926';

SELECT * FROM COST_CENTER WHERE COST_CENTER_CODE = '75Q926';
UPDATE COST_CENTER 
   SET STATEMENT_TYPE = 'BB',
       COUNTRY_CODE = 'BRB',
       CURRENCY_CODE = 'BBD'
 WHERE COST_CENTER_CODE ='75Q926';

SELECT * FROM HIERARCHY_DETAIL WHERE HRCHY_DTL_CURR_ROW_VAL = '75Q926' AND HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY';
UPDATE HIERARCHY_DETAIL
   SET UPPER_LVL_VER_VALUE ='<attributes>
  <upper_lvl_ver_desc>
    <Name>GEMS_ID</Name>
    <Description>Picklist Value</Description>
    <Value/>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>Statement Type</Name>
    <Description>Picklist Value</Description>
    <Value>BB</Value>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>ManagerName</Name>
    <Description>Picklist Value</Description>
    <Value/>
  </upper_lvl_ver_desc>
</attributes>'
where HRCHY_DTL_CURR_ROW_VAL = '75Q926' 
  AND HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY';

SELECT * FROM HIERARCHY_DETAIL WHERE HRCHY_DTL_CURR_ROW_VAL = '75Q926' AND HRCHY_HDR_NAME = 'LEGACY_GL_DIVISION';
UPDATE HIERARCHY_DETAIL
   SET UPPER_LVL_VER_VALUE ='<attributes>
  <upper_lvl_ver_desc>
    <Name>Statement Type</Name>
    <Description>Picklist Value</Description>
    <Value>BB</Value>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>ManagerName</Name>
    <Description>Picklist Value</Description>
    <Value/>
  </upper_lvl_ver_desc>
</attributes>'
where HRCHY_DTL_CURR_ROW_VAL = '75Q926' 
  AND HRCHY_HDR_NAME = 'LEGACY_GL_DIVISION';
  
SELECT * FROM HIERARCHY_DETAIL WHERE HRCHY_DTL_CURR_ROW_VAL = '75Q926' AND HRCHY_HDR_NAME = 'FACTS_DIVISION';
UPDATE HIERARCHY_DETAIL
   SET UPPER_LVL_VER_VALUE ='<attributes>
  <upper_lvl_ver_desc>
    <Name>Statement Type</Name>
    <Description>Picklist Value</Description>
    <Value>BB</Value>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>ManagerName</Name>
    <Description>Picklist Value</Description>
    <Value/>
  </upper_lvl_ver_desc>
</attributes>'
where HRCHY_DTL_CURR_ROW_VAL = '75Q926' 
  AND HRCHY_HDR_NAME = 'FACTS_DIVISION';
  
COMMIT;
BEGIN
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP();
END;
/