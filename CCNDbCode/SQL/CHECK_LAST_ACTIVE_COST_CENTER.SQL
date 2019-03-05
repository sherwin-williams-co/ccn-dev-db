create or replace FUNCTION CHECK_LAST_ACTIVE_COST_CENTER
/**********************************************************
Address trigger to find last active address record for cc and throw error 

Created : 03/5/2019 kxm302 CCN Project Team.....
**********************************************************/
(IN_TABLE_NAME          VARCHAR,
 IN_COST_CENTER_CODE    VARCHAR,
 IN_ADDRESS_TYPE        VARCHAR2) RETURN NUMBER
IS
   PRAGMA               AUTONOMOUS_TRANSACTION;   
   V_COUNT              NUMBER := 0;
   v_sql_stmt           VARCHAR2(1000);
   C1                   SYS_REFCURSOR;
  
BEGIN
    v_sql_stmt :=  'SELECT COUNT(*) 
                     FROM  '||IN_TABLE_NAME
                    ||' WHERE COST_CENTER_CODE = '||''''||IN_COST_CENTER_CODE||''''
                    || ' AND ADDRESS_TYPE = '||''''||IN_ADDRESS_TYPE||''''
                    ||' AND EXPIRATION_DATE IS NULL';

    OPEN C1 FOR v_sql_stmt; 
    LOOP
       FETCH C1 INTO V_COUNT;
       EXIT WHEN C1%NOTFOUND;
    END LOOP;
    CLOSE C1;
    
   RETURN V_COUNT;
   
EXCEPTION
   WHEN OTHERS THEN
      NULL;
END;