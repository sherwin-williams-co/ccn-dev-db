/**********************************************************
THIS Anonymous block will insert all the initload data 
CREATED : 12/03/2014 AXK326 CCN Project team....
**********************************************************/
DECLARE
    CURSOR TEMP_CUR is
        SELECT ROW_NUMBER( ) OVER (PARTITION BY cost_center_code,transaction_date,term_number,transaction_number order by transaction_date) SRLNO,A.*
        FROM CUSTOMER_DETAILS_T A;

    V_COMMIT         NUMBER := 0;
    V_TEMP_ROW       CUSTOMER_DETAILS%ROWTYPE;
BEGIN

    FOR rec IN TEMP_CUR LOOP
        BEGIN
            V_TEMP_ROW.CUSTOMER_DETAIL_ID         := rec.SRLNO;
            V_TEMP_ROW.COST_CENTER_CODE           := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.COST_CENTER_CODE);
            V_TEMP_ROW.TRANSACTION_DATE           := TO_DATE(CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.TRANSACTION_DATE),'RRRRMMDD');
            V_TEMP_ROW.TERMINAL_NUMBER            := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.TERM_NUMBER);
            V_TEMP_ROW.TRANSACTION_NUMBER         := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.TRANSACTION_NUMBER);
            V_TEMP_ROW.SEGMENT_CODE               := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.SEGMENT_CODE);
            V_TEMP_ROW.SALES_NUMBER               := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.SALES_NUMBER);
            V_TEMP_ROW.ITEM_QUANTITY              := CCN_COMMON_TOOLS.RETURN_NUMBER(rec.ITEM_QTY,7,2);
            V_TEMP_ROW.ITEM_PRICE                 := CCN_COMMON_TOOLS.RETURN_NUMBER(rec.ITEM_PRICE,7,2);
            V_TEMP_ROW.ITEM_EXT_AMOUNT            := CCN_COMMON_TOOLS.RETURN_NUMBER(rec.ITEM_EXT_AMOUNT,7,2);
            V_TEMP_ROW.ITEM_DISCOUNT_AMOUNT       := CCN_COMMON_TOOLS.RETURN_NUMBER(rec.ITEM_DISC_AMOUNT,7,2);
            V_TEMP_ROW.ITEM_SALES_TAX_IND         := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.ITEM_SLS_TAX_IND);
            V_TEMP_ROW.ITEM_DISCOUNT_CODE         := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.ITEM_DISC_CODE);
            V_TEMP_ROW.ITEM_DISCOUNT_TYPE         := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.ITEM_DISC_TYPE);
            V_TEMP_ROW.SALES_PROMO_CODE           := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.SLS_PROMO_CODE);
            V_TEMP_ROW.GL_PRIME_ACCOUNT_NUMBER    := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.GL_PRIME_ACCT_NBR);
            V_TEMP_ROW.GL_SUB_ACCOUNT_NUMBER      := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.GL_SUB_ACCT_NBR);
            V_TEMP_ROW.SCHEDULE_TYPE              := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.SCHED_TYPE);
            V_TEMP_ROW.SCHEDULE_VERSION           := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.SCHED_VERSION);
            V_TEMP_ROW.PRICE_LEVEL_CODE           := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.PRICE_LVL_CODE);
            V_TEMP_ROW.PERCENT_OFF_LEVEL          := CCN_COMMON_TOOLS.RETURN_NUMBER(rec.PERCENT_OFF_LVL,7,2);
            V_TEMP_ROW.PROD_DESC_SRCE             := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.PROD_DESC_SRCE);
            V_TEMP_ROW.ORGNL_POS_TERM_NUMBER      := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.ORIG_POS_TERM_NBR);
            V_TEMP_ROW.ORGNL_POS_TRANS_NUMBER     := CCN_COMMON_TOOLS.VALIDATE_DATA_BEFORE_LOAD(rec.ORIG_POS_TRAN_NBR);

            INSERT INTO CUSTOMER_DETAILS_AXK VALUES V_TEMP_ROW;

            V_TEMP_ROW := NULL ;
            V_COMMIT := V_COMMIT + 1;
            IF V_COMMIT > 500 THEN
                COMMIT;
                V_COMMIT := 0;
            END IF;   
        EXCEPTION
            WHEN OTHERS THEN
                ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                           'LOAD_CUSTOMER_DETAILS_AXK',
                                           SQLERRM,
                                           rec.COST_CENTER_CODE,
                                           NVL(rec.TRANSACTION_DATE,'')||':'||
                                           NVL(rec.TERM_NUMBER,'')||':'||
                                           NVL(rec.TRANSACTION_NUMBER,''));                                          
END;
    END LOOP;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
         ERRPKG.INSERT_ERROR_LOG_SP(SQLCODE,
                                    'LOAD_CUSTOMER_DETAILS_AXK',
                                    SQLERRM,
                                    '000000',
                                    '0000000000');
END;
/