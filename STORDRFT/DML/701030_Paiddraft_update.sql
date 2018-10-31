/*---------------------------------------
Below script will manually mark the drafts as paid as per email sent by Marissa Papas
Store	Draft	Paid Date
1030   3890-7 - Reverse stop payment and Mark as paid (4/18/18)

Created: 10/31/2018 sxg151
------------------------------------------*/

-- reverse Stop Payment and Mark as paid.


SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER = '0103038907';

UPDATE STORE_DRAFTS 
   SET PAID_DATE = '18-APR-2018', 
       PAY_INDICATOR = 'Y',
       OPEN_INDICATOR = 'Y',
       STOP_INDICATOR = 'N',
       STOP_PAY_MARKED_BY_CCN_IND = NULL,
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT), 
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT), 
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT),
       STOP_PAY_DATE = NULL
 WHERE CHECK_SERIAL_NUMBER = '0103038907';
 
 COMMIT;
 