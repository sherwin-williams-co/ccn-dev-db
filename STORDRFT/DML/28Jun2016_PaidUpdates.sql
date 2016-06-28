/*---------------------------------------
Below script will manually mark the drafts as paid as per email sent by Christopher T. Greve

CC	    Draft	  Date	     Amt 
705436	1168-5	5/13/2016	 99,999.00 
707307	2283-2	5/18/2016	 10,985.99 
707080	1783-5	5/16/2016	 10,746.33 
708627	1014-2	5/13/2016	 4,716.34 
701151	8720-5	5/18/2016	 2,154.51 
701809	1811-2	5/27/2016	 1,198.37 
701030	3679-4	5/4/2016	 434.00 
705464	2928-3	5/27/2016	 383.39 
705398	1154-7	5/25/2016	 231.00 
705374	1198-5	5/3/2016	 250.00 


Created: 06/28/2016 vxv336
------------------------------------------*/

SELECT * FROM store_drafts WHERE check_serial_number = '0543611685';
UPDATE store_drafts SET pay_indicator = 'Y', paid_date = '13-MAY-2016', bank_paid_amount = 99999.00 WHERE check_serial_number = '0543611685';

SELECT * FROM store_drafts WHERE check_serial_number = '0730722832';
UPDATE store_drafts SET pay_indicator = 'Y', paid_date = '18-MAY-2016', bank_paid_amount = 10985.99 WHERE check_serial_number = '0730722832';

SELECT * FROM store_drafts WHERE check_serial_number = '0708017835';
UPDATE store_drafts SET pay_indicator = 'Y', paid_date = '16-MAY-2016', bank_paid_amount = 10746.33 WHERE check_serial_number = '0708017835';

SELECT * FROM store_drafts WHERE check_serial_number = '0862710142';
UPDATE store_drafts SET pay_indicator = 'Y', paid_date = '13-MAY-2016', bank_paid_amount = 4716.34  WHERE check_serial_number = '0862710142';

SELECT * FROM store_drafts WHERE check_serial_number = '0115187205';
UPDATE store_drafts SET pay_indicator = 'Y', paid_date = '18-MAY-2016', bank_paid_amount = 2154.51  WHERE check_serial_number = '0115187205';

SELECT * FROM store_drafts WHERE check_serial_number = '0180918112';
UPDATE store_drafts SET pay_indicator = 'Y', paid_date = '27-MAY-2016', bank_paid_amount = 1198.37  WHERE check_serial_number = '0180918112';

SELECT * FROM store_drafts WHERE check_serial_number = '0103036794';
UPDATE store_drafts SET pay_indicator = 'Y', paid_date = '04-MAY-2016', bank_paid_amount = 434.00   WHERE check_serial_number = '0103036794';

SELECT * FROM store_drafts WHERE check_serial_number = '0546429283';
UPDATE store_drafts SET pay_indicator = 'Y', paid_date = '27-MAY-2016', bank_paid_amount = 383.39   WHERE check_serial_number = '0546429283';

SELECT * FROM store_drafts WHERE check_serial_number = '0539811547';
UPDATE store_drafts SET pay_indicator = 'Y', paid_date = '25-MAY-2016', bank_paid_amount = 231.00   WHERE check_serial_number = '0539811547';

SELECT * FROM store_drafts WHERE check_serial_number = '0537411985';
UPDATE store_drafts SET pay_indicator = 'Y', paid_date = '03-MAY-2016', bank_paid_amount = 250.00   WHERE check_serial_number = '0537411985';

COMMIT;

