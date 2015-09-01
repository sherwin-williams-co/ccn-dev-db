/*
Created: dxv848 09/01/2015 Script update the Marketing table.
*/
declare

e_invalid_store EXCEPTION;

cursor marketing_cur is 
    select * from marketing_temp; 
  
v_count     integer := 0;
v_count1     integer := 0;
v_ins_count integer :=0;


begin

   FOR marketing_rec in marketing_cur LOOP     
      BEGIN
         update MARKETING 
            set MKT_BRAND = marketing_rec.BRAND ,
                MKT_MISSION = marketing_rec.MISSION,
                MKT_SALES_FLOOR_SIZE = marketing_rec.SALE_FLOOR_SQ_FT,
                MKT_WAREHOUSE_SIZE = marketing_rec.WAREHOUSE_SQ_FT,
                MKT_REAL_ESTATE_SETTING = marketing_rec.REAL_ESTATE_SET
          where substr(COST_CENTER_CODE, 3, 4) = marketing_rec.STORE_NUMBER;
 
          
         if v_count > 100 then
             commit; 
             v_count := 0;
         end if;

          
         v_ins_count := v_ins_count + 1;
           
         IF SQL%NOTFOUND THEN
            RAISE e_invalid_store;
         END IF;
         
    
      EXCEPTION
         WHEN e_invalid_store  THEN
            COMMON_TOOLS.LOG_ERROR(marketing_rec.STORE_NUMBER, 'MARKETING TABLE UPDATE', 'UPDATE MARKETING TABLE FAILED for:'||marketing_rec.STORE_NUMBER, SQLCODE);
            v_count1 := v_count1 + 1;
      END;
   END LOOP;
V_INS_COUNT := V_INS_COUNT- v_count1;
DBMS_OUTPUT.PUT_LINE('no of cost_center which are not exist in marketing table : '||v_count1);
DBMS_OUTPUT.PUT_LINE('Total no of cost_centers updated in MArketing table: ' || v_ins_count);
DBMS_OUTPUT.PUT_LINE('0');

EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('FAILED ' || SQLCODE || ' ' || substr(SQLERRM,1,500));
end;
/
