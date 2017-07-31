/*---------------------------------------
Below script will manually mark the drafts as paid as per email sent by Christopher T. Greve
Store	  Draft   Paid_date
708978	2350-0	6/5/2017
708978	2397-7	6/27/2017
708693	1054-0	6/27/2017
708693	1055-7	6/27/2017
707428	9364-7	6/28/2017  --PICKED_BY_1099_ON_DATE  01-JUN-2017, FNCL_SRVCS_SENT_DATE 01-JUL-2017
707385	2573-2	6/7/2017   --PICKED_BY_1099_ON_DATE  01-JUN-2017, FNCL_SRVCS_SENT_DATE 01-JUL-2017
701121	3770-8	6/12/2017  --PICKED_BY_1099_ON_DATE  01-JUN-2017, FNCL_SRVCS_SENT_DATE 01-JUL-2017
708663	2404-9	7/10/2017  --PICKED_BY_1099_ON_DATE  01-JUN-2017
Select * from STORE_DRAFTS where COST_CENTER_CODE = '708663' and DRAFT_NUMBER = '2404';
   Draft was already marked as paid and left as it is.(confrimed with chris)
707385	2573-2	6/5/2017   --PICKED_BY_1099_ON_DATE  01-JUN-2017, FNCL_SRVCS_SENT_DATE 01-JUL-2017
707428	9364-7	6/27/2017   --PICKED_BY_1099_ON_DATE  01-JUN-2017, FNCL_SRVCS_SENT_DATE 01-JUL-2017

All indicator marked as N besides open indicator
Created: 07/28/2017 nxk927
------------------------------------------*/

Select * from STORE_DRAFTS where COST_CENTER_CODE = '708978' and DRAFT_NUMBER = '2350';--23506
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '05-JUN-2017', 
       PAY_INDICATOR = 'Y', 
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT) 
 WHERE COST_CENTER_CODE = '708978' 
   AND CHECK_SERIAL_NUMBER = '0897823506';

Select * from STORE_DRAFTS where COST_CENTER_CODE = '708978' and DRAFT_NUMBER = '2397';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '27-JUN-2017', 
       PAY_INDICATOR = 'Y', 
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT) 
 WHERE COST_CENTER_CODE = '708978' 
   AND CHECK_SERIAL_NUMBER = '0897823977';

Select * from STORE_DRAFTS where COST_CENTER_CODE = '708693' and DRAFT_NUMBER = '1054';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '27-JUN-2017', 
       PAY_INDICATOR = 'Y', 
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT) 
 WHERE COST_CENTER_CODE = '708693' 
   AND CHECK_SERIAL_NUMBER = '0869310540';

Select * from STORE_DRAFTS where COST_CENTER_CODE = '708693' and DRAFT_NUMBER = '1055';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '27-JUN-2017', 
       PAY_INDICATOR = 'Y', 
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT) 
 WHERE COST_CENTER_CODE = '708693' 
   AND CHECK_SERIAL_NUMBER = '0869310557';

Select * from STORE_DRAFTS where COST_CENTER_CODE = '707428' and DRAFT_NUMBER = '9364';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '28-JUN-2017', 
       PAY_INDICATOR = 'Y', 
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT) 
 WHERE COST_CENTER_CODE = '707428' 
   AND CHECK_SERIAL_NUMBER = '0742893647';

Select * from STORE_DRAFTS where COST_CENTER_CODE = '707385' and DRAFT_NUMBER = '2573';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '07-JUN-2017', 
       PAY_INDICATOR = 'Y', 
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT) 
 WHERE COST_CENTER_CODE = '707385' 
   AND CHECK_SERIAL_NUMBER = '0738525732';

Select * from STORE_DRAFTS where COST_CENTER_CODE = '701121' and DRAFT_NUMBER = '3770';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '12-JUN-2017', 
       PAY_INDICATOR = 'Y', 
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT) 
 WHERE COST_CENTER_CODE = '701121' 
   AND CHECK_SERIAL_NUMBER = '0112137708';

Select * from STORE_DRAFTS where COST_CENTER_CODE = '707385' and DRAFT_NUMBER = '2573';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '05-JUN-2017', 
       PAY_INDICATOR = 'Y', 
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT) 
 WHERE COST_CENTER_CODE = '707385' 
   AND CHECK_SERIAL_NUMBER = '0738525732';

Select * from STORE_DRAFTS where COST_CENTER_CODE = '707428' and DRAFT_NUMBER = '9364';
UPDATE STORE_DRAFTS 
   SET PAID_DATE = '27-JUN-2017', 
       PAY_INDICATOR = 'Y', 
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT) 
 WHERE COST_CENTER_CODE = '707428' 
   AND CHECK_SERIAL_NUMBER = '0742893647';

COMMIT;

