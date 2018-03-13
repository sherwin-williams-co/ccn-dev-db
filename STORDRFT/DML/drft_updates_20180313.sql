/*
Cost Center	Issue Date	Draft Number	Check Amount	Notes	            Paid Date
708506	    12/14/2017	1392-8	        18,150.95 	    Not Marked as Paid	12/15/2017
705239	    12/28/2017	7267-7	        18,018.12 	    Not Marked as Paid	1/10/2018
703171	    1/2/2018	4509-2	        9,722.36 	    Not Marked as Paid	1/5/2018
702845	    12/21/2017	6642-9	        2,480.00 	    Not Marked as Paid	12/21/2017
702845	    12/21/2017	6646-0	        2,168.00 	    Not Marked as Paid	12/21/2017
702845	    12/21/2017	6648-6	        3,608.00 	    Not Marked as Paid	12/21/2017
702233	    12/1/2018	5016-6	        8,133.19 	    Not Marked as Paid	12/2/2017
702335	    12/29/2017	6380-8	        7,073.30 	    Not Marked as Paid	1/5/2018
701222	    1/5/2018	1153-5	        6,045.84 	    Not Marked as Paid	1/10/2018
701648	    12/1/2017	1556-5	        5,350.00 	    Not Marked as Paid	12/2/2017
701911	    12/13/2017	2264-7	        4,960.24 	    Not Marked as Paid	1/9/2018
707385	    12/29/2018	3192-0	        4,782.30 	    Not Marked as Paid	1/11/2018
707704	    1/3/2018	3846-3	        3,266.28 	    Not Marked as Paid	1/9/2018
707588	    1/5/2018	6437-5	        2,855.78 	    Not Marked as Paid	1/10/2018
708570	    12/30/2017	3740-2	        2,461.53 	    Not Marked as Paid	1/11/2018
701214	    12/29/2017	5456-5	        1,500.57 	    Not Marked as Paid	1/11/2018
701214	    1/4/2018	5466-4	        584.80 	        Not Marked as Paid	1/10/2018
705338	    1/11/2018	4536-8	        1,584.82 	    Not Marked as Paid	1/19/2018
705336	    1/11/2018	8757-0	        1,348.46 	    Not Marked as Paid	1/19/2018
702263	    1/4/2018	8320-6	        862.62 	        Not Marked as Paid	1/10/2018
707465	    1/12/2018	7504-2	        628.20 	        Not Marked as Paid	1/19/2018
702595	    12/21/2017	1005-5	        367.76 	        Not Marked as Paid	1/11/2018
707706	    12/26/2017	1801-5	        277.00 	        Not Marked as Paid	1/5/2018
708665	    12/8/2017	1031-6	        185.00 	        Not Marked as Paid	1/22/2018
701691	    1/13/2018	1584-7	        177.99 	        Not Marked as Paid	1/19/2018

Script Name: drft_updates-20180313.sql
Created by : 03/13/2018 axt754 CCN PROJECT....
As per Email from Mary

*/

-- Update UNATTACHED_MNL_DRFT_DTL mark as paid with paid date
SELECT * FROM UNATTACHED_MNL_DRFT_DTL WHERE COST_CENTER_CODE = '708506' AND CHECK_SERIAL_NUMBER = '0850613928';

UPDATE UNATTACHED_MNL_DRFT_DTL
   SET PAID_DATE = '15-DEC-2017',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '708506'
   AND CHECK_SERIAL_NUMBER = '0850613928';

-- Update STORE_DRAFTS mark as paid with paid date
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '705239' AND CHECK_SERIAL_NUMBER = '0523972677';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '10-JAN-2018',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '705239'
   AND CHECK_SERIAL_NUMBER = '0523972677';
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '703171' AND CHECK_SERIAL_NUMBER = '0317145092';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '05-JAN-2018',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '703171'
   AND CHECK_SERIAL_NUMBER = '0317145092';
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '702845' AND CHECK_SERIAL_NUMBER = '0284566429';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '21-DEC-2017',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '702845'
   AND CHECK_SERIAL_NUMBER = '0284566429';
   
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '702845' AND CHECK_SERIAL_NUMBER = '0284566460';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '21-DEC-2017',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '702845'
   AND CHECK_SERIAL_NUMBER = '0284566460';
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '702845' AND CHECK_SERIAL_NUMBER = '0284566486';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '21-DEC-2017',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '702845'
   AND CHECK_SERIAL_NUMBER = '0284566486';
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '702233' AND CHECK_SERIAL_NUMBER = '0223350166';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '02-DEC-2017',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '702233'
   AND CHECK_SERIAL_NUMBER = '0223350166';
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '702335' AND CHECK_SERIAL_NUMBER = '0233563808';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '05-JAN-2018',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '702335'
   AND CHECK_SERIAL_NUMBER = '0233563808';
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '701222' AND CHECK_SERIAL_NUMBER = '0122211535';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '10-JAN-2018',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '701222'
   AND CHECK_SERIAL_NUMBER = '0122211535';
   
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '701648' AND CHECK_SERIAL_NUMBER = '0164815565';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '02-DEC-2017',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '701648'
   AND CHECK_SERIAL_NUMBER = '0164815565';
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '701911' AND CHECK_SERIAL_NUMBER = '0191122647';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '09-JAN-2018',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '701911'
   AND CHECK_SERIAL_NUMBER = '0191122647';
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '707385' AND CHECK_SERIAL_NUMBER = '0738531920';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '11-JAN-2018',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '707385'
   AND CHECK_SERIAL_NUMBER = '0738531920';
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '707704' AND CHECK_SERIAL_NUMBER = '0770438463';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '09-JAN-2018',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '707704'
   AND CHECK_SERIAL_NUMBER = '0770438463';
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '707588' AND CHECK_SERIAL_NUMBER = '0758864375';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '10-JAN-2018',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '707588'
   AND CHECK_SERIAL_NUMBER = '0758864375';
   
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '708570' AND CHECK_SERIAL_NUMBER = '0857037402';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '11-JAN-2018',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '708570'
   AND CHECK_SERIAL_NUMBER = '0857037402';
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '701214' AND CHECK_SERIAL_NUMBER = '0121454565';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '11-JAN-2018',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '701214'
   AND CHECK_SERIAL_NUMBER = '0121454565';
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '701214' AND CHECK_SERIAL_NUMBER = '0121454664';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '10-JAN-2018',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '701214'
   AND CHECK_SERIAL_NUMBER = '0121454664';
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '705338' AND CHECK_SERIAL_NUMBER = '0533845368';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '19-JAN-2018',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '705338'
   AND CHECK_SERIAL_NUMBER = '0533845368';
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '705336' AND CHECK_SERIAL_NUMBER = '0533687570';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '19-JAN-2018',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '705336'
   AND CHECK_SERIAL_NUMBER = '0533687570';
   
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '702263' AND CHECK_SERIAL_NUMBER = '0226383206';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '10-JAN-2018',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '702263'
   AND CHECK_SERIAL_NUMBER = '0226383206';
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '707465' AND CHECK_SERIAL_NUMBER = '0746575042';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '19-JAN-2018',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '707465'
   AND CHECK_SERIAL_NUMBER = '0746575042';
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '702595' AND CHECK_SERIAL_NUMBER = '0259510055';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '11-JAN-2018',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '702595'
   AND CHECK_SERIAL_NUMBER = '0259510055';
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '707706' AND CHECK_SERIAL_NUMBER = '0770618015';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '05-JAN-2018',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '707706'
   AND CHECK_SERIAL_NUMBER = '0770618015';
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '708665' AND CHECK_SERIAL_NUMBER = '0866510316';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '22-JAN-2018',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '708665'
   AND CHECK_SERIAL_NUMBER = '0866510316';
   
   
SELECT * FROM STORE_DRAFTS WHERE COST_CENTER_CODE = '701691' AND CHECK_SERIAL_NUMBER = '0169115847';

UPDATE STORE_DRAFTS    
   SET PAID_DATE = '19-JAN-2018',
       PAY_INDICATOR = 'Y',
       BANK_PAID_AMOUNT = DECODE(AMOUNT_CHANGE_DATE, NULL, ORIGINAL_NET_AMOUNT, NET_AMOUNT),
       GROSS_AMOUNT = NVL(GROSS_AMOUNT, ORIGINAL_NET_AMOUNT),
       NET_AMOUNT = NVL(NET_AMOUNT, ORIGINAL_NET_AMOUNT)
 WHERE COST_CENTER_CODE = '701691'
   AND CHECK_SERIAL_NUMBER = '0169115847';
   
COMMIT;