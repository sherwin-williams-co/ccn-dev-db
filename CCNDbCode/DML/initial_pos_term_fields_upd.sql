/*********************************************************** 
 This is one time update script to update the pos_last_tran_date, number and pos version number field
 created  : 01/24/2018 nxk927 CCN project
 revisions: 04/18/2018 nxk927 CCN project
            Updated the script to just update POS_VERSION_NBR from POS data
************************************************************/

DECLARE
CURSOR CUR IS
   SELECT *
     FROM (WITH T AS
                (SELECT TRAN_DATE, STORE_NO, TERMNBR, POS_VERSION_NUMBER
                   FROM PNP.CCN_HEADERS CH
                  WHERE RLS_RUN_CYCLE >= '1432'
                    AND CH.TRAN_TIMESTAMP = (SELECT MAX(TRAN_TIMESTAMP)
                                               FROM PNP.CCN_HEADERS
                                              WHERE RLS_RUN_CYCLE >= '1432'
                                                AND STORE_NO = CH.STORE_NO
                                                AND TERMNBR = CH.TERMNBR))
          SELECT *
            FROM T);
  V_COUNT NUMBER := '0';
BEGIN
    FOR REC IN CUR LOOP
       UPDATE TERMINAL
          SET POS_VERSION_NBR                           = REC.POS_VERSION_NUMBER
        WHERE SUBSTR(COST_CENTER_CODE,3)                = REC.STORE_NO
          AND TERMINAL_NUMBER                           = REC.TERMNBR
          AND NVL(POS_VERSION_NBR,-1)                  <> NVL(REC.POS_VERSION_NUMBER,-2)
          AND EXPIRATION_DATE IS NULL;
          V_COUNT := V_COUNT +1;
       IF V_COUNT = 500 then
          COMMIT;
       END IF;
    END LOOP;
    COMMIT;
END;