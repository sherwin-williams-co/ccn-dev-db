/*
Below script will correct global hierarchy City/Sales manager level manager names

Created : 10/02/2019 jxc517 CCN Project Team....
Changed :
*/
/*
SELECT * FROM HIERARCHY_DETAIL;
        SELECT DISTINCT HRCHY_DTL_CURR_LVL_VAL,
                        HRCHY_DTL_DESC,
                        CITY_MGR_NAME,
                        CITY_MGR_GEMS_ID,
                        (SELECT EMPLOYEE_NAME FROM EMPLOYEE_DETAILS WHERE EMPLOYEE_NUMBER = CITY_MGR_GEMS_ID) GEMS_NAME
          FROM (SELECT A.*,
                       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.UPPER_LVL_VER_VALUE, 'ManagerName') CITY_MGR_NAME,
                       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.UPPER_LVL_VER_VALUE, 'GEMS_ID') CITY_MGR_GEMS_ID
                  FROM HIERARCHY_DETAIL A
                 WHERE HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY'
                   AND HRCHY_DTL_LEVEL = '6')
         WHERE CITY_MGR_NAME = UPPER(CITY_MGR_NAME);

SELECT * FROM HIERARCHY_DETAIL;
        SELECT DISTINCT HRCHY_DTL_CURR_LVL_VAL,
                        HRCHY_DTL_DESC,
                        CITY_MGR_NAME,
                        CITY_MGR_GEMS_ID,
                        (SELECT EMPLOYEE_NAME FROM EMPLOYEE_DETAILS WHERE EMPLOYEE_NUMBER = CITY_MGR_GEMS_ID) GEMS_NAME
          FROM (SELECT A.*,
                       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.UPPER_LVL_VER_VALUE, 'ManagerName') CITY_MGR_NAME,
                       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.UPPER_LVL_VER_VALUE, 'GEMS_ID') CITY_MGR_GEMS_ID
                  FROM HIERARCHY_DETAIL A
                 WHERE HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY'
                   AND HRCHY_DTL_LEVEL = '6')
         WHERE CITY_MGR_NAME <> UPPER(CITY_MGR_NAME);
*/

--Data backup just in case
SELECT *
  FROM HIERARCHY_DETAIL
 WHERE HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY'
   AND HRCHY_DTL_LEVEL = '6'
   AND HRCHY_DTL_CURR_LVL_VAL IN (
        SELECT DISTINCT HRCHY_DTL_CURR_LVL_VAL
          FROM (SELECT A.*,
                       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.UPPER_LVL_VER_VALUE, 'ManagerName') CITY_MGR_NAME,
                       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.UPPER_LVL_VER_VALUE, 'GEMS_ID') CITY_MGR_GEMS_ID
                  FROM HIERARCHY_DETAIL A
                 WHERE HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY'
                   AND HRCHY_DTL_LEVEL = '6')
         WHERE CITY_MGR_NAME = UPPER(CITY_MGR_NAME)
           --AND HRCHY_DTL_CURR_LVL_VAL IN ('0101010345AA','0101010621AA','0101010316AA')                                       --Unit tested records
           AND NVL(CITY_MGR_GEMS_ID, '9999999') <> '9999999'                                                                    --Needs manual corrections by SMIS
           AND CITY_MGR_GEMS_ID  <> 'RON'                                                                                       --Needs manual corrections by SMIS
        );

SET SERVEROUTPUT ON;
DECLARE
    IN_V_UPPER_LVL_VER_VALUE HIERARCHY_DETAIL.UPPER_LVL_VER_VALUE%TYPE;
    IO_FINAL_XML             XMLTYPE;
    IN_REC_ATTR_NAME         VARCHAR2(100) := 'ManagerName';

    V_ATTRIBUTE_NAME   VARCHAR2(150);
    V_COUNT            NUMBER;
    V_ATTR_POS         NUMBER := NULL;
    V_UPDATED_REC_CNT  NUMBER := 0;

    CURSOR main_cur IS
        SELECT DISTINCT HRCHY_DTL_CURR_LVL_VAL,
                        CITY_MGR_NAME,
                        CITY_MGR_GEMS_ID,
                        (SELECT EMPLOYEE_NAME FROM EMPLOYEE_DETAILS WHERE EMPLOYEE_NUMBER = CITY_MGR_GEMS_ID) GEMS_NAME
          FROM (SELECT A.*,
                       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.UPPER_LVL_VER_VALUE, 'ManagerName') CITY_MGR_NAME,
                       CCN_HIERARCHY.GET_RQSTD_ATTRIBUTE_VALUE(A.UPPER_LVL_VER_VALUE, 'GEMS_ID') CITY_MGR_GEMS_ID
                  FROM HIERARCHY_DETAIL A
                 WHERE HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY'
                   AND HRCHY_DTL_LEVEL = '6')
         WHERE CITY_MGR_NAME = UPPER(CITY_MGR_NAME)
           --AND HRCHY_DTL_CURR_LVL_VAL IN ('0101010345AA','0101010621AA','0101010316AA') --Unit tested records
           AND NVL(CITY_MGR_GEMS_ID, '9999999') <> '9999999' --Needs manual corrections by SMIS
           AND CITY_MGR_GEMS_ID  <> 'RON' --Needs manual corrections by SMIS
        ;

BEGIN
    FOR rec IN main_cur LOOP
        IF rec.GEMS_NAME IS NOT NULL THEN                                                                                       --Needs manual corrections by SMIS
            SELECT UPPER_LVL_VER_VALUE
              INTO IN_V_UPPER_LVL_VER_VALUE
              FROM HIERARCHY_DETAIL
             WHERE HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY'
               AND HRCHY_DTL_LEVEL = '6'
               AND HRCHY_DTL_CURR_LVL_VAL = rec.HRCHY_DTL_CURR_LVL_VAL
               AND ROWNUM < 2;
            --DBMS_OUTPUT.PUT_LINE(IN_V_UPPER_LVL_VER_VALUE.EXTRACT('/attributes/upper_lvl_ver_desc').GETSTRINGVAL());
            V_COUNT          := 1;
            V_ATTRIBUTE_NAME := NULL;
            WHILE IN_V_UPPER_LVL_VER_VALUE.EXISTSNODE('//attributes/upper_lvl_ver_desc[' || V_COUNT || ']') = 1 LOOP
                IF IN_V_UPPER_LVL_VER_VALUE.EXISTSNODE('/attributes/upper_lvl_ver_desc' || '[' || V_COUNT || ']' || '/Name/text()') = 1 THEN
                    -- Extracting name from existing XML
                    V_ATTRIBUTE_NAME := UPPER(REPLACE(IN_V_UPPER_LVL_VER_VALUE.EXTRACT('/attributes/upper_lvl_ver_desc' || '[' || V_COUNT || ']/Name/text()').GETSTRINGVAL(),' ','_'));
                    -- Comparing attribute name
                    IF V_ATTRIBUTE_NAME = UPPER(REPLACE(IN_REC_ATTR_NAME,' ','_')) THEN
                        IF IN_V_UPPER_LVL_VER_VALUE.EXISTSNODE('/attributes/upper_lvl_ver_desc' || '[' || V_COUNT || ']' || '/Value/text()') <> 1 THEN
                            -- Creating new node with values while found NULL NODE in the exisitng XML
                            SELECT APPENDCHILDXML(NVL(IO_FINAL_XML, IN_V_UPPER_LVL_VER_VALUE),
                                                  'attributes/upper_lvl_ver_desc' || '[' || V_COUNT || ']/Value'
                                                  -- generates the text() node to append :
                                                  , EXTRACT(XMLELEMENT("Value", rec.GEMS_NAME),'/Value/text()'))
                              INTO IO_FINAL_XML
                              FROM dual;
                        END IF;
                        V_ATTR_POS := V_COUNT;
                        EXIT;
                   END IF;
                END IF;
                  V_COUNT := V_COUNT + 1;
            END LOOP;

            -- Building new XML
            IF V_ATTR_POS IS NOT NULL THEN
                SELECT UPDATEXML(NVL(IO_FINAL_XML, IN_V_UPPER_LVL_VER_VALUE),
                                 '/attributes/upper_lvl_ver_desc['||V_ATTR_POS||']/Value/text()',
                                 rec.GEMS_NAME)
                  INTO IO_FINAL_XML
                  FROM DUAL;
                V_ATTR_POS := NULL;
            END IF;
            
            --DBMS_OUTPUT.PUT_LINE(IO_FINAL_XML.EXTRACT('/attributes/upper_lvl_ver_desc').GETSTRINGVAL());
            UPDATE HIERARCHY_DETAIL
               SET UPPER_LVL_VER_VALUE = IO_FINAL_XML
             WHERE HRCHY_HDR_NAME = 'GLOBAL_HIERARCHY'
               AND HRCHY_DTL_LEVEL = '6'
               AND HRCHY_DTL_CURR_LVL_VAL = rec.HRCHY_DTL_CURR_LVL_VAL;
            V_UPDATED_REC_CNT := V_UPDATED_REC_CNT + SQL%ROWCOUNT;
            IO_FINAL_XML := NULL;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Rows updated : ' || V_UPDATED_REC_CNT);
END;
/

--Validate the results before commiting the changes by running the master cursor query again (should return no results)
COMMIT;
