SET SERVEROUTPUT ON;

DECLARE
PROCEDURE PRIME_SUB_LOAD_PROCESS(IN_DATE DATE)
IS
    CURSOR main_cursor IS
        SELECT MT.BANK_ACCOUNT_NBR,
               MT.COST_CENTER_CODE,
               MT.AMOUNT,
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
                 WHERE SUBSTR(CC.COST_CENTER_CODE,3) = NVL(PSD.PRIME_SUB_COST_CENTER, SUBSTR(MT.COST_CENTER_CODE,3))
                   AND ROWNUM < 2) AS BOOKING_COST_CENTER,
               MT.ORIGINATED_BANK_ACCNT_NBR
          FROM MISCTRAN MT,
               PRIME_SUB_DETAIL PSD,
               BANK_ACCOUNT BA
         WHERE MT.TCODE                     = PSD.TCODE(+)
           AND MT.ORIGINATED_BANK_ACCNT_NBR = LPAD(REPLACE(BA.BANK_ACCOUNT_NBR(+),'-'), 17, 0)
           AND MT.LOAD_DATE                 = IN_DATE
         UNION
        SELECT OS.BANK_ACCOUNT_NBR,
               OS.COST_CENTER_CODE,
               OS.AMOUNT,
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
                 WHERE SUBSTR(CC.COST_CENTER_CODE,3) = NVL(PSD.PRIME_SUB_COST_CENTER, SUBSTR(OS.COST_CENTER_CODE,3))
                   AND ROWNUM < 2) AS BOOKING_COST_CENTER,
               OS.ORIGINATED_BANK_ACCNT_NBR
          FROM OVERSHRT OS,
               PRIME_SUB_DETAIL PSD,
               BANK_ACCOUNT BA
         WHERE OS.TCODE                     = PSD.TCODE(+)
           AND OS.ORIGINATED_BANK_ACCNT_NBR = LPAD(REPLACE(BA.BANK_ACCOUNT_NBR(+),'-'), 17, 0)
           AND OS.LOAD_DATE                 = IN_DATE;
BEGIN
    DELETE FROM MISCTRAN_DETAILS WHERE LOAD_DATE = IN_DATE;
    FOR rec IN main_cursor LOOP
        INSERT INTO MISCTRAN_DETAILS VALUES rec;
    END LOOP;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('failure '||SQLERRM);
END PRIME_SUB_LOAD_PROCESS;

BEGIN
    PRIME_SUB_LOAD_PROCESS('15-Aug-2017');
    PRIME_SUB_LOAD_PROCESS('16-Aug-2017');
    PRIME_SUB_LOAD_PROCESS('17-Aug-2017');
END;
/