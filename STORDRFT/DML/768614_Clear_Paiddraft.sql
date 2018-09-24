/*---------------------------------------
Below script will clear the paid details.

Store
768614

Created: 09/21/2018 sxg151
------------------------------------------*/

SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '768614' AND CHECK_SERIAL_NUMBER = '0861410165';


UPDATE STORE_DRAFTS
   SET PAID_DATE           = NULL,
       PAY_INDICATOR       = 'N',
       BANK_PAID_AMOUNT    = NULL
 WHERE COST_CENTER_CODE    = '768614'
   AND CHECK_SERIAL_NUMBER = '0861410165';

COMMIT;