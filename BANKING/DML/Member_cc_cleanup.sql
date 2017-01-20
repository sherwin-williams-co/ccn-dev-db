/*
Created : 01/18/2017 nxk927 CCN Project Team....
          This script will delete all the concertration from the
          banking which are not present in the cost center database

*/
SET SERVEROUTPUT ON;
DECLARE
V_COUNT NUMBER:= 0;
BEGIN
   FOR REC IN (SELECT *
                 FROM MEMBER_BANK_CC_FUTURE
                WHERE SUBSTR(MEMBER_STORE_NBR,3) NOT IN (SELECT SUBSTR(COST_CENTER_CODE,3)
                                                           FROM COST_CENTER)) LOOP
       DELETE FROM STORE_MICR_FORMAT_DTLS_FUTURE WHERE COST_CENTER_CODE = REC.MEMBER_STORE_NBR;
       DELETE FROM BANK_DEP_BAG_TICKORD_FUTURE WHERE COST_CENTER_CODE = REC.MEMBER_STORE_NBR;
       DELETE FROM BANK_DEP_BAG_TICK_FUTURE WHERE COST_CENTER_CODE = REC.MEMBER_STORE_NBR;
       DELETE FROM BANK_DEP_TICKORD_FUTURE WHERE COST_CENTER_CODE = REC.MEMBER_STORE_NBR;
       DELETE FROM BANK_DEP_TICK_FUTURE WHERE COST_CENTER_CODE = REC.MEMBER_STORE_NBR;
       DELETE FROM MEMBER_BANK_CC_FUTURE WHERE MEMBER_STORE_NBR = REC.MEMBER_STORE_NBR;
   END LOOP;
   COMMIT;
   FOR REC IN (SELECT * FROM LEAD_BANK_CC_FUTURE) LOOP
       SELECT COUNT(*)
         INTO V_COUNT
         FROM MEMBER_BANK_CC
        WHERE LEAD_STORE_NBR = REC.LEAD_STORE_NBR
          AND EFFECTIVE_DATE >= TRUNC(SYSDATE);
       IF V_COUNT = 0 THEN
          DELETE FROM STORE_MICR_FORMAT_DTLS_FUTURE WHERE COST_CENTER_CODE = REC.LEAD_STORE_NBR AND FUTURE_ID = REC.FUTURE_ID;
          DELETE FROM BANK_DEP_BAG_TICKORD_FUTURE WHERE BANK_ACCOUNT_NBR = REC.LEAD_BANK_ACCOUNT_NBR AND FUTURE_ID = REC.FUTURE_ID;
          DELETE FROM BANK_DEP_BAG_TICK_FUTURE WHERE BANK_ACCOUNT_NBR = REC.LEAD_BANK_ACCOUNT_NBR AND FUTURE_ID = REC.FUTURE_ID;
          DELETE FROM BANK_DEP_TICKORD_FUTURE WHERE BANK_ACCOUNT_NBR = REC.LEAD_BANK_ACCOUNT_NBR AND FUTURE_ID = REC.FUTURE_ID;
          DELETE FROM BANK_DEP_TICK_FUTURE WHERE BANK_ACCOUNT_NBR = REC.LEAD_BANK_ACCOUNT_NBR AND FUTURE_ID = REC.FUTURE_ID;
          DELETE FROM MEMBER_BANK_CC_FUTURE WHERE LEAD_STORE_NBR = REC.LEAD_STORE_NBR AND FUTURE_ID = REC.FUTURE_ID;
          DELETE FROM LEAD_BANK_CC_FUTURE WHERE LEAD_STORE_NBR = REC.LEAD_STORE_NBR AND FUTURE_ID = REC.FUTURE_ID;
          DELETE FROM BANK_MICR_FORMAT_FUTURE WHERE BANK_ACCOUNT_NBR = REC.LEAD_BANK_ACCOUNT_NBR AND FUTURE_ID = REC.FUTURE_ID;
          DELETE FROM BANK_ACCOUNT_FUTURE WHERE BANK_ACCOUNT_NBR = REC.LEAD_BANK_ACCOUNT_NBR AND FUTURE_ID = REC.FUTURE_ID;
       END IF;
   END LOOP;
   COMMIT;
   FOR REC IN (SELECT *
                 FROM MEMBER_BANK_CC
                WHERE SUBSTR(MEMBER_STORE_NBR,3) NOT IN (SELECT SUBSTR(COST_CENTER_CODE,3)
                                                           FROM COST_CENTER)) LOOP
       DELETE FROM STORE_MICR_FORMAT_DTLS WHERE COST_CENTER_CODE = REC.MEMBER_STORE_NBR;
       DELETE FROM BANK_DEP_TICKORD WHERE COST_CENTER_CODE = REC.MEMBER_STORE_NBR;
       DELETE FROM BANK_DEP_BAG_TICKORD WHERE COST_CENTER_CODE = REC.MEMBER_STORE_NBR;
       DELETE FROM BANK_DEP_TICK WHERE COST_CENTER_CODE = REC.MEMBER_STORE_NBR;
       DELETE FROM BANK_DEP_BAG_TICK WHERE COST_CENTER_CODE = REC.MEMBER_STORE_NBR;
       DELETE FROM MEMBER_BANK_CC WHERE MEMBER_STORE_NBR = REC.MEMBER_STORE_NBR;
   END LOOP;
   FOR REC IN (SELECT *
                 FROM MEMBER_BANK_CC_HIST
                WHERE SUBSTR(MEMBER_STORE_NBR,3) NOT IN (SELECT SUBSTR(COST_CENTER_CODE,3)
                                                           FROM COST_CENTER)) LOOP
       DELETE FROM STORE_MICR_FORMAT_DTLS_HIST WHERE COST_CENTER_CODE = REC.MEMBER_STORE_NBR;
       DELETE FROM BANK_DEP_TICKORD_HIST WHERE COST_CENTER_CODE = REC.MEMBER_STORE_NBR;
       DELETE FROM BANK_DEP_BAG_TICKORD_HIST WHERE COST_CENTER_CODE = REC.MEMBER_STORE_NBR;
       DELETE FROM BANK_DEP_TICK_HIST WHERE COST_CENTER_CODE = REC.MEMBER_STORE_NBR;
       DELETE FROM BANK_DEP_BAG_TICK_HIST WHERE COST_CENTER_CODE = REC.MEMBER_STORE_NBR;
       DELETE FROM MEMBER_BANK_CC_HIST WHERE MEMBER_STORE_NBR = REC.MEMBER_STORE_NBR;
   END LOOP;
   COMMIT;
END;

/