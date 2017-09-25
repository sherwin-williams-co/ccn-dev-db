/************************************************************************************
This script will update the fips_code of Admin Cost Centers to null for ADDRESS_USA
CREATED : 09/22/2017 sxh487 CCN Project team....
*************************************************************************************/
DECLARE
    CURSOR CUR IS
       SELECT A.*, rowid
         FROM ADDRESS_USA A 
        WHERE FIPS_CODE IS NOT NULL 
          AND EXISTS (SELECT 1 
            		FROM COST_CENTER 
            	       WHERE COST_CENTER_CODE = A.COST_CENTER_CODE 
            	         AND CATEGORY IN ('A'));
V_COUNT NUMBER := 0;
BEGIN
    FOR REC IN CUR LOOP
       V_COUNT := V_COUNT +1;
       BEGIN
	    UPDATE ADDRESS_USA
	       SET FIPS_CODE = NULL
	     WHERE COST_CENTER_CODE  = REC.COST_CENTER_CODE
	       AND rowid = rec.rowid;

		IF V_COUNT = 500 then
		   V_COUNT := 0;
		   COMMIT;
		END IF;
		
	EXCEPTION
	       WHEN OTHERS THEN
	            DBMS_OUTPUT.PUT_LINE('FAILED to Update '|| rec.COST_CENTER_CODE);
        END;
    END LOOP;  
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
         DBMS_OUTPUT.PUT_LINE('FAILED in main Exception');
END;
