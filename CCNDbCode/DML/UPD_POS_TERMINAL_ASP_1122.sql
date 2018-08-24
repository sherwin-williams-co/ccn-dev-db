/*********************************************************** 
 This is one time update script to update the pos_last_tran_date, number and pos version number field
 created  : 08/22/2018 sxg151 CCN project
          : ASP-1122
************************************************************/

DECLARE
CURSOR CUR IS
SELECT DISTINCT TRAN_DATE, STORE_NO, TERMNBR,TRANNBR, POS_VERSION_NUMBER, RLS_RUN_CYCLE
  FROM PNP.CCN_HEADERS CH
 WHERE RLS_RUN_CYCLE > '1637';

BEGIN
    FOR REC IN CUR LOOP
       UPDATE TERMINAL T
          SET POS_LAST_TRAN_DATE                         = REC.TRAN_DATE,
               POS_LAST_TRAN_NUMBER                      = LPAD(REC.TRANNBR, 5, '0'),
               POS_VERSION_NBR                           = REC.POS_VERSION_NUMBER
         WHERE SUBSTR(COST_CENTER_CODE,3)                = REC.STORE_NO
           AND TERMINAL_NUMBER                           = REC.TERMNBR
           AND (NVL(POS_LAST_TRAN_DATE,(TRUNC(SYSDATE))) <> NVL(REC.TRAN_DATE,TRUNC(SYSDATE)+1) OR
                NVL(POS_LAST_TRAN_NUMBER,-1)             <> NVL(LPAD(REC.TRANNBR, 5, '0'),-2) OR
                NVL(POS_VERSION_NBR,-1)                  <> NVL(REC.POS_VERSION_NUMBER,-2))
           AND EXPIRATION_DATE IS NULL;

          COMMIT;
    END LOOP;
    COMMIT;
END;
