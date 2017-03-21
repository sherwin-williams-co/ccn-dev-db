/*
Created : nxk927 03/21/2017
          Truncating and loading the MISCTRAN_DETAILS table with the source bank account number
*/

DECLARE
    CURSOR main_cursor IS
        SELECT MT.BANK_ACCOUNT_NBR,
               (SELECT COST_CENTER_CODE
                  FROM COST_CENTER
                 WHERE SUBSTR(UPPER(COST_CENTER_CODE), 3) = UPPER(MT.COST_CENTER_CODE)
                   AND ROWNUM < 2) AS COST_CENTER_CODE,
               MT.AMOUNT/100,
               MT.TRANSACTION_DATE,
               MT.TCODE,
               (SELECT NAME
                  FROM PRIME_SUB_HEADER
                 WHERE TCODE = MT.TCODE) TCODE_DESCRIPTION,
               MT.TRAN_SEQNUM,
               PSD.DB_CR_CODE AS DB_CR_CODE, --MT.DB_CR_CODE,
               MT.SNZ_SAM_CODE,
               MT.LOAD_DATE,
               --prime sub will be different for OC/OD
               PSD.PRIME_SUB AS PRIME_SUB, 
               BA.JV_BOOK_KEEPER_REF,
               BA.JV_BANK_SHORT_NAME,
               BA.IDI_BOOKKEEPER_REF,
               BA.IDI_BANK_SHORT_NAME,
               (SELECT CC.COST_CENTER_CODE 
                  FROM COSTCNTR.COST_CENTER CC 
                 WHERE SUBSTR(CC.COST_CENTER_CODE,-4) = NVL(PSD.PRIME_SUB_COST_CENTER, MT.COST_CENTER_CODE)
				   AND ROWNUM <2) AS BOOKING_COST_CENTER,
               MT.ORIGINATED_BANK_ACCNT_NBR
          FROM MISCTRAN MT,
               PRIME_SUB_DETAIL PSD,
               BANK_ACCOUNT BA
         WHERE MT.TCODE                     = PSD.TCODE(+)
           AND MT.ORIGINATED_BANK_ACCNT_NBR = LPAD(REPLACE(BA.BANK_ACCOUNT_NBR(+),'-'), 17, 0)
         UNION
        SELECT OS.BANK_ACCOUNT_NBR,
               (SELECT COST_CENTER_CODE
                  FROM COST_CENTER
                 WHERE SUBSTR(UPPER(COST_CENTER_CODE), 3) = UPPER(OS.COST_CENTER_CODE)
                   AND ROWNUM < 2) AS COST_CENTER_CODE,
               OS.AMOUNT/100,
               OS.TRANSACTION_DATE,
               OS.TCODE,
               (SELECT NAME
                  FROM PRIME_SUB_HEADER
                 WHERE TCODE = OS.TCODE) TCODE_DESCRIPTION,
               OS.TRAN_SEQNUM,
               PSD.DB_CR_CODE AS DB_CR_CODE, --MT.DB_CR_CODE,
               OS.TRAN_CODE,
               OS.LOAD_DATE,
               --prime sub will be different for OC/OD
               PSD.PRIME_SUB AS PRIME_SUB, 
               BA.JV_BOOK_KEEPER_REF,
               BA.JV_BANK_SHORT_NAME,
               BA.IDI_BOOKKEEPER_REF,
               BA.IDI_BANK_SHORT_NAME,
               (SELECT CC.COST_CENTER_CODE 
                  FROM COSTCNTR.COST_CENTER CC 
                 WHERE SUBSTR(CC.COST_CENTER_CODE,-4) = NVL(PSD.PRIME_SUB_COST_CENTER, OS.COST_CENTER_CODE)
                   AND ROWNUM <2) AS BOOKING_COST_CENTER,
               OS.ORIGINATED_BANK_ACCNT_NBR
          FROM OVERSHRT OS,
               PRIME_SUB_DETAIL PSD,
               BANK_ACCOUNT BA
         WHERE OS.TCODE                     = PSD.TCODE(+)
           AND OS.ORIGINATED_BANK_ACCNT_NBR = LPAD(REPLACE(BA.BANK_ACCOUNT_NBR(+),'-'), 17, 0);

    V_BATCH_NUMBER      BATCH_JOB.BATCH_JOB_NUMBER%TYPE;
    V_TRANS_STATUS      BATCH_JOB.TRANS_STATUS%TYPE := 'SUCCESSFUL';
BEGIN
    CCN_BATCH_PKG.INSERT_BATCH_JOB('PRIME_SUB_LOAD_PRCS', V_BATCH_NUMBER);
    CCN_BATCH_PKG.LOCK_DATABASE_SP();
    EXECUTE IMMEDIATE 'TRUNCATE TABLE MISCTRAN_DETAILS';
    FOR rec IN main_cursor LOOP
        INSERT INTO MISCTRAN_DETAILS VALUES rec;
    END LOOP;
    COMMIT;
    CCN_BATCH_PKG.UPDATE_BATCH_JOB('PRIME_SUB_LOAD_PRCS', V_BATCH_NUMBER, V_TRANS_STATUS);
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP();
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                   'STR_BNK_DPST_DLY_RCNCL_PROCESS.PRIME_SUB_LOAD_PROCESS',
                                   SQLERRM,
                                   '2222222222',
                                   '222222',
                                   'OTHER');
        RAISE;
END;


