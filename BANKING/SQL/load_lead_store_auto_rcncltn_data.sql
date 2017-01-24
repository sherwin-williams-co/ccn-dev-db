/*******************************************************************
  This script will load data in LEAD_STORE_AUTO_RCNCLTN_DATA table.
  The script will load the data for leads/independent stores that are having 
  auto-reconciliation set to "Y".

Created : gxg192 01/23/2017
Modified: 
********************************************************************/

BEGIN

   EXECUTE IMMEDIATE 'TRUNCATE TABLE LEAD_STORE_AUTO_RCNCLTN_DATA';
   
   dbms_output.put_line('LEAD_STORE_AUTO_RCNCLTN_DATA Table truncated successfully.');

   INSERT INTO LEAD_STORE_AUTO_RCNCLTN_DATA
                                ( LEAD_BANK_ACCOUNT_NBR,
                                  LEAD_STORE_NBR,
                                  EFFECTIVE_DATE,
                                  EXPIRATION_DATE,
                                  BANK_BRANCH_NBR,
                                  BANK_TYPE_CODE,
                                  LOAD_DATE )
   SELECT L.LEAD_BANK_ACCOUNT_NBR,
          L.LEAD_STORE_NBR,
          L.EFFECTIVE_DATE,
          L.EXPIRATION_DATE,
          L.BANK_BRANCH_NBR,
          L.BANK_TYPE_CODE,
          SYSDATE
     FROM LEAD_BANK_CC L, BANK_ACCOUNT B
    WHERE L.LEAD_BANK_ACCOUNT_NBR = B.BANK_ACCOUNT_NBR
      AND B.BANK_AUTO_RECON_IND = 'Y';

   dbms_output.put_line('Data loaded successfully in LEAD_STORE_AUTO_RCNCLTN_DATA Table.'); 
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      dbms_output.put_line('Error in load_lead_store_auto_rcncltn_data process - '|| SQLCODE || ' ' || SUBSTR(SQLERRM,1,500));
      :exitcode := 2; 
END;
/

