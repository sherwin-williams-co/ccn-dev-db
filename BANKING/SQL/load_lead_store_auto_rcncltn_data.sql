/*******************************************************************
  This script will load data in LEAD_STORE_AUTO_RCNCLTN_DATA table.
  The script will load the data for leads/independent stores that are having 
  auto-reconciliation set to "Y".

Created : gxg192 01/23/2017
Modified: gxg192 01/25/2017 1. Changes to use delete statement instead of truncate
                            2. Changes to use cursor instead of block insert
                            3. Changes to handle exception.
        : kxm302 11/12/2018 CCN Project Team...
        : Include only current transactions for LEAD_BANK_CC and BANK_ACCOUNT ASP-1163
********************************************************************/
DECLARE

   CURSOR lead_store_auto_rcncltn_cur
   IS
   SELECT L.LEAD_BANK_ACCOUNT_NBR,
          L.LEAD_STORE_NBR,
          L.EFFECTIVE_DATE,
          L.EXPIRATION_DATE,
          L.BANK_BRANCH_NBR,
          L.BANK_TYPE_CODE
     FROM LEAD_BANK_CC L, BANK_ACCOUNT B
    WHERE L.LEAD_BANK_ACCOUNT_NBR = B.BANK_ACCOUNT_NBR
      AND B.BANK_AUTO_RECON_IND = 'Y'
      AND L.EFFECTIVE_DATE <= TRUNC(SYSDATE);


   V_ERROR_FLAG     VARCHAR2(1) := 'N';

BEGIN

   --Deleting all the records before loading the table.
   DELETE FROM LEAD_STORE_AUTO_RCNCLTN_DATA;

   dbms_output.put_line('All records from LEAD_STORE_AUTO_RCNCLTN_DATA Table deleted successfully.');

   FOR lead_store_auto_rcncltn_rec IN lead_store_auto_rcncltn_cur
   LOOP
      BEGIN

         INSERT INTO LEAD_STORE_AUTO_RCNCLTN_DATA
                                    ( LEAD_BANK_ACCOUNT_NBR,
                                      LEAD_STORE_NBR,
                                      EFFECTIVE_DATE,
                                      EXPIRATION_DATE,
                                      BANK_BRANCH_NBR,
                                      BANK_TYPE_CODE,
                                      LOAD_DATE )
         VALUES( lead_store_auto_rcncltn_rec.LEAD_BANK_ACCOUNT_NBR,
                 lead_store_auto_rcncltn_rec.LEAD_STORE_NBR,
                 lead_store_auto_rcncltn_rec.EFFECTIVE_DATE,
                 lead_store_auto_rcncltn_rec.EXPIRATION_DATE,
                 lead_store_auto_rcncltn_rec.BANK_BRANCH_NBR,
                 lead_store_auto_rcncltn_rec.BANK_TYPE_CODE,
                 SYSDATE );
      EXCEPTION
         WHEN OTHERS THEN
            dbms_output.put_line('Inserting data FAILED for BANK_ACCOUNT_NBR: '|| lead_store_auto_rcncltn_rec.LEAD_BANK_ACCOUNT_NBR||
                                  ' LEAD_STORE_NBR: '|| lead_store_auto_rcncltn_rec.LEAD_STORE_NBR||
                                  ' Error: '||SQLCODE || ' ' || SUBSTR(SQLERRM,1,500));
            V_ERROR_FLAG := 'Y';
      END;
   END LOOP;

   IF V_ERROR_FLAG = 'Y' THEN
       dbms_output.put_line('Loading data in LEAD_STORE_AUTO_RCNCLTN_DATA Table FAILED.');
       ROLLBACK;
       :exitcode := 2;
   ELSE
       dbms_output.put_line('Data loaded successfully in LEAD_STORE_AUTO_RCNCLTN_DATA Table.');
       COMMIT;
   END IF;

EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line('Error in load_lead_store_auto_rcncltn_data process - '|| SQLCODE || ' ' || SUBSTR(SQLERRM,1,500));
      ROLLBACK;
      :exitcode := 2; 
END;
/

