/*
created : 12/06/2016 jxc517 CCN Project Team
          below script will
          1. drop the business rules/constraint placed on BANK_MICR FORMAT to have format name as 6 charcacters and alpha numeric
          2. inserts the missing and failed bank MICR formats into BANK_MICR_FORMAT/BANK_MICR_FORMAT_HIST table accordingly
              2.1. any initload failed records with error other than constraint error needs to be addressed separately
          3. update BANK_DEP_TICK and BANK_DEP_BAG_TICK (current/future) tables reorder points as 42 and 21 respectively
*/

ALTER TABLE BANK_MICR_FORMAT DROP CONSTRAINT MICR_FORMAT_NAME_CHECK;
ALTER TABLE BANK_MICR_FORMAT_FUTURE DROP CONSTRAINT MICR_FORMAT_NAME_CHECK_FTR;
ALTER TABLE BANK_MICR_FORMAT_HIST DROP CONSTRAINT MICR_FORMAT_NAME_CHECK_HIST;

SET SERVEROUTPUT ON;
DECLARE
    CURSOR failed_micrs IS
        SELECT BANK_ACCOUNT_NBR,
               FORMAT_NAME,
               DJDE_FORM_PARM,
               DJDE_FEED_PARM,
               MICR_COST_CNTR,
               MICR_ROUTING_NBR,
               MICR_FORMAT_ACTNBR,
               TO_DATE(CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(EFFECTIVE_DATE), 'RRRRMMDD') EFFECTIVE_DATE,
               TO_DATE(CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(EXPIRATION_DATE), 'RRRRMMDD') EXPIRATION_DATE,
               TO_DATE(CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(LAST_MAINTENANCE_DATE), 'RRRRMMDD') LAST_MAINTENANCE_DATE,
               LAST_MAINT_USER_ID
          FROM TEMP_MICR_FORMAT
         WHERE (BANK_ACCOUNT_NBR, FORMAT_NAME) IN (SELECT BANK_ACCOUNT_NBR, COST_CENTER_CODE
                                                     FROM ERROR_LOG
                                                    WHERE TABLE_NAME LIKE 'BANK_MICR_FORMAT%'
                                                      AND ERROR_TEXT <> 'Bank Account Number not found for effective date');
    V_BANK_ACCOUNT_HIST_ROW BANK_ACCOUNT%ROWTYPE;
    V_BANK_ACCOUNT_CURR_ROW BANK_ACCOUNT%ROWTYPE;
    V_MICR_FORMAT_ID        NUMBER;
BEGIN
    FOR rec IN failed_micrs LOOP
        V_MICR_FORMAT_ID := NULL;
        V_BANK_ACCOUNT_CURR_ROW := BANKING_COMMON_TOOLS.GET_BANK_ACCOUNT_REC(rec.BANK_ACCOUNT_NBR);
        IF V_BANK_ACCOUNT_CURR_ROW.BANK_ACCOUNT_NBR IS NOT NULL THEN
            BEGIN
                SELECT NVL(MAX(MICR_FORMAT_ID),0) + 1
                  INTO V_MICR_FORMAT_ID
                  FROM BANK_MICR_FORMAT
                 WHERE BANK_ACCOUNT_NBR = rec.BANK_ACCOUNT_NBR;
            EXCEPTION WHEN OTHERS THEN NULL;
            END;
            INSERT INTO BANK_MICR_FORMAT VALUES(
                rec.BANK_ACCOUNT_NBR,
                rec.FORMAT_NAME,
                rec.DJDE_FORM_PARM,
                rec.DJDE_FEED_PARM,
                rec.MICR_COST_CNTR,
                rec.MICR_ROUTING_NBR,
                rec.MICR_FORMAT_ACTNBR,
                GREATEST(rec.EFFECTIVE_DATE, V_BANK_ACCOUNT_CURR_ROW.EFFECTIVE_DATE),
                NULL,
                rec.LAST_MAINTENANCE_DATE,
                rec.LAST_MAINT_USER_ID,
                TRUNC(SYSDATE),
                'INITLOAD',
                V_MICR_FORMAT_ID
                );
        ELSE
            V_BANK_ACCOUNT_HIST_ROW := BANKING_COMMON_TOOLS.GET_BANK_ACCOUNT_HIST_REC(rec.BANK_ACCOUNT_NBR, rec.EFFECTIVE_DATE);
            IF V_BANK_ACCOUNT_HIST_ROW.BANK_ACCOUNT_NBR IS NOT NULL THEN
                rec.EXPIRATION_DATE := NVL(TO_DATE(CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.EXPIRATION_DATE)), 
                                           V_BANK_ACCOUNT_HIST_ROW.EXPIRATION_DATE);
                BEGIN
                    SELECT NVL(MAX(MICR_FORMAT_ID),0) + 1
                      INTO V_MICR_FORMAT_ID
                      FROM BANK_MICR_FORMAT_HIST
                     WHERE BANK_ACCOUNT_NBR = rec.BANK_ACCOUNT_NBR;
                EXCEPTION WHEN OTHERS THEN NULL;
                END;
                INSERT INTO BANK_MICR_FORMAT_HIST VALUES(
                    rec.BANK_ACCOUNT_NBR,
                    rec.FORMAT_NAME,
                    rec.DJDE_FORM_PARM,
                    rec.DJDE_FEED_PARM,
                    rec.MICR_COST_CNTR,
                    rec.MICR_ROUTING_NBR,
                    rec.MICR_FORMAT_ACTNBR,
                    GREATEST(rec.EFFECTIVE_DATE, V_BANK_ACCOUNT_HIST_ROW.EFFECTIVE_DATE),
                    NULL,
                    rec.LAST_MAINTENANCE_DATE,
                    rec.LAST_MAINT_USER_ID,
                    TRUNC(SYSDATE),
                    'INITLOAD',
                    V_MICR_FORMAT_ID
                    );
            ELSE
                DBMS_OUTPUT.PUT_LINE('bank account not found : '||rec.BANK_ACCOUNT_NBR);
            END IF;
        END IF;
    END LOOP;
END;
/

INSERT INTO BANK_MICR_FORMAT VALUES ('1002421866','WELL81','BDF043','PART2','0000XXXX',':518200392:','XXXXXXXXXX<','26-JUL-2016',NULL,NULL,'LXB8VR',TRUNC(SYSDATE),'INITLOAD',10);
INSERT INTO BANK_MICR_FORMAT VALUES ('216437840','PROP1','BDF554','PART2','0000XXXX',':XXXXXXXXX:','XXXXXXXXX<','22-SEP-2016',NULL,NULL,'LXB8VR',TRUNC(SYSDATE),'INITLOAD',1);
INSERT INTO BANK_MICR_FORMAT VALUES ('3751905817','BOAII','BDF046','PART2','0000XXXX',':540900071:',' 375 190 5817<','05-JAN-2016',NULL,NULL,'LXB8VR',TRUNC(SYSDATE),'INITLOAD',7);
INSERT INTO BANK_MICR_FORMAT VALUES ('3756403932','BOAII','BDF046','PART2','0000XXXX',':540900071:','375 190 5817<','09-FEB-2016',NULL,NULL,'LXB8VR',TRUNC(SYSDATE),'INITLOAD',24);
INSERT INTO BANK_MICR_FORMAT VALUES ('840035147','FIRFIN','BDF402','PART2','0000XXXX',':XXXXXXXXX:',' XXXXXXXXX<','25-FEB-2016',NULL,NULL,'LXB8VR',TRUNC(SYSDATE),'INITLOAD',2);

/*
--validation script
        SELECT *
          FROM BANK_MICR_FORMAT
         WHERE (BANK_ACCOUNT_NBR, FORMAT_NAME) IN (SELECT BANK_ACCOUNT_NBR, COST_CENTER_CODE
                                                     FROM ERROR_LOG
                                                    WHERE TABLE_NAME LIKE 'BANK_MICR_FORMAT%'
                                                      AND ERROR_TEXT <> 'Bank Account Number not found for effective date');

        SELECT *
          FROM BANK_MICR_FORMAT_HIST
         WHERE (BANK_ACCOUNT_NBR, FORMAT_NAME) IN (SELECT BANK_ACCOUNT_NBR, COST_CENTER_CODE
                                                     FROM ERROR_LOG
                                                    WHERE TABLE_NAME LIKE 'BANK_MICR_FORMAT%'
                                                      AND ERROR_TEXT <> 'Bank Account Number not found for effective date');
*/

/*
--Take below query data backup
SELECT * FROM BANK_DEP_TICK ORDER BY COST_CENTER_CODE;
SELECT * FROM BANK_DEP_TICK_FUTURE ORDER BY COST_CENTER_CODE;
SELECT * FROM BANK_DEP_BAG_TICK ORDER BY COST_CENTER_CODE;
SELECT * FROM BANK_DEP_BAG_TICK_FUTURE ORDER BY COST_CENTER_CODE;

*/

UPDATE BANK_DEP_TICK SET REORDER_POINT = 42;
UPDATE BANK_DEP_TICK_FUTURE SET REORDER_POINT = 42;

UPDATE BANK_DEP_BAG_TICK SET DEP_BAG_REORDER_POINT = 21;
UPDATE BANK_DEP_BAG_TICK_FUTURE SET DEP_BAG_REORDER_POINT = 21;

COMMIT;
