CREATE OR REPLACE function cost_center_check_format
  ( in_cost_center_code  in  varchar2
  ) return boolean as 

   v_code   number;
   v_count  number;
   
   invalid_code_center_err           exception;
   cost_center_pre_not_valid_err     exception;
   cost_center_suf_not_valid_err     exception;
   duplicate_cost_center_err         exception;

begin

/*******************************************************************************
      Cost_Center can not be null, spaces, or all zeroes, and must 6 characters 
*******************************************************************************/

--    cost_center_code can not be null 
      if  in_cost_center_code  is  null
--    cost_center_code can not be just one or more spaces
      or  regexp_like(in_cost_center_code, '^ *$')
--    cost_center_code can not be all zeroes
      or  in_cost_center_code  =   '000000'   
--    cost_center_code entered must be 6 characters in length
      or  length(in_cost_center_code)  !=  6
      then
          raise invalid_code_center_err;
-- See Error #01d.
      end if;
      
      return true;
      
/*******************************************************************************
	  EXCEPTION ERRORS AREA
*******************************************************************************/	  
	
          EXCEPTION
                   
               when invalid_code_center_err then
                    v_code := errnums.en_invalid_cost_center_err; 
                    errpkg.raise_err(v_code, 'COST_CENTER_CHECK_FORMAT.invalid_code_center_err ' ,
                   'Function - ' ||
                   'Cost_Center_Code was entered as "' || in_cost_center_code || '". ' ||
                   'This field must be entered as 6 characters , and can not be "null", "spaces", or all "zeroes".' ); 
                                         
               when cost_center_pre_not_valid_err then
                    v_code := errnums.en_invalid_cost_center_err;  
                    errpkg.raise_err(v_code, 'COST_CENTER_CHECK_FORMAT.invalid_cost_center_exp ' ,
                   'Function - ' ||
                   'Cost_Center_Code was entered as "' || in_cost_center_code || '". ' ||
                   'However, Cost_Center_Code first two digits must be numeric.' );

               when cost_center_suf_not_valid_err then  
                    v_code := errnums.en_invalid_cost_center_err;  
                    errpkg.raise_err(v_code, 'COST_CENTER_CHECK_FORMAT.invalid_cost_center_exp ' ,
                   'Function - ' ||
                   'Cost_Center_Code was entered as "' || in_cost_center_code || '". ' ||
                   'However, Cost_Center_Code last four digits must be valid alpha or numeric.' );  

               when duplicate_cost_center_err then
                    v_code := errnums.en_duplicate_cost_center_err; 
                    errpkg.raise_err(v_code, 'COST_CENTER_CHECK_FORMAT.duplicate_cost_center_exp ' ,
                   'Function - ' ||
                   'Cost_Center_Code was entered as "' || in_cost_center_code || '". ' ||
                   'However, Cost_Center already exists.' );   
    
END cost_center_check_format;

