/*
Below script will remvoe prime sub account 1693107 from primesub downloads

Created : 10/2/2018 jxc517 CCN Project Team ....
Changed :
*/
SELECT * FROM GENERAL_LEDGER_ACCOUNTS WHERE GL_ACCOUNT_NUMBER = '1693107';
--1 Row(s) Selected
UPDATE GENERAL_LEDGER_ACCOUNTS SET EXPIRATION_DATE = TRUNC(SYSDATE) WHERE GL_ACCOUNT_NUMBER = '1693107';
--1 Row(s) Updated
SELECT * FROM GENERAL_LEDGER_ACCOUNTS WHERE GL_ACCOUNT_NUMBER = '1693107';
--1 Row(s) Selected

EXEC PRIME_SUB_PROCESS.POS_TRG_EVENT_LOG('1693107', 'GENERAL_LEDGER_ACCOUNTS', 'CHANGE', 'POS_PRIMESUB_UPDATE' );

COMMIT;
