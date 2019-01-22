/*********************************************************************************
   This script is for updating the transaction timestamp  in credit and redemption details table
   for manual entries
   
   created : 01/22/2019  pxa852 CCN Project
*********************************************************************************/
DECLARE
--variable declaration
   CURSOR TEMP_CUR IS
      SELECT a.*, rowid
        FROM CUSTOMER_DEPOSIT_DETAILS a
       WHERE a.TRANSACTION_TYPE='MANUAL'
         AND a.NOTES  = 'Offset of original transaction number'
        ORDER BY CUSTOMER_ACCOUNT_NUMBER, TRAN_TIMESTAMP;

   --variable declaration
   V_COMMIT         NUMBER := 0;
   V_CUM_AMT        NUMBER := 0;
BEGIN
   FOR REC IN TEMP_CUR LOOP
      BEGIN
             UPDATE CUSTOMER_DEPOSIT_DETAILS
                SET TRAN_TIMESTAMP = SYSTIMESTAMP
               WHERE ROWID = REC.rowid;

         V_COMMIT := V_COMMIT + 1;
         IF V_COMMIT > 500 THEN
            COMMIT;
            V_COMMIT := 0;
         END IF;
      EXCEPTION
         WHEN OTHERS THEN
              ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE, 'Manuals timestamp update - ' || TRUNC(SYSDATE), SQLERRM, '000000', '000000000', '000000000');
      END;
   END LOOP;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE, 'Manuals timestamp Update - ' || TRUNC(SYSDATE), SQLERRM, '000000', '000000000', '000000000');
END;