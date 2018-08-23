/*
This is script to update the "TERMINAL" table POS_LAST_TRAN_DATE, POS_LAST_TRAN_NUMBER, POS_VERSION_NBR fields.
created  : 08/21/2018 sxg151 CCN project.... ASP-1122

*/

--CREATE a TEMP "TERMINAL_TEMP" TABLE TO IMPORT THE DATA FROM Excel

CREATE TABLE TERMINAL_TEMP
   (COST_CENTER_CODE VARCHAR2(6), 
    COST_CENTER_NAME VARCHAR2(35),
	POS_TERM_NO      VARCHAR2(5), 
	STATUS_CODE      VARCHAR2(1), 
	DAD              VARCHAR2(10),
    MAX_TRAN_DT      DATE,
    TRAN_NO_LAST     VARCHAR(5)
   );

SELECT * FROM  TERMINAL_TEMP;

-- Import the data into TERMINAL_TEMP


-- Run the below anonymous block to update the TERMINAL Table.

DECLARE
CURSOR CUR IS
  SELECT COST_CENTER_CODE, 
         POS_TERM_NO,
         MAX_TRAN_DT, 
         TRAN_NO_LAST
    FROM TERMINAL_TEMP
    WHERE (COST_CENTER_CODE, POS_TERM_NO) IN (SELECT SUBSTR(COST_CENTER_CODE,3), TERMINAL_NUMBER 
                                                 FROM TERMINAL
                                                WHERE EXPIRATION_DATE IS NULL);

BEGIN
  FOR REC IN CUR LOOP      
      UPDATE TERMINAL
         SET POS_LAST_TRAN_DATE   = REC.MAX_TRAN_DT,
             POS_LAST_TRAN_NUMBER = REC.TRAN_NO_LAST
       WHERE SUBSTR(COST_CENTER_CODE,3) = REC.COST_CENTER_CODE
         AND TERMINAL_NUMBER            = REC.POS_TERM_NO
         AND EXPIRATION_DATE IS NULL;
         COMMIT;
  END LOOP;
  COMMIT;
END;

-- Drop Temp Table.

DROP TABLE TERMINAL_TEMP;