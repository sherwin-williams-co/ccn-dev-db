/*
Store Drafts paids update request from Lee Niedenthal on 11/07/2019

Created : 11/07/2019 axm868 CCN Project Team....CCNA2-212
Changed : 
*/
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER IN ('0893510768','0893510776') ORDER BY 1;

UPDATE STORE_DRAFTS
   SET PAID_DATE                  = '04-OCT-2019',
       PAY_INDICATOR              = 'Y',
       BANK_PAID_AMOUNT           = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0893510768';

UPDATE STORE_DRAFTS
   SET PAID_DATE                  = '22-OCT-2019',
       PAY_INDICATOR              = 'Y',
       BANK_PAID_AMOUNT           = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT)
 WHERE CHECK_SERIAL_NUMBER = '0893510776';

SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER IN ('0893510768','0893510776') ORDER BY 1;

COMMIT;

/*
Lower environment logs for syntax validation, as these drafts will never be in lower environments:
no rows selected
0 rows updated.
0 rows updated.
no rows selected
committed.
*/