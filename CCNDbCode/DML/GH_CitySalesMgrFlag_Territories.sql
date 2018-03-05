/*
This script will 
1) adds new pick list "CITY/SLS MGR FLAG" wil possible values as 
    C - CITY MANAGER
    D - SELLING DISTRICT
    S - TERRITORY SALES MANAGER
2) add new attribute to city sales manager level of global hierarchy (Prod data different from lower environments)
3) Insert this new attribute into audit log to consider this flag
4) Updates the Territory (alpha numeric city/sales manager level) with "S"


Created  : 3/5/2018 jxc517 CCN Project Team....
Changed : 
*/
SET DEFINE OFF;
Insert into CODE_HEADER (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_HEADER_DESCRIPTION,CODE_HEADER_EXPIRE_FLAG,CODE_HEADER_EXPIRE_USER,CODE_HEADER_EXPIRE_EFF_DATE,CODE_HEADER_DTL_VAL_SIZE,CODE_HEADER_DTL_VAL_DEFAULT,CODE_HEADER_CREATE_USER,CODE_HEADER_EFF_DATE,CODE_HEADER_IDENTIFIER) values ('CITY/SLS MGR FLAG','COD','FLAG TO DENOTE IF LEVEL IS FOR CITY OR SLS MGR','N',null,null,1,null,'pmm4br',null,
'<ROLES>
   <ROLE>
      <VALUE>HWU</VALUE>
   </ROLE>
</ROLES>');

Insert into CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('CITY/SLS MGR FLAG','COD','C','CITY MANAGER','N',null,null,2,null,null);
Insert into CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('CITY/SLS MGR FLAG','COD','D','SELLING DISTRICT','N',null,null,2,null,null);
Insert into CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('CITY/SLS MGR FLAG','COD','S','TERRITORY SALES MANAGER','N',null,null,1,null,null);

--Dev to QA
UPDATE HIERARCHY_DESCRIPTION 
   SET UPPER_LVL_VER_VALUE = 
'<attributes>
  <upper_lvl_ver_desc>
    <Name>Statement Type</Name>
    <Description>pkListValue</Description>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>ManagerName</Name>
    <Description>pkListValue</Description>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>GEMS_ID</Name>
    <Description>pkListValue</Description>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>ENTITY_TYPE</Name>
    <Description>pkListValue</Description>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>CITY/SLS MGR FLAG</Name>
    <Description>pkListValue</Description>
    <ATTRIBUTE_VALUE_SIZE>1</ATTRIBUTE_VALUE_SIZE>
  </upper_lvl_ver_desc>
</attributes>'
WHERE HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY' AND HRCHY_HDR_LVL_NBR = 6;

--Prod : run below query to make sure nothing for updated by users from UI
SELECT * FROM HIERARCHY_DESCRIPTION WHERE HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY' AND HRCHY_HDR_LVL_NBR = 6;

UPDATE HIERARCHY_DESCRIPTION 
   SET UPPER_LVL_VER_VALUE = 
'<attributes>
  <upper_lvl_ver_desc>
    <Name>GEMS_ID</Name>
    <Description>pkListValue</Description>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>ManagerName</Name>
    <Description>pkListValue</Description>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>Statement Type</Name>
    <Description>pkListValue</Description>
  </upper_lvl_ver_desc>
  <upper_lvl_ver_desc>
    <Name>CITY/SLS MGR FLAG</Name>
    <Description>pkListValue</Description>
    <ATTRIBUTE_VALUE_SIZE>1</ATTRIBUTE_VALUE_SIZE>
  </upper_lvl_ver_desc>
</attributes>'
WHERE HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY' AND HRCHY_HDR_LVL_NBR = 6;

Insert into CCN_ADDITIONAL_AUDIT_FIELDS (TABLE_NAME,COLUMN_NAME,DATA_TYPE,DATA_LENGTH,COLUMN_ID) values ('HIERARCHY_DETAIL','CITY/SLS_MGR_FLAG','VARCHAR2',null,118);

SET SERVEROUTPUT ON;
DECLARE
    CURSOR cur IS 
        SELECT *
          FROM HIERARCHY_DETAIL
         WHERE HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY'
           AND HRCHY_DTL_LEVEL = 6
           AND REGEXP_LIKE(HRCHY_DTL_CURR_ROW_VAL,NVL('[A-Z]+$','*'))
           AND CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(UPPER_LVL_VER_VALUE, 'CITY/SLS MGR FLAG') IS NULL;
           --AND ROWNUM < 2;
BEGIN
    FOR rec IN cur LOOP
        UPDATE HIERARCHY_DETAIL
           SET UPPER_LVL_VER_VALUE = REPLACE(rec.UPPER_LVL_VER_VALUE.EXTRACT('/attributes').GETSTRINGVAL(),'</attributes>',
'   <upper_lvl_ver_desc>
      <Name>CITY/SLS MGR FLAG</Name>
      <Description>pkListValue</Description>
      <Value>S</Value>
   </upper_lvl_ver_desc>
</attributes>')
         WHERE HRCHY_HDR_NAME         = 'GLOBAL_HIERARCHY'
           AND HRCHY_DTL_LEVEL        = 6
           AND HRCHY_DTL_PREV_LVL_VAL = rec.HRCHY_DTL_PREV_LVL_VAL
           AND HRCHY_DTL_CURR_LVL_VAL = rec.HRCHY_DTL_CURR_LVL_VAL
           AND HRCHY_DTL_NEXT_LVL_VAL = rec.HRCHY_DTL_NEXT_LVL_VAL
           AND HRCHY_DTL_CURR_ROW_VAL = rec.HRCHY_DTL_CURR_ROW_VAL;
    END LOOP;

    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLCODE || '-' || SQLERRM);
END;
/