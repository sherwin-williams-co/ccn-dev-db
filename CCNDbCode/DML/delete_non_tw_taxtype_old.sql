/*
This script deletes data from code Header and code Detail tables since Header name has changed to NON_TAXWARE_TYPES

Created : 01/08/2018 axt754 CCN Project Team....
Changed :
*/

SELECT * FROM CODE_DETAIL WHERE CODE_HEADER_NAME = 'NON_TW_TAXTYPE';

DELETE FROM CODE_DETAIL WHERE CODE_HEADER_NAME = 'NON_TW_TAXTYPE';

SELECT * FROM CODE_HEADER WHERE CODE_HEADER_NAME = 'NON_TW_TAXTYPE';

DELETE FROM CODE_HEADER WHERE CODE_HEADER_NAME = 'NON_TW_TAXTYPE';