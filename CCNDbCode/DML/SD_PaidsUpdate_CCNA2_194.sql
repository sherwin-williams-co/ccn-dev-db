/*
Store Drafts paids update request from Lee Niedenthal on 10/08/2019

Created : 10/08/2019 axm868 CCN Project Team....CCNA2-194
Changed : 
*/
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER IN ('0893510743','0893510727') ORDER BY 1;

UPDATE STORE_DRAFTS
   SET PAID_DATE                  = '20-SEP-2019',
       PAY_INDICATOR              = 'Y',
       BANK_PAID_AMOUNT           = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0893510743';

UPDATE STORE_DRAFTS
   SET PAID_DATE                  = '09-SEP-2019',
       PAY_INDICATOR              = 'Y',
       BANK_PAID_AMOUNT           = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0893510727';

SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER IN ('0893510743','0893510727') ORDER BY 1;

COMMIT;

/*
Lower environment logs for syntax validation, as these drafts will never be in lower environments:
no rows selected
0 rows updated.
0 rows updated.
no rows selected
committed.
*/