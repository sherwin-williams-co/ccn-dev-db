DECLARE

CURSOR STOREDRAFT_DETAIL_CUR IS   
        SELECT ROW_NUMBER( ) OVER (PARTITION BY A.COST_CENTER_CODE,B.TRANSACTION_DATE,A.CHECK_SERIAL_NUMBER ORDER BY B.TRANSACTION_DATE) SRLNO,
               B.TRANSACTION_DATE,
               (SELECT COST_CENTER_CODE
                 FROM COST_CENTER
                WHERE A.COST_CENTER_CODE    = SUBSTR(COST_CENTER_CODE,3)
				and CATEGORY = 'S') CC_CODE,
               A.*
          FROM DLY_ISSUE_CHANGE_DATA B,
               (SELECT TRANSACTION_SOURCE,
                       TRANSACTION_TYPE,
                       COST_CENTER_CODE,
                       CHECK_SERIAL_NUMBER,
                       PROCESS_DATE,
                       TRANSACTION_SEGMENT_TYPE,
                       ITEM_EXT_AMOUNT,
                       ORGNL_CUSTOMER_ACCOUNT_NUMBER,
                       ORGNL_JOB_NUMBER,
                       NULL GL_PRIME_ACCOUNT_NUMBER,
                       NULL GL_SUB_ACCOUNT_NUMBER,
                       NULL ORGNL_TERMINAL_NUMBER,
                       NULL ORGNL_TRANSACTION_NUMBER,
                       NULL ITEM_QUANTITY,
                       NULL ITEM_PRICE
                  FROM DLY_DISBURSMENT_LINE_ITEM_DATA
                 UNION ALL
                SELECT TRANSACTION_SOURCE,
                       TRANSACTION_TYPE,
                       COST_CENTER_CODE,
                       CHECK_SERIAL_NUMBER,
                       PROCESS_DATE,
                       TRANSACTION_SEGMENT_TYPE,
                       ITEM_EXT_AMOUNT,
                       NULL ORGNL_CUSTOMER_ACCOUNT_NUMBER,
                       NULL ORGNL_JOB_NUMBER,
                       GL_PRIME_ACCOUNT_NUMBER,
                       GL_SUB_ACCOUNT_NUMBER,
                       NULL ORGNL_TERMINAL_NUMBER,
                       NULL ORGNL_TRANSACTION_NUMBER,
                       NULL ITEM_QUANTITY,
                       NULL ITEM_PRICE
                  FROM DLY_CUSTOMER_LINE_ITEM_DATA
                 UNION ALL
                SELECT TRANSACTION_SOURCE,
                       TRANSACTION_TYPE,
                       COST_CENTER_CODE,
                       CHECK_SERIAL_NUMBER,
                       PROCESS_DATE,
                       TRANSACTION_SEGMENT_TYPE,
                       ITEM_EXT_AMOUNT,
                       NULL ORGNL_CUSTOMER_ACCOUNT_NUMBER,
                       NULL ORGNL_JOB_NUMBER,
                       GL_PRIME_ACCOUNT_NUMBER,
                       GL_SUB_ACCOUNT_NUMBER,
                       ORGNL_TERMINAL_NUMBER,
                       ORGNL_TRANSACTION_NUMBER,
                       ITEM_QUANTITY,
                       ITEM_PRICE
                  FROM DLY_INSTALLER_LINE_ITEM_DATA) A
         WHERE A.COST_CENTER_CODE    = B.COST_CENTER_CODE(+)
           AND A.CHECK_SERIAL_NUMBER = B.CHECK_SERIAL_NUMBER(+);
           --and a.check_serial_number = '0189938939';

    V_COMMIT                INTEGER := 0;
    V_STOREDRAFT_DETAIL_ROW       STORE_DRAFTS_DETAIL%ROWTYPE;
    V_UNMTCHED_STOREDRAFT_DTL_ROW UNATTACHED_MNL_DRFT_DTL%ROWTYPE;
BEGIN

    FOR rec IN STOREDRAFT_DETAIL_CUR LOOP
        BEGIN
            V_STOREDRAFT_DETAIL_ROW.STORE_DRAFTS_DETAIL_ID  := rec.SRLNO;
            V_STOREDRAFT_DETAIL_ROW.COST_CENTER_CODE        := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.CC_CODE);
            V_STOREDRAFT_DETAIL_ROW.CHECK_SERIAL_NUMBER     := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.CHECK_SERIAL_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.TRANSACTION_DATE        := CCN_COMMON_TOOLS.GET_DATE_VALUE(rec.TRANSACTION_DATE,'YYMMDD');
            V_STOREDRAFT_DETAIL_ROW.TERMINAL_NUMBER         := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.ORGNL_TERMINAL_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.TRANSACTION_NUMBER      := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.ORGNL_TRANSACTION_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.CUSTOMER_ACCOUNT_NUMBER := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.ORGNL_CUSTOMER_ACCOUNT_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.CUSTOMER_JOB_NUMBER     := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.ORGNL_JOB_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.GL_PRIME_ACCOUNT_NUMBER := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.GL_PRIME_ACCOUNT_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.GL_SUB_ACCOUNT_NUMBER   := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.GL_SUB_ACCOUNT_NUMBER);
            V_STOREDRAFT_DETAIL_ROW.ITEM_QUANTITY           := CCN_COMMON_TOOLS.RETURN_NUMBER(rec.ITEM_QUANTITY,7,2);
            V_STOREDRAFT_DETAIL_ROW.ITEM_PRICE              := CCN_COMMON_TOOLS.RETURN_NUMBER(rec.ITEM_PRICE,7,2);
            V_STOREDRAFT_DETAIL_ROW.ITEM_EXT_AMOUNT         := CCN_COMMON_TOOLS.RETURN_NUMBER(rec.ITEM_EXT_AMOUNT,9,2); --actual table has 7,2
            --V_STOREDRAFT_DETAIL_ROW.BOOK_DATE_SEQUENCE      := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.BOOK_DATE_SEQUENCE);
            --V_STOREDRAFT_DETAIL_ROW.LBR_TRANSACTION_DATE    := TO_DATE(CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.LBR_TRANSACTION_DATE), 'RRRRMMDD');
            --V_STOREDRAFT_DETAIL_ROW.LBR_TERMINAL_NUMBER     := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.LBR_TERM_NUMBER);
            --V_STOREDRAFT_DETAIL_ROW.LBR_TRANSACTION_NUMBER  := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.LBR_TRANSACTION_NUMBER);

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
                                                   'LOAD_DLY_STORE_DRAFTS_DETAIL',
                                                   SQLERRM,
                                                   NVL(rec.CC_CODE,rec.COST_CENTER_CODE),
                                                   NVL(rec.CHECK_SERIAL_NUMBER,'')||':'||
                                                   NVL(rec.TRANSACTION_DATE,'') ||':'||
                                                   NVL(rec.ORGNL_TERMINAL_NUMBER,'')||':'||
                                                   NVL(rec.ORGNL_TRANSACTION_NUMBER,'')
                                                   );
               
        END;
    END LOOP;  
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
         ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_DLY_STORE_DRAFTS_DETAIL',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');
END;
/