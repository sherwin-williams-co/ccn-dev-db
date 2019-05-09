/*
This script is to update the GL_DIVISION which are NULL
ASP-1259 : Update all the transactions that have NULL value for GL_DIVISION.
         : This script that can be re-used till we implement the changes to make this field mandatory
*/
DECLARE
   V_COUNT NUMBER := 0;

   CURSOR CUR_COST_CENTER IS
        SELECT DISTINCT 
               COST_CENTER_CODE,
               COMMON_TOOLS.GET_GL_DIVISION(DTL.COST_CENTER_CODE) GL_DIVISION
          FROM CUSTOMER_DEPOSIT_TRANSACTION_DTL DTL
         WHERE DTL.GL_DIVISION IS NULL;
BEGIN
    FOR rec IN  CUR_COST_CENTER
       LOOP
          UPDATE CUSTOMER_DEPOSIT_TRANSACTION_DTL DTL
             SET GL_DIVISION          = rec.GL_DIVISION
           WHERE DTL.COST_CENTER_CODE = rec.COST_CENTER_CODE
             AND DTL.GL_DIVISION IS NULL;

          IF V_COUNT > 500 THEN
                COMMIT;
             V_COUNT := 0;
          ELSE
              V_COUNT := V_COUNT + 1;
          END IF;
       END LOOP;
COMMIT;
END;