create or replace 
TRIGGER "COSTCNTR"."TR_HIER_DETAIL_UPD" 
BEFORE INSERT OR UPDATE ON HIERARCHY_DETAIL
REFERENCING NEW AS NEW OLD AS OLD
FOR EACH ROW

DECLARE

  V_TRANSACTION_ID VARCHAR2(500);
  V_KEY            VARCHAR2(500);
  V_ROWDATA        SYS.XMLTYPE;
  V_PRIMARYKEY     SYS.XMLTYPE;
  V_HI_DET_ROW     HIERARCHY_DETAIL%ROWTYPE; 
  V_STATEMENT_TYPE VARCHAR2(100);
  V_EMPLOYEE_NAME  VARCHAR2(100);
  V_COUNT          NUMBER  := 1;

BEGIN

V_HI_DET_ROW.HRCHY_HDR_NAME             := :NEW.HRCHY_HDR_NAME;
V_HI_DET_ROW.HRCHY_DTL_LEVEL            := :NEW.HRCHY_DTL_LEVEL;
V_HI_DET_ROW.HRCHY_DTL_PREV_LVL_VAL     := :NEW.HRCHY_DTL_PREV_LVL_VAL;
V_HI_DET_ROW.HRCHY_DTL_CURR_LVL_VAL     := :NEW.HRCHY_DTL_CURR_LVL_VAL;
V_HI_DET_ROW.HRCHY_DTL_NEXT_LVL_VAL     := :NEW.HRCHY_DTL_NEXT_LVL_VAL;
V_HI_DET_ROW.HRCHY_DTL_EFF_DATE         := :NEW.HRCHY_DTL_EFF_DATE;
V_HI_DET_ROW.HRCHY_DTL_EXP_DATE         := :NEW.HRCHY_DTL_EXP_DATE;
V_HI_DET_ROW.HRCHY_DTL_DESC             := :NEW.HRCHY_DTL_DESC;
V_HI_DET_ROW.HRCHY_DTL_CURR_ROW_VAL     := :NEW.HRCHY_DTL_CURR_ROW_VAL;

-- Check if the Attributes XML is present or not
IF :NEW.UPPER_LVL_VER_VALUE IS NOT NULL THEN
   
   -- Loop through the attributes
   WHILE :NEW.UPPER_LVL_VER_VALUE.EXISTSNODE('/attributes/upper_lvl_ver_desc' || '[' || V_COUNT || ']') = 1 LOOP
      
      -- If attribute is of 'Statement Type'/'statement_type' then populates its value
      IF :NEW.UPPER_LVL_VER_VALUE.EXTRACT('/attributes/upper_lvl_ver_desc' ||'[' || V_COUNT || ']'|| '/Name/text()').GETSTRINGVAL() IN ('Statement Type', 'statement_type') THEN
         -- Due to some reason if the Value is not present for 'Statement Type'/'statement_type' then populate with '**' [Error should never be thrown here]
         IF :NEW.UPPER_LVL_VER_VALUE.EXISTSNODE('/attributes/upper_lvl_ver_desc' ||'[' || V_COUNT || ']'|| '/Value') = 1 THEN
            V_STATEMENT_TYPE   := :NEW.UPPER_LVL_VER_VALUE.EXTRACT('/attributes/upper_lvl_ver_desc' ||'[' || V_COUNT || ']'|| '/Value/text()').GETSTRINGVAL();
         ELSE
            V_STATEMENT_TYPE   := '**';
         END IF;
      END IF;
      
      -- If attribute is of 'ManagerName'/'Manager ID' then populates its value
      IF :NEW.UPPER_LVL_VER_VALUE.EXTRACT('/attributes/upper_lvl_ver_desc' ||'[' || V_COUNT || ']'|| '/Name/text()').GETSTRINGVAL() IN ('ManagerName','Manager ID') THEN
         -- Due to some reason if the Value is not present for 'ManagerName'/'Manager ID' then don't populate it
         -- as we don't have default value for manager name [Error should never be thrown here]
         IF :NEW.UPPER_LVL_VER_VALUE.EXISTSNODE('/attributes/upper_lvl_ver_desc' ||'[' || V_COUNT || ']'|| '/Value') = 1 THEN
            V_EMPLOYEE_NAME   := :NEW.UPPER_LVL_VER_VALUE.EXTRACT('/attributes/upper_lvl_ver_desc' ||'[' || V_COUNT || ']'|| '/Value/text()').GETSTRINGVAL();
         END IF;
      END IF;
      
      V_COUNT := V_COUNT + 1;
   
   END LOOP;

END IF;

SELECT XMLELEMENT("HIERARCHY_DETAIL",
                  XMLATTRIBUTES('http://www.w3.org/2001/XMLSchema'   AS "xmlns:xsi",
                                'http://www.oracle.com/Employee.xsd' AS "xsi:nonamespaceSchemaLocation" ),
                  XMLFOREST(V_HI_DET_ROW.HRCHY_HDR_NAME                                                               HRCHY_HDR_NAME
                            ,SUBSTR('00', 1,2 - LENGTH(V_HI_DET_ROW.HRCHY_DTL_LEVEL)) || V_HI_DET_ROW.HRCHY_DTL_LEVEL HRCHY_DTL_LEVEL
                            ,V_HI_DET_ROW.HRCHY_DTL_PREV_LVL_VAL                                                      HRCHY_DTL_PREV_LVL_VAL
                            ,V_HI_DET_ROW.HRCHY_DTL_CURR_LVL_VAL                                                      HRCHY_DTL_CURR_LVL_VAL
                            ,V_HI_DET_ROW.HRCHY_DTL_NEXT_LVL_VAL                                                      HRCHY_DTL_NEXT_LVL_VAL
                            ,TO_CHAR(V_HI_DET_ROW.HRCHY_DTL_EFF_DATE, 'yyyymmdd')                                     HRCHY_DTL_EFF_DATE
                            ,TO_CHAR(V_HI_DET_ROW.HRCHY_DTL_EXP_DATE, 'yyyymmdd')                                     HRCHY_DTL_EXP_DATE
                            ,V_HI_DET_ROW.HRCHY_DTL_CURR_ROW_VAL													  HRCHY_DTL_CURR_ROW_VAL
                            ,V_HI_DET_ROW.HRCHY_DTL_DESC                                                              HRCHY_DTL_DESC
                            ,V_STATEMENT_TYPE                                                                         STATEMENT_TYPE
                            ,V_EMPLOYEE_NAME                                                                          EMPLOYEE_NAME)
                  ) AS "result",
       XMLELEMENT("PRIMARY_KEY",
                  XMLATTRIBUTES('http://www.w3.org/2001/XMLSchema' AS "xmlns:xsi",
                                'http://www.oracle.com/Employee.xsd' AS "xsi:nonamespaceSchemaLocation" ),
                  XMLFOREST(V_HI_DET_ROW.HRCHY_HDR_NAME                                                               HRCHY_HDR_NAME
                            ,SUBSTR('00', 1,2 - LENGTH(V_HI_DET_ROW.HRCHY_DTL_LEVEL)) || V_HI_DET_ROW.HRCHY_DTL_LEVEL HRCHY_DTL_LEVEL
                            ,V_HI_DET_ROW.HRCHY_DTL_PREV_LVL_VAL                                                      HRCHY_DTL_PREV_LVL_VAL
                            ,V_HI_DET_ROW.HRCHY_DTL_CURR_LVL_VAL                                                      HRCHY_DTL_CURR_LVL_VAL
                            ,V_HI_DET_ROW.HRCHY_DTL_NEXT_LVL_VAL                                                      HRCHY_DTL_NEXT_LVL_VAL
                            ,V_HI_DET_ROW.HRCHY_DTL_EFF_DATE                                                          HRCHY_DTL_EFF_DATE)
                  ) AS "PrimaryKey"
  INTO v_rowdata, v_primaryKey
  FROM DUAL;	

     V_KEY := V_HI_DET_ROW.HRCHY_HDR_NAME         || '|' ||
              V_HI_DET_ROW.HRCHY_DTL_LEVEL        || '|' ||
              V_HI_DET_ROW.HRCHY_DTL_PREV_LVL_VAL || '|' ||
              V_HI_DET_ROW.HRCHY_DTL_CURR_LVL_VAL || '|' ||
              V_HI_DET_ROW.HRCHY_DTL_NEXT_LVL_VAL || '|' ||
              V_HI_DET_ROW.HRCHY_DTL_EFF_DATE;

INSERT
  INTO AUDIT_LOG(LOG_ID,
                 TRANSACTION_ID,
                 TRANSACTION_DATE,
                 TABLE_NAME,
                 TABLE_PK_VALUE,
                 TABLE_ROW_DATA,
                 CHANGE_BY)
 VALUES ((SELECT NVL(MAX(LOG_ID), 0) + 1 FROM AUDIT_LOG),
          V_KEY,
          SYSDATE,
          'HIERARCHY_DETAIL',
          V_PRIMARYKEY,
          V_ROWDATA,
          'TR_HIER_DETAIL_UPD');

END TR_HIER_DETAIL_UPD;