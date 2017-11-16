-- created by rxv940 on 11/16/2017
-- Run this in COSTCNTR 
-- This script creates a new column and uopdates it to 'Y' for all the records that
-- got changed prior to go live.


ALTER TABLE COST_CENTER ADD POS_DOWNLOAD_CC_IND VARCHAR2(1);

-- We diable the trigger and enable it so that audit table doesn't get filled up
ALTER TRIGGER TR_COST_CENTER_UPD DISABLE;


SET SERVEROUTPUT ON
BEGIN
FOR rec IN (SELECT COST_CENTER_CODE
              FROM COST_CENTER
             WHERE CLOSE_DATE IS NULL
               AND CATEGORY IN ('S', 'T')
               AND COST_CENTER_CODE NOT IN (SELECT DISTINCT SUBSTR(A.TRANSACTION_ID, 2, 6)
                                              FROM AUDIT_LOG A
                                             WHERE TABLE_NAME = 'COST_CENTER'
                                               AND TRUNC(TRANSACTION_DATE) >= '07-SEP-2017'
                                               AND NOT EXISTS (SELECT 1
                                                                 FROM AUDIT_LOG
                                                                WHERE TRANSACTION_ID = A.TRANSACTION_ID
                                                                  AND TABLE_NAME = 'COST_CENTER'
                                                                  AND TRUNC(TRANSACTION_DATE) < '07-SEP-2017'))) LOOP
    UPDATE COST_CENTER
       SET POS_DOWNLOAD_CC_IND = 'Y'
     WHERE COST_CENTER_CODE = rec.COST_CENTER_CODE;   
END LOOP;
COMMIT;
END;

ALTER TRIGGER TR_COST_CENTER_UPD ENABLE;

-- We do not want this field to go the sync process with Mainframe

INSERT INTO CCN_AUDIT_EXCLUDED_FIELDS VALUES ('COST_CENTER', 'POS_DOWNLOAD_CC_IND', 'Y');
COMMIT;