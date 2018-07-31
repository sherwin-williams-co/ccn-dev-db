/*
Created : 07/31/2018 nxk927
          Data fix for Linda for the issue related to Make lead process.
          As per discussion with linda, this script has to be executed in production on 1st AUG by end of the day.
*/


SELECT * FROM BANK_DEP_TICK WHERE SUBSTR(COST_CENTER_CODE,3) IN ('2255','2111','2481','2589','2919','3002','3488','4301','8078','7007');
INSERT INTO BANK_DEP_TICK_HIST
SELECT * 
  FROM BANK_DEP_TICK WHERE SUBSTR(COST_CENTER_CODE,3) IN ('2255','2111','2481','2589','2919','3002','3488','4301','8078','7007');

UPDATE BANK_DEP_TICK
   SET EFFECTIVE_DATE = '02-AUG-2018',
       BANK_ACCOUNT_NBR = '4172585374'
       EXPIRATION_DATE = NULL
 WHERE SUBSTR(COST_CENTER_CODE,3) IN ('2255','2111','2481','2589','2919','3002','3488','4301','8078');
 
UPDATE BANK_DEP_TICK
   SET EFFECTIVE_DATE = '02-AUG-2018',
       EXPIRATION_DATE = NULL
       BANK_ACCOUNT_NBR = '121663871'
 WHERE SUBSTR(COST_CENTER_CODE,3) = 7007';

SELECT * FROM BANK_DEP_TICK_FUTURE WHERE SUBSTR(COST_CENTER_CODE,3) IN ('2255','2111','2481','2589','2919','3002','3488','4301','8078','7007');
DELETE FROM BANK_DEP_TICK_FUTURE WHERE SUBSTR(COST_CENTER_CODE,3) IN ('2255','2111','2481','2589','2919','3002','3488','4301','8078','7007');

SELECT * FROM BANK_DEP_BAG_TICK WHERE SUBSTR(COST_CENTER_CODE,3) IN ('2255','2111','2481','2589','2919','3002','3488','4301','8078','7007');
UPDATE BANK_DEP_BAG_TICK 
   SET EXPIRATION_DATE = NULL,
       BANK_ACCOUNT_NBR = '4172585374'
 WHERE SUBSTR(COST_CENTER_CODE,3) IN ('2255','2111','2481','2589','2919','3002','3488','4301','8078');
 
 UPDATE BANK_DEP_BAG_TICK 
   SET EXPIRATION_DATE = NULL,
       BANK_ACCOUNT_NBR = '121663871'
 WHERE SUBSTR(COST_CENTER_CODE,3) ='7007';

SELECT * FROM BANK_DEP_BAG_TICK_FUTURE WHERE SUBSTR(COST_CENTER_CODE,3) IN ('2255','2111','2481','2589','2919','3002','3488','4301','8078','7007');
DELETE FROM BANK_DEP_BAG_TICK_FUTURE WHERE SUBSTR(COST_CENTER_CODE,3) IN ('2255','2111','2481','2589','2919','3002','3488','4301','8078','7007');

SELECT * FROM MEMBER_BANK_CC WHERE SUBSTR(MEMBER_STORE_NBR,3) IN ('2255','2111','2481','2589','2919','3002','3488','4301','8078','7007');
UPDATE MEMBER_BANK_CC 
   SET EFFECTIVE_DATE = '02-AUG-2018'
 WHERE SUBSTR(MEMBER_STORE_NBR,3) IN ('2255','2111','2481','2589','2919','3002','3488','4301','8078','7007')
   AND EXPIRATION_DATE IS NULL;

SELECT * FROM MEMBER_BANK_CC_FUTURE WHERE SUBSTR(MEMBER_STORE_NBR,3) IN ('2255','2111','2481','2589','2919','3002','3488','4301','8078','7007');
DELETE FROM MEMBER_BANK_CC_FUTURE WHERE SUBSTR(MEMBER_STORE_NBR,3) IN ('2255','2111','2481','2589','2919','3002','3488','4301','8078','7007');


COMMIT;