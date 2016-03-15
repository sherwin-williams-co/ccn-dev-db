/****************************
Created : nxk927 03/15/2016 
          updating the TERRITORY_TYPE_BUSN_CODE in TERRITORY table
          and cost center name in the cost center table
		  
		  check the external file
*******************************/

BEGIN
    CCN_BATCH_PKG.LOCK_DATABASE_SP();
END;
/ 
/**************************************************
Business Rules : The value used in TERRITORY_TYPE_BUSN_CODE column should be present in CODE_DETAIL table
 SELECT *
   FROM CODE_DETAIL
  WHERE CODE_DETAIL.CODE_HEADER_NAME  = 'TERRITORY_TYPE_BUSN_CODE'
    AND CODE_DETAIL.CODE_DETAIL_VALUE IN ('RR','NR','CM','PM','MS'); 
    
    SELECT * 
      FROM TEMP_CC_SEG_TERR_NAME
      WHERE SEG_TYPE NOT IN ('RR','NR','CM','PM','MS'); 
********************************************************/
DECLARE
V_COUNT NUMBER := 0;
BEGIN
FOR REC IN (SELECT * FROM TEMP_CC_SEG_TERR_NAME) LOOP
    UPDATE TERRITORY
       SET TERRITORY_TYPE_BUSN_CODE = REC.SEG_TYPE
     WHERE COST_CENTER_CODE = REC.COST_CENTER_CODE
      AND NVL(TERRITORY_TYPE_BUSN_CODE,'XX') <> REC.SEG_TYPE;
     
     UPDATE COST_CENTER
        SET COST_CENTER_NAME = REC.COST_CENTER_NAME
      WHERE COST_CENTER_CODE = REC.COST_CENTER_CODE
        AND CATEGORY = 'T'
        AND COST_CENTER_NAME <> REC.COST_CENTER_NAME;
    V_COUNT := V_COUNT +1;
    IF V_COUNT = 100 THEN
	   COMMIT;
	   V_COUNT := 0;
	END IF;
END LOOP;
COMMIT;
END;
/
BEGIN
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP();
END;
/

DROP TABLE TEMP_CC_SEG_TERR_NAME;