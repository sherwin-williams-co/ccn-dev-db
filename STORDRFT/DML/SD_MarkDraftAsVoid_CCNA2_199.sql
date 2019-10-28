/*
Store Drafts mark draft as void request from Jeremy Howe on 10/24/2019

Created : 10/28/2019 axm868 CCN Project Team....CCNA2-199
Changed : 
*/
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER IN ('0730843406') ORDER BY 1;

UPDATE STORE_DRAFTS
   SET OPEN_INDICATOR = 'Y',--as VOID_DATE IS NULL AND STOP_PAY_DATE IS NULL
	   PAY_INDICATOR = 'N',--as PAID_DATE IS NULL
	   STOP_INDICATOR = 'N',--as STOP_PAY_DATE IS NULL
	   VOID_INDICATOR = 'N'--as VOID_DATE IS NULL
 WHERE CHECK_SERIAL_NUMBER = '0730843406';

SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER IN ('0730843406') ORDER BY 1;

COMMIT;

/*
Lower environment logs for syntax validation, as these drafts will never be in lower environments:
no rows selected
0 rows updated.
no rows selected
committed.
*/