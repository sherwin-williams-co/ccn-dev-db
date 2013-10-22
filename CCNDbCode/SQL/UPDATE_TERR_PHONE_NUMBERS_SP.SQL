PROCEDURE UPDATE_TERR_PHONE_NUMBERS_SP
(FIRST_CHARACTER IN VARCHAR)
as
/*
   This is a file of Territory Phone number from CPR group containing
   Territory phone numbers to be updated to CCN phone number record.
   Updating the PHONE Table from the Temporary Territory Phone Table.
   
Created by: BLR 5-15-13 for CCNA-382
*/
 
 -- DECLARE

   cursor CCNTERR_PHONE_CUR is
     select COST_CENTER_CODE,	         
	     MAINT_FUNCTION, 
       MAINTENANCE_TYPE,
	     MAINTENANCE_CODE,		     
	     PHONE_AREA_CODE,
	     PHONE_NUMBER,
       PHONE_EXTENSION FROM TEMP_TERR_PHONE;
       

  
  in_cost_center varchar2(4);
  v_cost_center_code varchar2(6);
   v_count integer := 0;   
   v_commit integer := 0;
   v_phone_row PHONE%rowtype;
   v_cc_row cost_center%rowtype;
   
Begin

   for ccnterr_phone_rec in CCNTERR_PHONE_CUR loop

 Begin
 v_cost_center_code :=  COMMON_TOOLS.COST_CENTER_LOOK_UP_FNC ( ccnterr_phone_rec.cost_center_code) ;
 
    select  * into v_cc_row
        from COST_CENTER 
    where COST_CENTER_CODE = v_cost_center_code;

 
-- if COMMON_TOOLS.COST_CENTER_LOOK_UP_FNC ( 'cost_center_code' in_cost_center) then  -- value not found in table 
--       return v_cost_center_code;
-- else      
--       dbms_output.put_line('Invalid CoST CENTER CODE lookup for:  '  || ccnterr_phone_rec.cost_center_code  ) ; 
--   end if; 

   if ccnterr_phone_rec.maintenance_code = 'C' then	
      if ccnterr_phone_rec.phone_number is not null then      
         v_phone_row.phone_area_code := ccnterr_phone_rec.phone_area_code;
         v_phone_row.phone_number := ccnterr_phone_rec.phone_number;
         v_phone_row.phone_extension := ccnterr_phone_rec.phone_extension;        
         UPDATE  PHONE set row = v_phone_row 
            where v_phone_row.cost_center_code = v_cost_center_code;
   --        where v_phone_row.cost_center_code = ccnterr_phone_rec.cost_center_code;
      
         v_phone_row := null;
         v_count := v_count + 1;

         v_commit := v_commit + 1;

         if v_commit > 500 then
            commit;
            v_commit := 0;
         end if;   
         
      end if;
      
  end if;
  
     

   EXCEPTION

      WHEN others then
         dbms_output.put_line('Invalid Update of Phone Table ' 
            || ccnterr_phone_rec.cost_center_code  
	    || ' '	            
            || sqlerrm);

 END;

END LOOP;

   dbms_output.put_line('Total Update Phones '
      || v_count);

EXCEPTION

   when others then
      dbms_output.put_line('Table Not updated Stopped on Record - ' 
      || v_count);


END UPDATE_TERR_PHONE_NUMBERS_SP;
/

