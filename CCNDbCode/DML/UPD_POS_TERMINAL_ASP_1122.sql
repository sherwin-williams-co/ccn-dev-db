/*********************************************************** 
 This is one time update script to update the pos_last_tran_date, number and pos version number field
 created  : 08/22/2018 sxg151 CCN project
          : ASP-1122
************************************************************/

  CREATE TABLE POS_TERM_UPD
   (TRAN_DATE           DATE,
    STORE_NO            VARCHAR2(4),
    TERMNBR             NUMBER,
    TRANNBR             NUMBER,
    POS_VERSION_NUMBER  NUMBER,
    RLS_RUN_CYCLE       NUMBER);

/

DECLARE
CURSOR CUR IS 
SELECT DISTINCT TRAN_DATE, STORE_NO, TERMNBR,TRANNBR, POS_VERSION_NUMBER, RLS_RUN_CYCLE
  FROM PNP.CCN_HEADERS CH
 WHERE RLS_RUN_CYCLE > '1637';
 
 V_COUNT NUMBER := 0;
 
BEGIN
    FOR REC IN CUR LOOP
      INSERT INTO POS_TERM_UPD VALUES REC;
      V_COUNT := V_COUNT+1;
      IF V_COUNT = 500 then
         COMMIT;
         V_COUNT := 0;
      END IF;
      END LOOP;
      COMMIT;
END;

/


DECLARE
CURSOR CUR IS
   SELECT DISTINCT STORE_NO,TRAN_DATE, TERMNBR,TRANNBR, POS_VERSION_NUMBER
     FROM POS_TERM_UPD A
    WHERE RLS_RUN_CYCLE IN (SELECT MAX(RLS_RUN_CYCLE)
                              FROM POS_TERM_UPD B
                             WHERE B.STORE_NO = A.STORE_NO
                               AND B.TERMNBR = A.TERMNBR);

  V_COUNT NUMBER := '0';
BEGIN
    FOR REC IN CUR LOOP
       UPDATE TERMINAL T
          SET POS_LAST_TRAN_DATE                        = REC.TRAN_DATE,
               POS_LAST_TRAN_NUMBER                      = LPAD(REC.TRANNBR, 5, '0'),
               POS_VERSION_NBR                           = REC.POS_VERSION_NUMBER
         WHERE SUBSTR(COST_CENTER_CODE,3)                = REC.STORE_NO
           AND TERMINAL_NUMBER                           = REC.TERMNBR
           AND (NVL(POS_LAST_TRAN_DATE,(TRUNC(SYSDATE))) <> NVL(REC.TRAN_DATE,TRUNC(SYSDATE)+1) OR
                NVL(POS_LAST_TRAN_NUMBER,-1)             <> NVL(LPAD(REC.TRANNBR, 5, '0'),-2) OR
                NVL(POS_VERSION_NBR,-1)                  <> NVL(REC.POS_VERSION_NUMBER,-2))
           AND EXPIRATION_DATE IS NULL;

          V_COUNT := V_COUNT +1;
       IF V_COUNT = 500 then
          V_COUNT:= 0;
          COMMIT;
       END IF;
    END LOOP;
    COMMIT;
END;

/

DROP TABLE POS_TERM_UPD;
