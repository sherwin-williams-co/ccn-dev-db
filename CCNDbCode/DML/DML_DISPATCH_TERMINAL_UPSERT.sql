/********************************************************************************
Adding new Cost Center category  "D - Dispatch Terminal" for Terminal type cost centers INTO CODE_DETAIL

Adding Records into DISPATCH_TERMINAL TABle

Update Cost center category to "D" which are Dispatch termials

Created : 04/11/2017 rxa457 CCN Project Team....
Modified: 06/23/2017 rxa457 CCN Project Team... 
          Feedback points from Testing and Business incorporated - MISSING script for INSERT ORDER as part of the main patch. isnert and update PLSQL blocks merged as one block.
          Cost center '76782T' need not be excluded from DISPATCH terminal category
          Future Date Cost centers to be excluded 
Modified: 08/03/2017 rxa457 CCN Project Team...
          Update Audit Log table to update the current inserted DISPATCH_TERMINAL record as "R" record
            and make all previous audits, i.e 'R" records as processed "C" records to avoid compare 
            and sending it back into backfeed through audit processing
********************************************************************************/
SET DEFINE OFF;

REM INSERTING into CODE_DETAIL
Insert into CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('CATEGORY','COD','D','DISPATCH TERMINAL','N',null,null,7,null,null);
COMMIT;

REM INSERTING into INSERTORDER
Insert into INSERTORDER (TABLE_NAME,TABLE_ORDER) 
            SELECT 'DISPATCH_TERMINAL'
                   ,21
              FROM DUAL
             WHERE NOT EXISTS(SELECT 'X' 
                                FROM INSERTORDER I 
                               WHERE I.TABLE_NAME = 'DISPATCH_TERMINAL' 
                                 AND I.TABLE_ORDER = 21
                              ) ;
COMMIT;

REM UPDATING COST_CENTER CATEGORY AND INSERTS INTO DISPATCH_TERMINAL
DECLARE
        CURSOR UPD_COST_CENTER IS 
          SELECT * 
            FROM COST_CENTER A 
           WHERE COST_CENTER_CODE LIKE '%T' 
             AND COST_CENTER_CODE NOT IN ('83MXMT', '83VIET', '81GPOT','OOPPFT')
             AND EXISTS(SELECT 'X' 
                           FROM COST_CENTER C 
                          WHERE SUBSTR(C.COST_CENTER_CODE,-4,4) = SUBSTR(A.COST_CENTER_NAME,-4,4) 
                            AND C.CATEGORY = 'S'
                        )
             AND A.CATEGORY !='D'
             AND (TRUNC(OPEN_DATE) <= TRUNC(SYSDATE) OR OPEN_DATE IS NULL) 
             AND (TRUNC(BEGIN_DATE) <= TRUNC(SYSDATE) OR BEGIN_DATE IS NULL);
                
        CURSOR HOME_STORE(P_COST_CENTER_NAME VARCHAR2) IS SELECT COST_CENTER_CODE 
                                                            FROM COST_CENTER C 
                                                           WHERE SUBSTR(C.COST_CENTER_CODE,-4,4) = SUBSTR(P_COST_CENTER_NAME,-4,4) 
                                                                 AND C.CATEGORY = 'S';
        I NUMBER :=0;
        V_HOME_STORE COST_CENTER.COST_CENTER_CODE%TYPE;
BEGIN
        FOR REC IN UPD_COST_CENTER LOOP
                I := I +1;

                FOR J IN HOME_STORE(REC.COST_CENTER_NAME) LOOP
                    V_HOME_STORE := J.COST_CENTER_CODE;
                END LOOP;

                UPDATE COST_CENTER SET CATEGORY = 'D' WHERE COST_CENTER_CODE = REC.COST_CENTER_CODE;
                INSERT INTO DISPATCH_TERMINAL SELECT REC.COST_CENTER_CODE, 'D', V_HOME_STORE FROM DUAL;
                DELETE FROM STORE S WHERE S.COST_CENTER_CODE = REC.COST_CENTER_CODE;
                UPDATE AUDIT_LOG
                   SET AUDIT_REC_FLAG     = 'C',
                       AUDIT_REC_EFF_DATE = SYSDATE
                 WHERE TABLE_NAME = 'STORE'
                       AND TRANSACTION_ID = '|'||REC.COST_CENTER_CODE||'|'
                       AND AUDIT_REC_FLAG = 'R';
                UPDATE AUDIT_LOG
                   SET AUDIT_REC_FLAG = 'R'
                 WHERE TABLE_NAME = 'STORE'
                       AND TRANSACTION_ID = '|'||REC.COST_CENTER_CODE||'|'
                       AND AUDIT_REC_FLAG IS NULL;
                
                IF I > 100 THEN
                        I := 0;
                        COMMIT;
                END IF;
        END LOOP;
        COMMIT;
EXCEPTION WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20089,SQLCODE||' - '||SQLERRM);
END;
/
  
COMMIT;
