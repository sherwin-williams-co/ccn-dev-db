SET ECHO OFF
SET SCAN OFF
SET FEEDBACK OFF
SET HEADING OFF

CREATE OR REPLACE
FUNCTION GET_CODE_LONG(IN_NAME VARCHAR2,
                       IN_TYPE VARCHAR2) RETURN CLOB AS
   V_CLOB CLOB;
BEGIN
   FOR REC IN (SELECT TEXT FROM USER_SOURCE WHERE NAME = IN_NAME AND TYPE = IN_TYPE ORDER BY LINE) LOOP
       V_CLOB := V_CLOB||REC.TEXT;
   END LOOP;
   --V_CLOB := V_CLOB||'/';
   RETURN V_CLOB;
END GET_CODE_LONG;
/

EXECUTE DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'STORAGE',FALSE);
EXECUTE DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'TABLESPACE',FALSE);
EXECUTE DBMS_METADATA.SET_TRANSFORM_PARAM(DBMS_METADATA.SESSION_TRANSFORM,'SEGMENT_ATTRIBUTES',FALSE);

SPOOL 'C:\code\code_generator.sql'
SELECT 'SET SERVEROUTPUT ON'||CHR(10)||
       'SET FEEDBACK OFF' FROM DUAL;
SELECT 'SPOOL C:\code\' || TABLE_NAME || '.SQL;'||CHR(10)||
       'EXECUTE DBMS_OUTPUT.PUT_LINE(REPLACE(REPLACE(DBMS_METADATA.GET_DDL(''TABLE'','''||TABLE_NAME||'''),''"'',''''),'''||USER||'.'',''''));'||CHR(10)||
       'SPOOL OFF;'
  FROM USER_TABLES;
SELECT 'SPOOL C:\code\' || INDEX_NAME || '.SQL;'||CHR(10)||
       'EXECUTE DBMS_OUTPUT.PUT_LINE(REPLACE(REPLACE(DBMS_METADATA.GET_DDL(''INDEX'','''||INDEX_NAME||'''),''"'',''''),'''||USER||'.'',''''));'||CHR(10)||
       'SPOOL OFF;'
  FROM USER_INDEXES;
SELECT 'SPOOL C:\code\' || NAME || DECODE(TYPE,'PACKAGE','.PKS',
                                               'PACKAGE BODY','.PKG',
                                               'TRIGGER','.TRG',
                                               '.SQL')||';'||CHR(10)||
       'BEGIN'||CHR(10)||
       --'   dbms_preprocessor.print_post_processed_source ('''||TYPE||''', USER, '''||NAME||''');'||CHR(10)||
       '   DBMS_OUTPUT.PUT_LINE(''CREATE OR REPLACE ''||GET_CODE_LONG('''||NAME||''','''||TYPE||'''));'||CHR(10)||
       --'   dbms_output.put_line(''/'');'||CHR(10)||
       'EXCEPTION '||CHR(10)||
       '   WHEN OTHERS THEN '||CHR(10)||
       '      DBMS_OUTPUT.PUT_LINE(''CREATE OR REPLACE '');'||CHR(10)||
       '      dbms_preprocessor.print_post_processed_source ('''||TYPE||''', USER, '''||NAME||''');'||CHR(10)||
       --'      PROC_IEX('''||NAME||'-'||TYPE||''');'||CHR(10)||
       'END;'||CHR(10)||
       '/'||CHR(10)||
       'SPOOL OFF;'
  FROM (SELECT DISTINCT NAME, TYPE
          FROM ALL_SOURCE 
         WHERE OWNER = 'COSTCNTR'
           AND NAME NOT LIKE '%$%'
         ORDER BY DECODE(TYPE, 'PACKAGE','A',
                               'PACKAGE BODY','B',
                               'TRIGGER', 'C',
                               'D'));
SELECT '/*' FROM DUAL;
SELECT '@C:\code\' || NAME || DECODE(TYPE,'PACKAGE','.PKS',
                                          'PACKAGE BODY','.PKG',
                                          'TRIGGER','.TRG',
                                          '.SQL')||';'
  FROM (SELECT DISTINCT NAME, TYPE
          FROM ALL_SOURCE
         WHERE OWNER = 'COSTCNTR'
           AND NAME NOT LIKE '%$%'
         ORDER BY DECODE(TYPE, 'PACKAGE','A',
                               'PACKAGE BODY','B',
                               'TRIGGER', 'C',
                               'D'));
SELECT '@C:\code\' || TABLE_NAME || '.SQL;'
  FROM USER_TABLES;
SELECT '@C:\code\' || INDEX_NAME || '.SQL;'
  FROM USER_INDEXES;
SELECT '*/' FROM DUAL;
SPOOL OFF;
@C:\code\code_generator.sql;

DROP FUNCTION GET_CODE_LONG;
