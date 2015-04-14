create or replace PROCEDURE TERR_EMP_SYNC_SP
/*******************************************************************************
	TERR_EMP_SYNC_SP

	This procedure is intended to SYNC up Mainframe with CCN data for the Territory Employees
  and create a backfeed file on the DB server

created : 04/14/2015 sxh487 CCN Project....
*******************************************************************************/
IS

IN_TABLE_NAME       VARCHAR2(100):= 'TERRITORY_EMPLOYEE';
IN_ROW_CURR	        AUDIT_LOG.TABLE_ROW_DATA%TYPE;
V_LOG_ID_CURR       AUDIT_LOG.LOG_ID%TYPE;
PK_CURR             AUDIT_LOG.TABLE_PK_VALUE%TYPE;

V_OUT_CLOB2            CLOB;
V_CC_CURR              MANAGER_EMPLOYEE.COST_CENTER_CODE%TYPE; 
V_VALUE_CURR           VARCHAR2(32000);
V_EXTRD_VAL_CURR       VARCHAR2(32000);

V_CURR_AUD_REC_STATUS  VARCHAR2(1) := 'C';
V_CONTEXT              VARCHAR2(200);


  PATH        	        VARCHAR2(50) := 'CCN_DATAFILES'; -- directory created in Oracle database UNTIL NEW ONE CREATED
  filename  	          VARCHAR2(50) := in_TABLE_NAME || '_backfeed' ;
  stamp       		      VARCHAR2(50) := TO_CHAR(SYSTIMESTAMP,'HH24:MI:SS:FF6'); -- used to create timestamp for data file 
  output_file 		      UTL_FILE.FILE_TYPE;

CURSOR terr_emp_cur IS
SELECT DISTINCT TRANSACTION_ID
 FROM AUDIT_LOG AL
WHERE TABLE_NAME = 'TERRITORY_EMPLOYEE' 
  AND TRANSACTION_ID IN  
('|0237367|','|0301582|','|0240957|','|0243033|','|0306247|',
'|0211832|','|0305646|','|0356878|','|0353269|','|0219188|','|0238285|',
'|0340229|','|0241044|','|0204190|','|0288177|','|0240001|','|0308755|',
'|019530|','|0361225|','|0241377|','|0322281|','|0220185|',
'|0252933|','|0220909|','|0226116|','|0250082|','|0379377|','|021999|',
'|278058|','|0309982|','|0316956|','|0269869|','|0253818|',
'|0245140|','|0253292|','|0250688|','|0241706|','|1000656|',
'|0365206|','|1000069|','|0349291|','|0378472|','|0374480|','|0362705|',
'|0294532|','|0374549|','|0364587|','|0272790|','|0363039|','|279759|',
'|0367147|','|0367066|','|0209586|','|0377855|','|0220528|','|0255000|',
'|0378343|','|0286705|','|0211630|'
)
  AND AUDIT_REC_FLAG = 'R'
  AND NOT EXISTS (SELECT 1
                    FROM AUDIT_LOG
                   WHERE TABLE_NAME = 'TERRITORY_EMPLOYEE'
                     AND TRANSACTION_ID = AL.TRANSACTION_ID
                     AND AUDIT_REC_FLAG = 'C');

CURSOR table_fields_cur IS
  SELECT COLUMN_NAME,
         DECODE(DATA_TYPE, 'DATE', 8, DATA_LENGTH) COLUMN_SIZE,
         DATA_TYPE,
         COLUMN_ID
    FROM ALL_TAB_COLUMNS
   WHERE TABLE_NAME = IN_TABLE_NAME
   ORDER BY COLUMN_ID ASC;

BEGIN
   -- working just remove for debbuging un comment for writing file
   V_CONTEXT := 'Creating the file on server';
   output_file := UTL_FILE.FOPEN (path
                                  ,filename|| stamp
                                  , 'w' --binary
                                 , 32767);

    FOR each_emp in terr_emp_cur LOOP

        V_CONTEXT := 'Selecting Current Row from Audit_Log';
        SELECT TABLE_ROW_DATA, LOG_ID, TABLE_PK_VALUE INTO IN_ROW_CURR, V_LOG_ID_CURR, PK_CURR -- Added to accomodate population of primary key columns in backFeed files generated
          FROM AUDIT_LOG AL
         WHERE TABLE_NAME        = IN_TABLE_NAME
           AND AL.TRANSACTION_ID = each_emp.transaction_id
           AND AL.TRANSACTION_DATE IN (SELECT MAX(AL1.TRANSACTION_DATE)
                                         FROM AUDIT_LOG AL1
                                        WHERE AL1.TABLE_NAME     = AL.TABLE_NAME
                                          AND AL1.TRANSACTION_ID = each_emp.transaction_id)
           AND AL.LOG_ID = (SELECT MAX( AL2.LOG_ID)
                              FROM	AUDIT_LOG AL2
                             WHERE AL2.TABLE_NAME = AL.TABLE_NAME
                               AND AL2.TRANSACTION_ID = each_emp.transaction_id)
           AND ROWNUM < 2;

        V_CC_CURR   := NVL(CCN_AUDIT_PKG.XML_EXTRACT_NO_EXCEPTION(IN_ROW_CURR,'//' || 'COST_CENTER_CODE'), '~');
        V_OUT_CLOB2 := TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS')
                      || V_CC_CURR
                      || RPAD(IN_TABLE_NAME,25)
                      || TRIM(LPAD(V_LOG_ID_CURR,14,'0'))
                      || V_CURR_AUD_REC_STATUS;

        FOR TABLE_FIELDS_REC IN TABLE_FIELDS_CUR LOOP
            V_CONTEXT        := 'Building V_OUT_CLOB2 with Current Record Data';
            V_EXTRD_VAL_CURR := NVL(CCN_AUDIT_PKG.XML_EXTRACT_NO_EXCEPTION(IN_ROW_CURR,'//' || TABLE_FIELDS_REC.COLUMN_NAME),'~');  
            V_EXTRD_VAL_CURR := NVL(COMMON_TOOLS.ELIMINATE_SPECIAL_CHRCTRS(V_EXTRD_VAL_CURR), '~');
            V_VALUE_CURR     := UPPER(RPAD(V_EXTRD_VAL_CURR, NVL(TABLE_FIELDS_REC.COLUMN_SIZE,LENGTH(V_EXTRD_VAL_CURR))));
            V_OUT_CLOB2 := V_OUT_CLOB2 || V_VALUE_CURR;
        END LOOP;

        --DBMS_OUTPUT.PUT_LINE (V_OUT_CLOB2);
        UTL_FILE.PUT_LINE(output_file, V_OUT_CLOB2, TRUE);
        V_OUT_CLOB2 := NULL; 
    END LOOP;
    UTL_FILE.FCLOSE(output_file);
END TERR_EMP_SYNC_SP;