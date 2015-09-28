/*
Created: dxv848 09/28/2015 Updating the Cost_center_names in the cost_center table. 
*/

DECLARE

CURSOR TERR_CUR IS
SELECT * FROM TERR_CCN_NAME_CHG;
V_COUNT  NUMBER := 0;
V_UCOUNT NUMBER := 0;

BEGIN
    FOR TERR_REC IN TERR_CUR LOOP
	BEGIN
	    UPDATE COST_CENTER
              SET COST_CENTER_NAME = TERR_REC.COST_CENTER_NAME
	     WHERE COST_CENTER_CODE = TERR_REC.COST_CENTER_CODE;
           IF V_COUNT > 100 THEN
                COMMIT;
                V_COUNT := 0;
	    END IF;
           V_COUNT  := V_COUNT + 1;
           V_UCOUNT := V_UCOUNT + 1;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error while Updating for the cost_center'||TERR_REC.COST_CENTER_CODE);
        END;
    END LOOP;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Total rows UPDATED: ' || V_UCOUNT);
    DBMS_OUTPUT.PUT_LINE('0');
EXCEPTION
    WHEN OTHERS THEN
	DBMS_OUTPUT.PUT_LINE('FAILED ' || SQLCODE || ' ' || SUBSTR(SQLERRM,1,500));
END;
/
