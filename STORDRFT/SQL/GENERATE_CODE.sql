CREATE OR REPLACE PROCEDURE STORDRFT.GENERATE_CODE(
/*******************************************************************************
	GENERATE_CODE

	This procedure will generate the procedures that needs to be compiled in SD_TABLE_IU_PKG
  for any new table that got added

Created : 05/01/2014 jxc517 CCN Project....
Changed : 
*******************************************************************************/
IN_TABLE_NAME  IN VARCHAR2,
IN_USER        IN VARCHAR2,
IN_PARAMETER   IN VARCHAR2)
IS
--##############################rowtype
    V_ROWTYPE_STRING        CLOB;
    V_STATIC_ROWTYPE_HEADER CLOB := 
'PROCEDURE '||IN_TABLE_NAME||'_ROWTYPE_SP ('||CHR(10)||
'/*******************************************************************************'||CHR(10)||
'	'||IN_TABLE_NAME||'_ROWTYPE_SP'||CHR(10)||CHR(10)||
'	This procedure is intended to build the '||IN_TABLE_NAME||' record type'||CHR(10)||CHR(10)||
'Created : '||TO_CHAR(SYSDATE,'MM/DD/RRRR')||' '||IN_USER||' CCN Project....'||CHR(10)||
'Changed : '||CHR(10)||
'*******************************************************************************/'||CHR(10)||
'IN_TABLE_NAME  IN     VARCHAR2'||CHR(10)||
',IN_ROW_DATA   IN     CLOB'||CHR(10)||
',OUT_ROW_TYPE     OUT '||IN_TABLE_NAME||'%ROWTYPE)'||CHR(10)||
'IS'||CHR(10)||
'    V_CODE NUMBER;'||CHR(10)||
'    V_ERRM VARCHAR2(500);'||CHR(10)||CHR(10)||
'CURSOR TABLE_FIELDS_CUR IS'||CHR(10)||
'    SELECT COLUMN_NAME'||CHR(10)||
'           ,DATA_LENGTH COLUMN_SIZE'||CHR(10)||
'           ,DATA_TYPE'||CHR(10)||
'      FROM ALL_TAB_COLUMNS'||CHR(10)||
'     WHERE TABLE_NAME = IN_TABLE_NAME'||CHR(10)||
'     ORDER BY COLUMN_ID ASC;'||CHR(10)||CHR(10)||
'    V_TEMP_ROW         '||IN_TABLE_NAME||'%ROWTYPE;'||CHR(10)||
'    V_ROW_VALUE        VARCHAR2(500);'||CHR(10)||
'    V_ROW_DATA         SYS.XMLTYPE := XMLTYPE(IN_ROW_DATA);'||CHR(10)||
'BEGIN'||CHR(10)||
'    FOR TABLE_FIELDS_REC IN TABLE_FIELDS_CUR LOOP'||CHR(10)||
'        IF (V_ROW_DATA.EXISTSNODE(''/''|| IN_TABLE_NAME|| ''/'' || TABLE_FIELDS_REC.COLUMN_NAME ||''/text()'') = 1) THEN'||CHR(10)||
'            V_ROW_VALUE := V_ROW_DATA.EXTRACT(''/''|| IN_TABLE_NAME|| ''/'' || TABLE_FIELDS_REC.COLUMN_NAME ||''/text()'').GETSTRINGVAL(); '||CHR(10)||
'            --V_ROW_VALUE := COMMON_TOOLS.ELIMINATE_SPECIAL_CHRCTRS(V_ROW_VALUE);'||CHR(10)||
'            CASE TABLE_FIELDS_REC.COLUMN_NAME'||CHR(10);
    V_STATIC_ROWTYPE_FOOTER CLOB := 
'                ELSE NULL;'||CHR(10)||
'            END CASE;'||CHR(10)||
'        END IF;'||CHR(10)||
'    END LOOP;'||CHR(10)||
'    OUT_ROW_TYPE  := V_TEMP_ROW;'||CHR(10)||
'EXCEPTION'||CHR(10)||
'    WHEN OTHERS THEN'||CHR(10)||
'        V_CODE  := SQLCODE;'||CHR(10)||
'        V_ERRM  := SUBSTR(SQLERRM,1,200);'||CHR(10)||
'        ERRPKG.RAISE_ERR(V_CODE, '''||IN_TABLE_NAME||'_ROWTYPE_SP, '' || '' '' || ''IN_TABLE_NAME IS '' || IN_TABLE_NAME, V_ERRM);'||CHR(10)||
'END '||IN_TABLE_NAME||'_ROWTYPE_SP;'||CHR(10);
--##############################select
    V_S_STRING        CLOB;
    V_STATIC_S_HEADER CLOB := 
'PROCEDURE '||IN_TABLE_NAME||'_S_SP ('||CHR(10)||
'/*******************************************************************************'||CHR(10)||
'	'||IN_TABLE_NAME||'_S_SP'||CHR(10)||CHR(10)||
'	This procedure is intended to select records from '||IN_TABLE_NAME||' table'||CHR(10)||CHR(10)||
'Created : '||TO_CHAR(SYSDATE,'MM/DD/RRRR')||' '||IN_USER||' CCN Project....'||CHR(10)||
'Changed : '||CHR(10)||
'*******************************************************************************/'||CHR(10)||
'IN_TABLE_NAME IN     VARCHAR2'||CHR(10)||
',IN_ROW_DATA  IN     CLOB'||CHR(10)||
',OUT_REF_CUR     OUT REF_CURSOR)'||CHR(10)||
'IS'||CHR(10)||
'    V_CODE NUMBER;'||CHR(10)||
'    V_ERRM VARCHAR2(500);'||CHR(10)||CHR(10)||
'    V_TEMP_ROW       '||IN_TABLE_NAME||'%ROWTYPE;'||CHR(10)||
'BEGIN'||CHR(10)||CHR(10)||
'    '||IN_TABLE_NAME||'_ROWTYPE_SP(IN_TABLE_NAME,'||CHR(10)||
'                            IN_ROW_DATA,'||CHR(10)||
'                            V_TEMP_ROW);'||CHR(10)||CHR(10)||
'    OPEN OUT_REF_CUR FOR'||CHR(10)||
'        SELECT *'||CHR(10)||
'          FROM '||IN_TABLE_NAME||CHR(10);
    V_STATIC_S_FOOTER CLOB := 
'EXCEPTION'||CHR(10)||
'    WHEN OTHERS THEN'||CHR(10)||
'        V_CODE  := SQLCODE;'||CHR(10)||
'        V_ERRM  := SUBSTR(SQLERRM,1,200);'||CHR(10)||
'        ERRPKG.RAISE_ERR(V_CODE, '''||IN_TABLE_NAME||'_S_SP, '' || '' '' || ''IN_TABLE_NAME IS '' || IN_TABLE_NAME, V_ERRM);'||CHR(10)||
'END '||IN_TABLE_NAME||'_S_SP;'||CHR(10);
--##############################insert
    V_I_STRING        CLOB := 
'PROCEDURE '||IN_TABLE_NAME||'_I_SP ('||CHR(10)||
'/*******************************************************************************'||CHR(10)||
'	'||IN_TABLE_NAME||'_I_SP'||CHR(10)||CHR(10)||
'	This procedure is intended to insert records into '||IN_TABLE_NAME||' table'||CHR(10)||CHR(10)||
'Created : '||TO_CHAR(SYSDATE,'MM/DD/RRRR')||' '||IN_USER||' CCN Project....'||CHR(10)||
'Changed : '||CHR(10)||
'*******************************************************************************/'||CHR(10)||
'IN_TABLE_NAME IN     VARCHAR2'||CHR(10)||
',IN_ROW_DATA  IN     CLOB)'||CHR(10)||
'IS'||CHR(10)||
'    V_CODE NUMBER;'||CHR(10)||
'    V_ERRM VARCHAR2(500);'||CHR(10)||CHR(10)||
'    V_TEMP_ROW       '||IN_TABLE_NAME||'%ROWTYPE;'||CHR(10)||
'BEGIN'||CHR(10)||CHR(10)||
'    '||IN_TABLE_NAME||'_ROWTYPE_SP(IN_TABLE_NAME,'||CHR(10)||
'                            IN_ROW_DATA,'||CHR(10)||
'                            V_TEMP_ROW);'||CHR(10)||CHR(10)||
'    INSERT INTO '||IN_TABLE_NAME||' VALUES V_TEMP_ROW;'||CHR(10)||CHR(10)||
'EXCEPTION'||CHR(10)||
'    WHEN DUP_VAL_ON_INDEX THEN'||CHR(10)||
'        '||IN_TABLE_NAME||'_U_SP(IN_TABLE_NAME,'||CHR(10)||
'                                 IN_ROW_DATA);'||CHR(10)||
'    WHEN OTHERS THEN'||CHR(10)||
'        V_CODE  := SQLCODE;'||CHR(10)||
'        V_ERRM  := SUBSTR(SQLERRM,1,200);'||CHR(10)||
'        ERRPKG.RAISE_ERR(V_CODE, '''||IN_TABLE_NAME||'_I_SP, '' || '' '' || ''IN_TABLE_NAME IS '' || IN_TABLE_NAME, V_ERRM);'||CHR(10)||
'END '||IN_TABLE_NAME||'_I_SP;'||CHR(10);
--##############################update
    V_U_STRING        CLOB;
    V_STATIC_U_HEADER CLOB := 
'PROCEDURE '||IN_TABLE_NAME||'_U_SP ('||CHR(10)||
'/*******************************************************************************'||CHR(10)||
'	'||IN_TABLE_NAME||'_U_SP'||CHR(10)||CHR(10)||
'	This procedure is intended to updates records in '||IN_TABLE_NAME||' table'||CHR(10)||CHR(10)||
'Created : '||TO_CHAR(SYSDATE,'MM/DD/RRRR')||' '||IN_USER||' CCN Project....'||CHR(10)||
'Changed : '||CHR(10)||
'*******************************************************************************/'||CHR(10)||
'IN_TABLE_NAME IN     VARCHAR2'||CHR(10)||
',IN_ROW_DATA  IN     CLOB)'||CHR(10)||
'IS'||CHR(10)||
'    V_CODE NUMBER;'||CHR(10)||
'    V_ERRM VARCHAR2(500);'||CHR(10)||CHR(10)||
'    V_TEMP_ROW       '||IN_TABLE_NAME||'%ROWTYPE;'||CHR(10)||
'BEGIN'||CHR(10)||CHR(10)||
'    '||IN_TABLE_NAME||'_ROWTYPE_SP(IN_TABLE_NAME,'||CHR(10)||
'                            IN_ROW_DATA,'||CHR(10)||
'                            V_TEMP_ROW);'||CHR(10)||CHR(10)||
'        UPDATE '||IN_TABLE_NAME||CHR(10)||
'           SET ROW = V_TEMP_ROW'||CHR(10);
    V_STATIC_U_FOOTER CLOB := 
'EXCEPTION'||CHR(10)||
'    WHEN OTHERS THEN'||CHR(10)||
'        V_CODE  := SQLCODE;'||CHR(10)||
'        V_ERRM  := SUBSTR(SQLERRM,1,200);'||CHR(10)||
'        ERRPKG.RAISE_ERR(V_CODE, '''||IN_TABLE_NAME||'_U_SP, '' || '' '' || ''IN_TABLE_NAME IS '' || IN_TABLE_NAME, V_ERRM);'||CHR(10)||
'END '||IN_TABLE_NAME||'_U_SP;'||CHR(10);
--##############################delete
    V_D_STRING        CLOB;
    V_STATIC_D_HEADER CLOB := 
'PROCEDURE '||IN_TABLE_NAME||'_D_SP ('||CHR(10)||
'/*******************************************************************************'||CHR(10)||
'	'||IN_TABLE_NAME||'_D_SP'||CHR(10)||CHR(10)||
'	This procedure is intended to delete records from '||IN_TABLE_NAME||' table'||CHR(10)||CHR(10)||
'Created : '||TO_CHAR(SYSDATE,'MM/DD/RRRR')||' '||IN_USER||' CCN Project....'||CHR(10)||
'Changed : '||CHR(10)||
'*******************************************************************************/'||CHR(10)||
'IN_TABLE_NAME IN     VARCHAR2'||CHR(10)||
',IN_ROW_DATA  IN     CLOB)'||CHR(10)||
'IS'||CHR(10)||
'    V_CODE NUMBER;'||CHR(10)||
'    V_ERRM VARCHAR2(500);'||CHR(10)||CHR(10)||
'    V_TEMP_ROW       '||IN_TABLE_NAME||'%ROWTYPE;'||CHR(10)||
'BEGIN'||CHR(10)||CHR(10)||
'    '||IN_TABLE_NAME||'_ROWTYPE_SP(IN_TABLE_NAME,'||CHR(10)||
'                            IN_ROW_DATA,'||CHR(10)||
'                            V_TEMP_ROW);'||CHR(10)||CHR(10)||
'XXXXXXXXXXXXXXXXXXXXXX'||CHR(10)||
'    DELETE'||CHR(10)||
'      FROM '||IN_TABLE_NAME||CHR(10);
    V_STATIC_D_FOOTER CLOB := 
'EXCEPTION'||CHR(10)||
'    WHEN OTHERS THEN'||CHR(10)||
'        V_CODE  := SQLCODE;'||CHR(10)||
'        V_ERRM  := SUBSTR(SQLERRM,1,200);'||CHR(10)||
'        ERRPKG.RAISE_ERR(V_CODE, '''||IN_TABLE_NAME||'_D_SP, '' || '' '' || ''IN_TABLE_NAME IS '' || IN_TABLE_NAME, V_ERRM);'||CHR(10)||
'END '||IN_TABLE_NAME||'_D_SP;'||CHR(10);
-----------------------------------------------------------------------------------------------
    V_COUNT NUMBER := 0;
    V_WHERE_CLAUSE CLOB;
    V_DRI_CLAUSE   CLOB;
    V_VAL VARCHAR2(100);
BEGIN
    V_ROWTYPE_STRING := V_ROWTYPE_STRING || V_STATIC_ROWTYPE_HEADER;
    V_S_STRING := V_S_STRING || V_STATIC_S_HEADER;
    V_U_STRING := V_U_STRING || V_STATIC_U_HEADER;
    V_D_STRING := V_D_STRING || V_STATIC_D_HEADER;
    FOR REC IN (SELECT COLUMN_NAME, DATA_TYPE
                  FROM ALL_TAB_COLUMNS
                 WHERE TABLE_NAME = IN_TABLE_NAME 
                 ORDER BY COLUMN_ID ASC) LOOP
        V_ROWTYPE_STRING := V_ROWTYPE_STRING ||
                            '                WHEN '''||REC.COLUMN_NAME||''' THEN'||CHR(10);
        IF REC.DATA_TYPE = 'DATE' THEN
            V_ROWTYPE_STRING := V_ROWTYPE_STRING ||
                            '                    V_TEMP_ROW.'||RPAD(REC.COLUMN_NAME,30,' ')||'        :=  TO_DATE(V_ROW_VALUE,''MM-DD-YYYY'');'||CHR(10);
        ELSE
            V_ROWTYPE_STRING := V_ROWTYPE_STRING ||
                            '                    V_TEMP_ROW.'||RPAD(REC.COLUMN_NAME,30,' ')||'        :=  V_ROW_VALUE;'||CHR(10);
        END IF;
    END LOOP;
    FOR REC IN (SELECT COLUMN_NAME, DATA_TYPE
                  FROM ALL_TAB_COLUMNS
                 WHERE TABLE_NAME = IN_TABLE_NAME
                   AND NULLABLE = 'N'
                 ORDER BY COLUMN_ID ASC) LOOP
        IF REC.DATA_TYPE = 'DATE' THEN
            V_VAL := 'NVL('||REC.COLUMN_NAME||',TRUNC(SYSDATE))';
        ELSIF REC.DATA_TYPE = 'NUMBER' THEN
            V_VAL := 'NVL('||REC.COLUMN_NAME||',-1)';        
        ELSE
            V_VAL := 'NVL('||REC.COLUMN_NAME||',''XXX'')';
        END IF;
        IF V_COUNT = 0 THEN
            V_WHERE_CLAUSE := V_WHERE_CLAUSE ||'         WHERE '||RPAD(V_VAL,40,' ')||'    = NVL(V_TEMP_ROW.'||REC.COLUMN_NAME||','||V_VAL||')';
        ELSE
            V_WHERE_CLAUSE := V_WHERE_CLAUSE ||CHR(10)||'           AND '||RPAD(V_VAL,40,' ')||'    = NVL(V_TEMP_ROW.'||REC.COLUMN_NAME||','||V_VAL||')';
        END IF;
        V_COUNT := V_COUNT + 1;
    END LOOP;
    FOR REC_RI IN (SELECT CONSTRAINT_NAME, TABLE_NAME
                     FROM USER_CONSTRAINTS
                    WHERE R_CONSTRAINT_NAME IN (SELECT CONSTRAINT_NAME
                                                  FROM USER_CONSTRAINTS
                                                 WHERE TABLE_NAME = IN_TABLE_NAME)) LOOP
        V_DRI_CLAUSE := V_DRI_CLAUSE || '    SD_TABLE_IU_PKG.' || REC_RI.TABLE_NAME || '_D_SP('''|| REC_RI.TABLE_NAME ||''',IN_ROW_DATA);' || CHR(10);
    END LOOP;
    V_ROWTYPE_STRING := V_ROWTYPE_STRING || V_STATIC_ROWTYPE_FOOTER;
    V_S_STRING := V_S_STRING || V_WHERE_CLAUSE || ';' || CHR(10) || CHR(10) || V_STATIC_S_FOOTER;
    V_U_STRING := V_U_STRING || V_WHERE_CLAUSE || ';' || CHR(10) || CHR(10) || V_STATIC_U_FOOTER;
    IF V_DRI_CLAUSE IS NULL THEN
        V_D_STRING := REPLACE(V_D_STRING,'XXXXXXXXXXXXXXXXXXXXXX','') || V_WHERE_CLAUSE || ';' || CHR(10) || CHR(10) || V_STATIC_D_FOOTER;
    ELSE
        V_D_STRING := REPLACE(V_D_STRING,'XXXXXXXXXXXXXXXXXXXXXX',V_DRI_CLAUSE) || V_WHERE_CLAUSE || ';' || CHR(10) || CHR(10) || V_STATIC_D_FOOTER;
    END IF;
    IF UPPER(IN_PARAMETER) LIKE '%R%' THEN
        DBMS_OUTPUT.PUT_LINE(V_ROWTYPE_STRING);
    END IF;
    IF UPPER(IN_PARAMETER) LIKE '%S%' THEN
        DBMS_OUTPUT.PUT_LINE(V_S_STRING);
    END IF;
    IF UPPER(IN_PARAMETER) LIKE '%I%' THEN
        DBMS_OUTPUT.PUT_LINE(V_I_STRING);
    END IF;
    IF UPPER(IN_PARAMETER) LIKE '%U%' THEN
        DBMS_OUTPUT.PUT_LINE(V_U_STRING);
    END IF;
    IF UPPER(IN_PARAMETER) LIKE '%D%' THEN
        DBMS_OUTPUT.PUT_LINE(V_D_STRING);
    END IF;
END GENERATE_CODE;