/*********************************************************************************
   This script is for updating the transaction timestamp to SYSTIMESTAMP after creating manual entries
   
   created : 01/22/2019  pxa852 CCN Project
*********************************************************************************/
SELECT COUNT(*) FROM customer_deposit_details WHERE NOTES = 'Offset of original transaction number' AND TRANSACTION_TYPE='MANUAL';

UPDATE customer_deposit_details
  SET TRAN_TIMESTAMP = SYSTIMESTAMP
 WHERE NOTES = 'Offset of original transaction number'
   AND TRANSACTION_TYPE='MANUAL'
   AND CUSTOMER_ACCOUNT_NUMBER IN ('100708320',
                                   '423907393',
                                   '342208998',
                                   '424840478',
                                   '657373296',
                                   '320295165',
                                   '536128291',
                                   '215446162',
                                   '532098969',
                                   '100953926',
                                   '653390823',
                                   '539432526',
                                   '657074878',
                                   '420151755',
                                   '578231128',
                                   '661689034',
                                   '665997243',
                                   '343398269',
                                   '423879972',
                                   '671223964',
                                   '920991411',
                                   '332980218',
                                   '217869403',
                                   '532894623',
                                   '421452921',
                                   '536935497',
                                   '293860144');

SELECT COUNT(*) FROM customer_deposit_details WHERE NOTES = 'Offset of original transaction number' AND TRANSACTION_TYPE='MANUAL';