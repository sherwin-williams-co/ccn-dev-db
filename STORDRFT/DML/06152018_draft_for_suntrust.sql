/*
Created : nxk927 06/15/2018
          These below drafts were never sent to suntrust bank. 
          These records are being updated so that
          these will be sent in the maintainance file.
          Next day these days will be reverted back after sending these to the bank

          back up the data before executing the script.
          SELECT */*insert*/ FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER IN ('0284566585','0305442097','0284566577','0820012789','0284566569','0820012532','0847030657','0820012532');
*/

SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER IN ('0284566585','0305442097','0284566577','0820012789','0284566569','0820012532','0847030657','0820012532');

UPDATE STORE_DRAFTS
   SET CHANGE_DATE = TRUNC(SYSDATE),
       ISSUE_DATE = TRUNC(SYSDATE)
 WHERE CHECK_SERIAL_NUMBER IN ('0284566585','0305442097','0284566577','0820012789','0284566569','0820012532','0847030657','0820012532');

COMMIT;

/*
Run the update script on the  after sending the drafts
*/
SELECT * FROM STORE_DRAFTS WHERE CHECK_SERIAL_NUMBER IN ('0284566585','0305442097','0284566577','0820012789','0284566569','0820012532','0847030657','0820012532');

UPDATE STORE_DRAFTS
   SET ISSUE_DATE = '03-MAY-2018',
       CHANGE_DATE = NULL
 WHERE CHECK_SERIAL_NUMBER IN ('0284566569','0284566577','0284566585');


UPDATE STORE_DRAFTS
   SET ISSUE_DATE = '26-APR-2018',
       CHANGE_DATE = NULL
 WHERE CHECK_SERIAL_NUMBER = '0847030657';

UPDATE STORE_DRAFTS
   SET ISSUE_DATE = '07-JUN-2018',
       CHANGE_DATE = NULL
 WHERE CHECK_SERIAL_NUMBER = '0820012532';

UPDATE STORE_DRAFTS
   SET ISSUE_DATE = '08-JUN-2018',
       CHANGE_DATE = NULL
 WHERE CHECK_SERIAL_NUMBER IN ('0820012789','0305442097','0820012771');

COMMIT;