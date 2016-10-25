/*
This script contains the DMLs for loading intermediate tables from temp tables 
This is a One time load and will be converted into picklist later after discussing with UI

Also we will need to load MISCTRAN_DETAILS table with data till date from MISCTRAN table
There will be a separate batch that runs daily to do the above step automatically going forwards

Created : 10/10/2016 jxc517 CCN Project Team....
*/
BEGIN
    DELETE FROM PRIME_SUB_DETAIL;
    DELETE FROM PRIME_SUB_HEADER;
    FOR rec IN (SELECT * FROM TEMP_PRIME_SUB_HEADER_SRA13003) LOOP
        INSERT INTO PRIME_SUB_HEADER VALUES (
            rec.CODE,
            rec.B,
            rec.C,
            rec.NAME);
    END LOOP;
    FOR rec IN (SELECT * FROM TEMP_PRIME_SUB_DETAIL_SRA13003) LOOP
        INSERT INTO PRIME_SUB_DETAIL VALUES (
            rec.CODE,
            DECODE(rec.DR_CR, 'LIMITCR', 'OC', 'LIMITDR', 'OD', NULL),
            rec.PRIME_SUB,
            rec.DIVISION,
            rec.PRIME_SUB_CC);
    END LOOP;
    COMMIT;
END;
/

DECLARE
    CURSOR main_cursor IS
        SELECT MT.BANK_ACCOUNT_NBR,
               (SELECT COST_CENTER_CODE
                  FROM COST_CENTER
                 WHERE SUBSTR(UPPER(COST_CENTER_CODE), 3) = UPPER(MT.COST_CENTER_CODE)
                   AND ROWNUM < 2) AS COST_CENTER_CODE,
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
               PSD.PRIME_SUB || NVL(PSD.PRIME_SUB_COST_CENTER, MT.COST_CENTER_CODE) AS PRIME_SUB, 
               BA.JV_BOOK_KEEPER_REF,
               BA.JV_BANK_SHORT_NAME,
               BA.IDI_BOOKKEEPER_REF,
               BA.IDI_BANK_SHORT_NAME
          FROM MISCTRAN MT,
               PRIME_SUB_DETAIL PSD,
               BANK_ACCOUNT BA
         WHERE MT.TCODE            = PSD.TCODE(+)
           AND MT.BANK_ACCOUNT_NBR = LPAD(REPLACE(BA.BANK_ACCOUNT_NBR(+),'-'), 17, 0);
BEGIN
    FOR rec IN LOOP
        INSERT INTO MISCTRAN_DETAILS VALUES rec;
    END LOOP;
END;
/

/*
SELECT * FROM PRIME_SUB_HEADER;
SELECT * FROM PRIME_SUB_DETAIL;
SELECT * FROM MISCTRAN_DETAILS;
*/