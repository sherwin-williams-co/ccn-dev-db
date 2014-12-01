/*********************************************************** 
This block will Update the amount fields with negative values

created : 12/01/2014 axk326 CCN Project....
changed :

************************************************************/
DECLARE
BEGIN
    FOR rec IN (SELECT *
					FROM (SELECT ROW_NUMBER( ) OVER (PARTITION BY C.COST_CENTER_CODE,B.TRANSACTION_DATE,A.TERMINAL_NUMBER,A.TRANSACTION_NUMBER ORDER BY B.TRANSACTION_DATE) SRLNO,
                         C.COST_CENTER_CODE CC_CODE,
                         A.*,
                         B.TRANSACTION_DATE
               FROM DLY_CUSTOMER_DETAILS A,
                    DLY_CUSTOMER B,
                    COST_CENTER C
         WHERE A.COST_CENTER_CODE        = SUBSTR(C.COST_CENTER_CODE,3)
           AND A.COST_CENTER_CODE        = B.COST_CENTER_CODE
           AND A.TERMINAL_NUMBER         = B.TERMINAL_NUMBER
           AND A.TRANSACTION_NUMBER      = B.TRANSACTION_NUMBER)
         WHERE ITEM_PRICE_SIGN           = '-'
            OR ITEM_EXTERNAL_AMOUNT_SIGN = '-'
            OR ITEM_DISC_AMOUNT_SIGN     = '-') LOOP

        UPDATE CUSTOMER_DETAILS CD
           SET CD.ITEM_PRICE           				         = rec.ITEM_PRICE_SIGN||CCN_COMMON_TOOLS.RETURN_NUMBER(rec.Item_Price,7,2) , 
		       CD.Item_EXT_AMOUNT      				         = rec.ITEM_EXTERNAL_AMOUNT_SIGN||CCN_COMMON_TOOLS.RETURN_NUMBER(rec.ITEM_EXTERNAL_AMOUNT,7,2), 
			   CD.ITEM_DISCOUNT_AMOUNT 				         = rec.ITEM_DISC_AMOUNT_SIGN||CCN_COMMON_TOOLS.RETURN_NUMBER(rec.ITEM_DISC_AMOUNT,7,2)
           WHERE CUSTOMER_DETAIL_ID    				         = TRIM(rec.SRLNO)
             AND COST_CENTER_CODE      				         = TRIM(rec.COST_CENTER_CODE)
             AND TO_CHAR(CD.TRANSACTION_DATE,'YYMMDD')       = TO_CHAR(TO_DATE(rec.TRANSACTION_DATE,'YYMMDD'),'YYMMDD')
             AND TERMINAL_NUMBER       				         = TRIM(rec.TERMINAL_NUMBER)
             AND TRANSACTION_NUMBER    				         = TRIM(rec.TRANSACTION_NUMBER);
END LOOP;
END;