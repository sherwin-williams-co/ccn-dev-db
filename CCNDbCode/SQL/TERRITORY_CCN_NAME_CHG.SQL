create or replace PROCEDURE TERRITORY_CCN_NAME_CHG
/****************************************************************************
TERRITORY_CCN_NAME_CHG
This procedure is used to update the cost_center_name and also statement_type
for territory cost centers based on file placed on the ccn db server 
created : 08/28/2015 AXK326 CCN Project....
changed :
*****************************************************************************/

IS
  CURSOR TERR_CUR IS
  SELECT * FROM TEMP_COST_CENTER_NAME_CHG;
    V_COUNT NUMBER := 0;
BEGIN
  FOR TERR_REC IN TERR_CUR
  LOOP
    BEGIN
      UPDATE COST_CENTER CC
         SET CC.COST_CENTER_NAME = TERR_REC.COST_CENTER_NAME,
             CC.STATEMENT_TYPE = TERR_REC.STATEMENT_TYPE
       WHERE CC.COST_CENTER_CODE = TERR_REC.COST_CENTER_CODE;
      V_COUNT   := V_COUNT + 1;
      IF V_COUNT > 500 THEN
         COMMIT;
         V_COUNT := 0;
      END IF;
    END;
    
  END LOOP;
  COMMIT;
  
END TERRITORY_CCN_NAME_CHG ;