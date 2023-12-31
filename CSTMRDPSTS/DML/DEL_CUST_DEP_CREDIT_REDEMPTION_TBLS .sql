/**********************************************************************************
This script is used to delete data from credit and redemption details tables for the account numbers provided by Joseph.
Created : 01/22/2019 pxa852 CCN Project Team....
Modified:
**********************************************************************************/
--Delete data from Credit and redemption details table
DELETE FROM CUST_DEP_CREDIT_DETAILS WHERE CUSTOMER_ACCOUNT_NUMBER IN ('100708320',
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
--Delete data from Redmeption details table
DELETE FROM CUST_DEP_REDEMPTION_DETAILS WHERE CUSTOMER_ACCOUNT_NUMBER IN ('100708320',
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
