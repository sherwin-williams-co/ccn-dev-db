/* The script will Insert records in the new table customer_deposit_header
   all the run cycles from the go_live 
*/
CREATE TABLE CCN_HEADER AS
SELECT DISTINCT 
             ACCTNBR AS CUSTOMER_ACCOUNT_NUMBER,
             CUSTOMER_NAME,
             BILLNM,
             BILLCONTACT,
             BILLADDR1,
             BILLADDR2,
             BILLCITY,
             BILLZIP,
             BILLPHONE,
             RLS_RUN_CYCLE,
             H.TRAN_TIMESTAMP
        FROM PNP.CCN_HEADERS H
       WHERE EXISTS (SELECT 1
                        FROM PNP.CCN_SALES_LINES S
                       WHERE H.TRAN_GUID = S.TRAN_GUID
                         AND H.RLS_RUN_CYCLE = S.RLS_RUN_CYCLE
                         AND S.PRODUCT_CATEGORY_CODE = '36');
--create index 
CREATE INDEX CCN_HEADER_INDEX1 ON CCN_HEADER (CUSTOMER_ACCOUNT_NUMBER, RLS_RUN_CYCLE) ;                           
--Inserting into customer_deposit_header
SET SERVEROUTPUT ON;
DECLARE
PROCEDURE LOAD_CUSTOMER_DEPOSIT_HDR(
/*****************************************************************************
LOAD_CUSTOMER_DEPOSIT_HDR

This procedure will load the customer_deposit_header table from pnp legacy idms database.

created : 03/05/2018 sxh487 ccn project....
changed :
******************************************************************************/
IN_RLS_RUN_CYCLE POS_CSTMR_DEP_LOAD_STATUS.RLS_RUN_CYCLE%TYPE,
IN_CUSTOMER_ACCOUNT_NUMBER CUSTOMER_DEPOSIT_HEADER.CUSTOMER_ACCOUNT_NUMBER%TYPE)
IS

--variable declaration
V_DATE                       DATE := TRUNC(SYSDATE);

   CURSOR TEMP_CUR IS
      SELECT DISTINCT 
             CUSTOMER_ACCOUNT_NUMBER,
             CUSTOMER_NAME,
             BILLNM,
             BILLCONTACT,
             BILLADDR1,
             BILLADDR2,
             BILLCITY,
             BILLZIP,
             BILLPHONE,
             RLS_RUN_CYCLE,
             NULL AS LOAD_DATE,
             NULL AS CLEARED_REASON,
             NULL AS NOTES,
             NULL AS REFERENCE_NUMBER,
             TRAN_TIMESTAMP
        FROM CCN_HEADER H
       WHERE RLS_RUN_CYCLE = IN_RLS_RUN_CYCLE
         AND CUSTOMER_ACCOUNT_NUMBER = IN_CUSTOMER_ACCOUNT_NUMBER
         ORDER BY TRAN_TIMESTAMP ASC;

   --variable declaration
   V_COMMIT         NUMBER := 0;
   V_TEMP_ROW       CUSTOMER_DEPOSIT_HEADER%ROWTYPE;
BEGIN
   FOR REC IN TEMP_CUR LOOP
        V_TEMP_ROW.CUSTOMER_ACCOUNT_NUMBER  := REC.CUSTOMER_ACCOUNT_NUMBER;
        V_TEMP_ROW.CUSTOMER_NAME            := REC.CUSTOMER_NAME; 
        V_TEMP_ROW.BILLCONTACT              := REC.BILLCONTACT;
        V_TEMP_ROW.BILLNM                   := REC.BILLNM;
        V_TEMP_ROW.BILLADDR1                := REC.BILLADDR1;
        V_TEMP_ROW.BILLADDR2                := REC.BILLADDR2;
        V_TEMP_ROW.BILLCITY                 := REC.BILLCITY;
        V_TEMP_ROW.BILLZIP                  := REC.BILLZIP;
        V_TEMP_ROW.BILLPHONE                := REC.BILLPHONE;
        V_TEMP_ROW.RLS_RUN_CYCLE            := REC.RLS_RUN_CYCLE;
        V_TEMP_ROW.LOAD_DATE                := V_DATE;
        
        CUST_DEPOSIT_HEADER_I_SP(V_TEMP_ROW);    
        V_TEMP_ROW := NULL;
        V_COMMIT := V_COMMIT + 1;
        IF V_COMMIT > 500 THEN
           COMMIT;
           V_COMMIT := 0;
        END IF;
   END LOOP;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE,
                                    'LOAD_CUSTOMER_DEPOSIT_HDR',
                                    SQLERRM,
                                    '000000',
                                    '000000000',
                                    '000000000');
END LOAD_CUSTOMER_DEPOSIT_HDR;

BEGIN
  FOR each_rec IN (SELECT DISTINCT CUSTOMER_ACCOUNT_NUMBER,RLS_RUN_CYCLE  FROM CUSTOMER_DEPOSIT_DETAILS WHERE RLS_RUN_CYCLE IS NOT NULL order by RLS_RUN_CYCLE)LOOP
      LOAD_CUSTOMER_DEPOSIT_HDR( each_rec.RLS_RUN_CYCLE, each_rec.CUSTOMER_ACCOUNT_NUMBER);
  END LOOP;
END;
/
DROP TABLE CCN_HEADER;