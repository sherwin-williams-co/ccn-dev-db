/*
Below scripts are used to clean up the data that we inserted for DEPOSIT_TICKET initload
that brought up additional formats that are not valid

Created : 11/29/2016 jxc517 CCN Project Team....
*/

--run below 2 scripts ot get the backup of the records that are going to be deleted
SELECT */*insert*/
  FROM BANK_MICR_FORMAT
 WHERE (BANK_ACCOUNT_NBR, FORMAT_NAME) NOT IN (SELECT DISTINCT BANK_ACCOUNT_NBR, FORMAT_NAME
                                                 FROM TEMP_MICR_FORMAT)
 ORDER BY BANK_ACCOUNT_NBR, FORMAT_NAME;

SELECT */*insert*/
  FROM STORE_MICR_FORMAT_DTLS
 WHERE (BANK_ACCOUNT_NBR, MICR_FORMAT_ID) IN (SELECT BANK_ACCOUNT_NBR, MICR_FORMAT_ID
                                                FROM BANK_MICR_FORMAT
                                               WHERE (BANK_ACCOUNT_NBR, FORMAT_NAME) NOT IN (SELECT DISTINCT BANK_ACCOUNT_NBR, FORMAT_NAME
                                                                                               FROM TEMP_MICR_FORMAT))
ORDER BY BANK_ACCOUNT_NBR, MICR_FORMAT_ID;

SET SERVEROUTPUT ON;
BEGIN
    FOR rec IN (SELECT *
                 FROM BANK_MICR_FORMAT
                WHERE (BANK_ACCOUNT_NBR, FORMAT_NAME) NOT IN (SELECT DISTINCT BANK_ACCOUNT_NBR, FORMAT_NAME
                                                                FROM TEMP_MICR_FORMAT)
                ORDER BY BANK_ACCOUNT_NBR, FORMAT_NAME) LOOP
        DELETE FROM STORE_MICR_FORMAT_DTLS
         WHERE MICR_FORMAT_ID   = rec.MICR_FORMAT_ID
           AND BANK_ACCOUNT_NBR = rec.BANK_ACCOUNT_NBR;

        DELETE FROM BANK_MICR_FORMAT
         WHERE MICR_FORMAT_ID   = rec.MICR_FORMAT_ID
           AND BANK_ACCOUNT_NBR = rec.BANK_ACCOUNT_NBR;
    END LOOP;
END;
/

--commit only after validating the data
COMMIT;
