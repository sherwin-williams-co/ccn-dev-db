DECLARE

CURSOR STOREDRAFT_DETAIL_CUR IS   
        SELECT ROW_NUMBER( ) OVER (PARTITION BY cost_center_code,check_serial_number,transaction_date order by transaction_date) SRLNO,A.*
          FROM STORE_DRAFT_DETAIL_T A;

    V_COMMIT                INTEGER := 0;
    V_STOREDRAFT_DETAIL_ROW STORE_DRAFTS_DETAIL%ROWTYPE;
    --V_UNMTCHED_STOREDRAFT_DTL_ROW UNATTACHED_MNL_DRFT_DTL%ROWTYPE;
	


BEGIN
	 EXECUTE IMMEDIATE 'Truncate table STORE_DRAFTS_DETAIL';
	 EXECUTE IMMEDIATE 'Truncate table HST_STORE_DRAFTS_DETAIL';

    FOR rec IN STOREDRAFT_DETAIL_CUR LOOP
        BEGIN
            V_STOREDRAFT_DETAIL_ROW.STORE_DRAFTS_DETAIL_ID  := rec.SRLNO;
            V_STOREDRAFT_DETAIL_ROW.COST_CENTER_CODE        := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.COST_CENTER_CODE);
            V_STOREDRAFT_DETAIL_ROW.CHECK_SERIAL_NUMBER     := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.CHECK_SERIAL_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.TRANSACTION_DATE        := TO_DATE(CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.TRANSACTION_DATE), 'RRRRMMDD');
            V_STOREDRAFT_DETAIL_ROW.TERMINAL_NUMBER         := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.TERM_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.TRANSACTION_NUMBER      := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.TRANSACTION_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.CUSTOMER_ACCOUNT_NUMBER := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.CUSTOMER_ACCOUNT_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.CUSTOMER_JOB_NUMBER     := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.CUSTOMER_JOB_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.GL_PRIME_ACCOUNT_NUMBER := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.GL_PRIME_ACCOUNT_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.GL_SUB_ACCOUNT_NUMBER   := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.GL_SUB_ACCOUNT_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.ITEM_QUANTITY           := CCN_COMMON_TOOLS.RETURN_NUMBER(rec.ITEM_QUANTITY,7,2);
            V_STOREDRAFT_DETAIL_ROW.ITEM_PRICE              := CCN_COMMON_TOOLS.RETURN_NUMBER(rec.ITEM_PRICE,7,2);
            V_STOREDRAFT_DETAIL_ROW.ITEM_EXT_AMOUNT         := CCN_COMMON_TOOLS.RETURN_NUMBER(rec.ITEM_EXT_AMOUNT,7,2);
            V_STOREDRAFT_DETAIL_ROW.BOOK_DATE_SEQUENCE      := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.BOOK_DATE_SEQUENCE);
            V_STOREDRAFT_DETAIL_ROW.LBR_TRANSACTION_DATE    := TO_DATE(CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.LBR_TRANSACTION_DATE), 'RRRRMMDD');
            V_STOREDRAFT_DETAIL_ROW.LBR_TERMINAL_NUMBER     := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.LBR_TERM_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.LBR_TRANSACTION_NUMBER  := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.LBR_TRANSACTION_NUMBER);

            IF V_STOREDRAFT_DETAIL_ROW.TRANSACTION_DATE <= ADD_MONTHS(TRUNC(SYSDATE),-1 * SD_BUSINESS_RULES_PKG.G_HISTORY_MONTHS) THEN
                INSERT INTO HST_STORE_DRAFTS_DETAIL VALUES V_STOREDRAFT_DETAIL_ROW;
            ELSE
                INSERT INTO STORE_DRAFTS_DETAIL VALUES V_STOREDRAFT_DETAIL_ROW;
            END IF;

            V_STOREDRAFT_DETAIL_ROW := NULL ;
            V_COMMIT := V_COMMIT + 1;
            IF V_COMMIT > 500 THEN
                COMMIT;
                V_COMMIT := 0;
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                                   'LOAD_STORE_DRAFTS_DETAIL',
                                                   SQLERRM,
                                                   rec.COST_CENTER_CODE,
                                                   NVL(rec.CHECK_SERIAL_NUMBER,'')||':'||
                                                   NVL(rec.TRANSACTION_DATE,'')||':'||
                                                   NVL(rec.TERM_NUMBER,'')||':'||
                                                   NVL(rec.TRANSACTION_NUMBER,''));
                --END;
        END;
    END LOOP;  
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
         ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_STORE_DRAFTS_DETAIL',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');
END;
/