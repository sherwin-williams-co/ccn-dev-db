/*********************************************************** 
 This is one time update script to update the pos_last_tran_date, number and pos version number field
 created  : 01/24/2018 nxk927 CCN project
 revisions: 04/18/2018 nxk927 CCN project
            Updated the script to just update POS_VERSION_NBR from POS data
 revisions: 05/29/2018 nxk927 CCN project
            Creating a local table and loading the data in the local table before updating the version 
            number
************************************************************/

  CREATE TABLE POS_VER_TERM
   (TRAN_DATE           DATE,
    STORE_NO            VARCHAR2(4),
    TERMNBR             NUMBER,
    POS_VERSION_NUMBER  NUMBER,
    RLS_RUN_CYCLE       NUMBER);

/

DECLARE
CURSOR CUR IS 
SELECT DISTINCT TRAN_DATE, STORE_NO, TERMNBR, POS_VERSION_NUMBER, RLS_RUN_CYCLE
  FROM PNP.CCN_HEADERS CH
 WHERE RLS_RUN_CYCLE >= '1432';
 
 V_COUNT NUMBER := 0;
 
BEGIN
    FOR REC IN CUR LOOP
      INSERT INTO POS_VER_TERM VALUES REC;
      V_COUNT := V_COUNT+1;
      IF V_COUNT = 500 then
         COMMIT;
         V_COUNT := 0;
      END IF;
      END LOOP;
END;

/


DECLARE
CURSOR CUR IS
   SELECT DISTINCT STORE_NO, TERMNBR, POS_VERSION_NUMBER
     FROM POS_VER_TERM A
    WHERE RLS_RUN_CYCLE IN (SELECT MAX(RLS_RUN_CYCLE)
                              FROM POS_VER_TERM B
                             WHERE B.STORE_NO = A.STORE_NO
                               AND B.TERMNBR = A.TERMNBR);

  V_COUNT NUMBER := '0';
BEGIN
    FOR REC IN CUR LOOP
       UPDATE TERMINAL T
          SET POS_VERSION_NBR                           = REC.POS_VERSION_NUMBER
        WHERE SUBSTR(COST_CENTER_CODE,3)                = REC.STORE_NO
          AND TERMINAL_NUMBER                           = REC.TERMNBR
          AND NVL(POS_VERSION_NBR,-1)                  <> NVL(REC.POS_VERSION_NUMBER,-2)
          AND EXPIRATION_DATE IS NULL
          AND POLLING_STATUS_CODE                       = (SELECT POLLING_STATUS_CODE
                                                             FROM POLLING
                                                            WHERE COST_CENTER_CODE = T.COST_CENTER_CODE
                                                              AND EXPIRATION_DATE IS NULL);
          V_COUNT := V_COUNT +1;
       IF V_COUNT = 500 then
          V_COUNT:= 0;
          COMMIT;
       END IF;
    END LOOP;
    COMMIT;
END;

/
/*
--DROP TABLE TABLE POS_VER_TERM;
*/