/*******************************************************************************
This script will update the deposit remaining balance of a deposit and originals for redemption records in CUSTOMER_DEPOSIT_TRANSACTION_DTL table
CREATED : 02/12/2019 pxa852 CCN Project...
*******************************************************************************/
DECLARE
--variable declaration
   CURSOR TEMP_CUR IS
      SELECT *
        FROM CUSTOMER_DEPOSIT_TRANSACTION_DTL D
        ORDER BY D.CUSTOMER_ACCOUNT_NUMBER, D.TRANSACTION_DATE;

   --variable declaration
   V_COMMIT         NUMBER := 0;
   V_ORIG_DEP_NBR       CUSTOMER_DEPOSIT_TRANSACTION_DTL.ORGNL_DEPOSIT_TRANSACTION_NBR%TYPE;
   V_ORIG_TERM_NBR      CUSTOMER_DEPOSIT_TRANSACTION_DTL.ORGNL_DEPOSIT_TERMINAL_NBR%TYPE;
   V_ORIG_TRAN_DATE     CUSTOMER_DEPOSIT_TRANSACTION_DTL.ORGNL_DEPOSIT_TRANSACTION_DATE%TYPE;
   V_ORIGINAL_ACCOUNT_CLASSIFICATION  VARCHAR2(100);


PROCEDURE CUST_DEPOSIT_TRAN_DTLS_U_SP (
/*******************************************************************************
    This procedure is intended to updates records in CUSTOMER_DEPOSIT_TRANSACTION_DTL table

Created : 02/12/2019 CCN Project Team...
Changed : 
*******************************************************************************/
    IN_ROW IN     CUSTOMER_DEPOSIT_TRANSACTION_DTL%ROWTYPE)
IS
BEGIN
      UPDATE CUSTOMER_DEPOSIT_TRANSACTION_DTL
         SET row = IN_ROW
       WHERE CUST_DEP_TRANS_DETAIL_SEQ = IN_ROW.CUST_DEP_TRANS_DETAIL_SEQ;
EXCEPTION
    WHEN OTHERS THEN
        ERRPKG.RAISE_ERR(SQLCODE, 'CUST_DEPOSIT_TRAN_DTLS_U_SP', SUBSTR(SQLERRM,1,500));
END CUST_DEPOSIT_TRAN_DTLS_U_SP;

PROCEDURE CUST_DEPOSIT_TRAN_DTLS_I_SP(
/*******************************************************************************
CUST_DEPOSIT_TRAN_DTLS_I_SP

This procedure is intended to insert new CUSTOMER_DEPOSIT_TRANSACTION_DTL records
created : 02/12/2019 CCN Project Team...
changed :
*******************************************************************************/
    IN_CUST_DEP_CRD_RED_DET_rec   IN     CUSTOMER_DEPOSIT_TRANSACTION_DTL%ROWTYPE)
IS
BEGIN
   INSERT INTO CUSTOMER_DEPOSIT_TRANSACTION_DTL VALUES IN_CUST_DEP_CRD_RED_DET_rec;
   
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
       CUST_DEPOSIT_TRAN_DTLS_U_SP(IN_CUST_DEP_CRD_RED_DET_rec);
    WHEN OTHERS THEN
        ERRPKG.RAISE_ERR(SQLCODE, 'CUST_DEPOSIT_TRAN_DTLS_I_SP', SUBSTR(SQLERRM,1,500));
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END CUST_DEPOSIT_TRAN_DTLS_I_SP;
   
PROCEDURE GET_ORGNLS_FROM_POS(
/**********************************************************
This procedure will get the orginals from POS for a redemption
 
Created : 02/14/2019 pxa852
Changed :
**********************************************************/
    IN_CUST_DEP_ROW         IN      CUSTOMER_DEPOSIT_TRANSACTION_DTL%ROWTYPE,
    OUT_TRANSACTION_NUMBER    OUT  CUSTOMER_DEPOSIT_TRANSACTION_DTL.TRANSACTION_NUMBER%TYPE,
    OUT_TERMINAL_NUMBER       OUT  CUSTOMER_DEPOSIT_TRANSACTION_DTL.TERMINAL_NUMBER%TYPE,
    OUT_TRANSACTION_DATE      OUT  CUSTOMER_DEPOSIT_TRANSACTION_DTL.TRANSACTION_DATE%TYPE
)
IS
BEGIN
    SELECT ORIGDT,ORIGTERM, ORIGTRAN 
      INTO OUT_TRANSACTION_DATE, OUT_TERMINAL_NUMBER, OUT_TRANSACTION_NUMBER
      FROM CCN_HEADERS_T
     WHERE ACCTNBR        = IN_CUST_DEP_ROW.CUSTOMER_ACCOUNT_NUMBER
       AND TERMNBR        = IN_CUST_DEP_ROW.TERMINAL_NUMBER
       AND TRANNBR        = IN_CUST_DEP_ROW.TRANSACTION_NUMBER
       AND TRAN_DATE      = IN_CUST_DEP_ROW.TRANSACTION_DATE
       AND STORE_NO       = SUBSTR(IN_CUST_DEP_ROW.COST_CENTER_CODE, -4)
       AND ROWNUM < 2;
EXCEPTION
    WHEN OTHERS THEN
        OUT_TRANSACTION_NUMBER := NULL;
        OUT_TERMINAL_NUMBER    := NULL;
        OUT_TRANSACTION_DATE   := NULL;
END GET_ORGNLS_FROM_POS;

PROCEDURE GET_MANUAL_ORIGINALS(
/**********************************************************
This procedure will get the orginals from POS for a redemption
 
Created : 02/14/2019 pxa852
Changed :
**********************************************************/
    IN_CUST_DEP_ROW         IN      CUSTOMER_DEPOSIT_TRANSACTION_DTL%ROWTYPE,
    OUT_TRANSACTION_NUMBER    OUT  CUSTOMER_DEPOSIT_TRANSACTION_DTL.TRANSACTION_NUMBER%TYPE,
    OUT_TERMINAL_NUMBER       OUT  CUSTOMER_DEPOSIT_TRANSACTION_DTL.TERMINAL_NUMBER%TYPE,
    OUT_TRANSACTION_DATE      OUT  CUSTOMER_DEPOSIT_TRANSACTION_DTL.TRANSACTION_DATE%TYPE
)
IS
BEGIN
    SELECT TRANSACTION_DATE,TERMINAL_NUMBER, TRANSACTION_NUMBER
      INTO OUT_TRANSACTION_DATE, OUT_TERMINAL_NUMBER, OUT_TRANSACTION_NUMBER
      FROM CUSTOMER_DEPOSIT_TRANSACTION_DTL
     WHERE TRANSACTION_GUID = IN_CUST_DEP_ROW.TRANSACTION_GUID
       AND TRANSACTION_TYPE = 'MANUAL'
       AND CSTMR_DPST_SALES_LN_ITM_AMT > 0;
EXCEPTION
    WHEN OTHERS THEN
        OUT_TRANSACTION_NUMBER := NULL;
        OUT_TERMINAL_NUMBER    := NULL;
        OUT_TRANSACTION_DATE   := NULL;
END GET_MANUAL_ORIGINALS;

PROCEDURE CUST_DEP_REM_BAL_UPD(
/**********************************************************
This procedure updates the deposit remianing balance.
If a redmeption comes with originals, pass those original values to get the deposit record
and update the deposit remaining balance of that deposit.
 
Created : 02/13/2019 pxa852 CCN Project Team...
Changed :
**********************************************************/
    IN_ORGNL_TRAN_ROW    IN      CUSTOMER_DEPOSIT_TRANSACTION_DTL%ROWTYPE)
IS
BEGIN  
    --IN_ORGNL_TRAN_ROW.CSTMR_DPST_SALES_LN_ITM_AMT this value is negative, so we reduce deposit by that amount
    UPDATE CUSTOMER_DEPOSIT_TRANSACTION_DTL DTL
       SET DTL.DEPOSIT_REMAINING_BAL = DTL.CSTMR_DPST_SALES_LN_ITM_AMT + IN_ORGNL_TRAN_ROW.CSTMR_DPST_SALES_LN_ITM_AMT
     WHERE DTL.TRANSACTION_NUMBER = IN_ORGNL_TRAN_ROW.ORGNL_DEPOSIT_TRANSACTION_NBR
       AND DTL.TERMINAL_NUMBER    = IN_ORGNL_TRAN_ROW.ORGNL_DEPOSIT_TERMINAL_NBR
       AND DTL.TRANSACTION_DATE   = IN_ORGNL_TRAN_ROW.ORGNL_DEPOSIT_TRANSACTION_DATE
       AND DTL.CLOSED_DATE IS NULL;
EXCEPTION
   WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE,
                                    'CUST_DEP_REM_BAL_UPD',
                                    SQLERRM,
                                    '000000',
                                    '000000000',
                                    '000000000');
END CUST_DEP_REM_BAL_UPD;

FUNCTION GET_ORIGINAL_ACCOUNT_CLASSIFICATION (
/**********************************************************
This function will return 'Y' if original transaction (Deposit) account number matches with the redmeption account number.
Return 'N' if does not match the account number.
Return Null if it didnt find any record in deposit transaction details table for the original tarnsaction.

MATCH => input account number matches original transactions account number
MISMATCH => input account number does not matche original transactions account number
INVALID_TRANSACTION => original transaction not found

created : 02/12/2019 pxa852 CCN Project Team...
modified:
**********************************************************/
IN_CUSTOMER_ACCOUNT_NUMBER IN CUSTOMER_DEPOSIT_TRANSACTION_DTL.CUSTOMER_ACCOUNT_NUMBER%TYPE,
IN_ORGNL_TRAN_NBR          IN CUSTOMER_DEPOSIT_TRANSACTION_DTL.ORGNL_DEPOSIT_TRANSACTION_NBR%TYPE,
IN_ORGNL_TERM_NBR          IN CUSTOMER_DEPOSIT_TRANSACTION_DTL.ORGNL_DEPOSIT_TERMINAL_NBR%TYPE,
IN_ORGNL_TRAN_DT           IN CUSTOMER_DEPOSIT_TRANSACTION_DTL.ORGNL_DEPOSIT_TRANSACTION_DATE%TYPE)
RETURN VARCHAR2
IS
   V_RETURN_VALUE   VARCHAR2(100) := 'INVALID_TRANSACTION';
   V_ORGNL_ACCNT_NBR CUSTOMER_DEPOSIT_TRANSACTION_DTL.CUSTOMER_ACCOUNT_NUMBER%TYPE;
BEGIN
   SELECT CUSTOMER_ACCOUNT_NUMBER
     INTO V_ORGNL_ACCNT_NBR
     FROM CUSTOMER_DEPOSIT_TRANSACTION_DTL
    WHERE TERMINAL_NUMBER    = IN_ORGNL_TERM_NBR
      AND TRANSACTION_NUMBER = IN_ORGNL_TRAN_NBR
      AND TRANSACTION_DATE   = IN_ORGNL_TRAN_DT
      AND TRANSACTION_TYPE   <> 'MANUAL';

    IF V_ORGNL_ACCNT_NBR = IN_CUSTOMER_ACCOUNT_NUMBER THEN
    --retrun 'Y' if the original (deposit) and redemption has same account numbers
        V_RETURN_VALUE := 'MATCH';
    ELSE
        V_RETURN_VALUE := 'MISMATCH';
    END IF;
   RETURN V_RETURN_VALUE;
EXCEPTION
    WHEN OTHERS THEN
        -- return null if did find any record
        RETURN V_RETURN_VALUE;
END GET_ORIGINAL_ACCOUNT_CLASSIFICATION;

BEGIN
   FOR REC IN TEMP_CUR LOOP
      BEGIN
         IF REC.CSTMR_DPST_SALES_LN_ITM_AMT > 0 THEN
            REC.DEPOSIT_REMAINING_BAL          := CASE WHEN REC.TRANSACTION_TYPE = 'DEPOSIT' 
                                                       THEN REC.CSTMR_DPST_SALES_LN_ITM_AMT
                                                  ELSE 0
                                                  END;
            --inserting deposit record
            CUST_DEPOSIT_TRAN_DTLS_I_SP(REC);

          ELSIF REC.CSTMR_DPST_SALES_LN_ITM_AMT < 0 THEN
                IF REC.TRANSACTION_TYPE = 'MANUAL' THEN
                  V_ORIG_DEP_NBR   := REC.TRANSACTION_NUMBER;
                  V_ORIG_TERM_NBR  := REC.TERMINAL_NUMBER;
                  V_ORIG_TRAN_DATE := REC.TRANSACTION_DATE;
                ELSE
                   GET_MANUAL_ORIGINALS(REC,V_ORIG_DEP_NBR,V_ORIG_TERM_NBR,V_ORIG_TRAN_DATE);
                   IF V_ORIG_DEP_NBR IS NULL THEN
                      GET_ORGNLS_FROM_POS(REC,V_ORIG_DEP_NBR,V_ORIG_TERM_NBR,V_ORIG_TRAN_DATE);
                       --if redemption originals account not matches with the redemption account then writing the data to clob to generate a report
                      V_ORIGINAL_ACCOUNT_CLASSIFICATION := GET_ORIGINAL_ACCOUNT_CLASSIFICATION(REC.CUSTOMER_ACCOUNT_NUMBER,
                                                                                               V_ORIG_DEP_NBR,
                                                                                               V_ORIG_TERM_NBR,
                                                                                               V_ORIG_TRAN_DATE);
                      --The original valuesd will be null if V_ORIGINAL_ACCOUNT_CLASSIFICATION = INVALID_TRANSACTION
                      IF V_ORIGINAL_ACCOUNT_CLASSIFICATION = 'INVALID_TRANSACTION' THEN
                          --taking orginals from POS
                          V_ORIG_DEP_NBR   := NULL;
                          V_ORIG_TERM_NBR  := NULL;
                          V_ORIG_TRAN_DATE := NULL;
                      END IF;
                   END IF;
                END IF;
               
                  REC.ORGNL_DEPOSIT_TERMINAL_NBR     := V_ORIG_TERM_NBR;
                  REC.ORGNL_DEPOSIT_TRANSACTION_NBR  := V_ORIG_DEP_NBR;
                  REC.ORGNL_DEPOSIT_TRANSACTION_DATE := V_ORIG_TRAN_DATE;
              --Inserting redemption record
              CUST_DEPOSIT_TRAN_DTLS_I_SP(REC);
              --updating deposit remaining balance before inserting redmeption record
              CUST_DEP_REM_BAL_UPD(REC);
         END IF; 

         V_COMMIT := V_COMMIT + 1;
         IF V_COMMIT > 500 THEN
            COMMIT;
            V_COMMIT := 0;
         END IF;
      EXCEPTION
         WHEN OTHERS THEN
              ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE,
                                          'LOAD_CUSTOMER_DEPOSIT_TRANSACTION_DTL',
                                          SQLERRM,
                                          REC.COST_CENTER_CODE,
                                          REC.CUSTOMER_ACCOUNT_NUMBER,
                                          'CUSTOMER_DEPOSIT_TRANSACTION_DTL');
      END;
   END LOOP;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
        ERRPKG.INSERT_ERROR_LOG_SP( SQLCODE,
                                    'LOAD_CUSTOMER_DEPOSIT_TRANSACTION_DTL',
                                    SQLERRM,
                                    '000000',
                                    '000000000',
                                    '000000000');
END;