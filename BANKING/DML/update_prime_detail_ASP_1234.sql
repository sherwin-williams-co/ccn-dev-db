/*
This script will update TCODE prime-sub details update as per Linda
Create : sxg151 03/25/2019 CCN Team...
       : ASP-1234
*/
SELECT * FROM PRIME_SUB_DETAIL WHERE TCODE = '2897' ORDER BY DB_CR_CODE;

UPDATE PRIME_SUB_DETAIL
   SET PRIME_SUB = '7405004'
 WHERE TCODE = '2897'
   AND DB_CR_CODE = 'OC';

UPDATE PRIME_SUB_DETAIL
   SET PRIME_SUB = '0120001'
 WHERE TCODE = '2897'
   AND DB_CR_CODE = 'OD';

SELECT * FROM PRIME_SUB_DETAIL WHERE TCODE = '2897' ORDER BY DB_CR_CODE;

COMMIT;