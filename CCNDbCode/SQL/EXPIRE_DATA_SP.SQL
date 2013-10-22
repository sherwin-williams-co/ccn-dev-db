PROCEDURE EXPIRE_DATA_SP ( 
/******************************************************************************
	EXPIRE_DATA_SP   --    Expire selected Table Rows Procedure

	This procedure is intended to expire specific row row(s) of data based on 
       table_name, Cost_Center, Address_Type(Addresses only), and Effective_Date. 
       
  This procedure is intended to be used for the follownig tables: 
  
            ADDRESS_CAN, ADDRESS_USA, ADDRESS_MEX, ADDRESS_OTHER
          , BANK_CARD
          , MARKETING
          , STATUS
          , TYPE
  
created : 12/04/2012 MDH CCN Project.....
revised : 05/23/2014 MDH Add Address_Type Parm for Address Records only.
*******************************************************************************/
--
  in_ROW_TABLE            IN  varchar2
, in_COST_CENTER          IN  COST_CENTER.COST_CENTER_CODE%TYPE
, in_EFFECTIVE_DATE       IN  date 
, in_ADDRESS_TYPE         IN  ADDRESS_USA.ADDRESS_TYPE%TYPE DEFAULT NULL)

is
 v_code            number;
 v_errm            varchar2(500);
 v_expiration_Date date;
 v_date            date;
 v_row_id          rowid;
 v_count           integer := 0;
 sql_stmt          varchar2(400);
 v_break           varchar(100);
--
 parameter_null_exp	      EXCEPTION;
 multiple_expire_exp	    EXCEPTION;
 no_unexpire_exp	        EXCEPTION;
 record_update_exp	      EXCEPTION;
--
--
begin

-- verify that the input parameters are not null
v_break  :=  ('Entered the COMMON_TOOLS.Expire_Data_SP ' ); 
  if in_ROW_TABLE is null   or
     in_COST_CENTER is null  or
     (in_ROW_TABLE in ('ADDRESS_CAN','ADDRESS_MEX','ADDRESS_OTHER','ADDRESS_USA')
        AND  in_ADDRESS_TYPE  is null)  or
     in_EFFECTIVE_DATE is null      then
        raise parameter_null_exp;
  end if;
--
--******************************************************************************
-- select the table (in_row_table) for the cost_center 
-- verify that only one row for the cost center has null expiration date.
-- 05/23/2013 MDH for Address records add the ADDRESS_TYPE parameter
--******************************************************************************
  begin
--     
       v_break  :=  ('Entered the COMMON_TOOLS.Expire_Data_SP (Count unexpire recs)' ); 
--
    if in_ROW_TABLE in ('ADDRESS_CAN','ADDRESS_MEX','ADDRESS_OTHER','ADDRESS_USA') then
      sql_stmt := ('select COUNT(1) from ' ||
                    in_ROW_TABLE || 
                    ' where COST_CENTER_CODE  =  :in_COST_CENTER ' || 
                    ' and ADDRESS_TYPE  =  :in_ADDRESS_TYPE ' ||
                    ' and  EXPIRATION_DATE is null');
      EXECUTE IMMEDIATE sql_stmt INTO v_count USING in_COST_CENTER, in_ADDRESS_TYPE;              
    else
       sql_stmt := ('select COUNT(1) from ' ||
                    in_ROW_TABLE || 
                    ' where COST_CENTER_CODE  =  :in_COST_CENTER ' || 
                    ' and  EXPIRATION_DATE is null');
       EXECUTE IMMEDIATE sql_stmt INTO v_count USING in_COST_CENTER;               
    end if;
--                  
--      EXECUTE IMMEDIATE sql_stmt INTO v_count USING in_COST_CENTER, in_ADDRESS_TYPE;
                   
      if v_count  >  1  then
          raise multiple_expire_exp;
      end if;
  end;
--
--*****************************************************************************
-- select the table (in_row_table) for the cost_center
-- 05/23/2013 MDH for Address records add the ADDRESS_TYPE parameter
-- 05/30/2013 MDH only finish this procedure if v_count >0 otherwise let it
--                drop out as there are no records to expire.
--*****************************************************************************
if v_count  >  0  then
  begin
    v_break  :=  ('Entered the COMMON_TOOLS.Expire_Data_SP (Found unexpire recd)' ); 
--
    if in_ROW_TABLE in ('ADDRESS_CAN','ADDRESS_MEX','ADDRESS_OTHER','ADDRESS_USA') then
        sql_stmt := ('select EXPIRATION_DATE, ROWID from ' ||
                  in_ROW_TABLE || 
                  ' where COST_CENTER_CODE =  :in_COST_CENTER ' ||
                  ' and ADDRESS_TYPE  =  :in_ADDRESS_TYPE ' || 
                  ' and EXPIRATION_DATE is null');
         EXECUTE IMMEDIATE sql_stmt INTO v_expiration_date, v_row_id USING in_COST_CENTER, in_ADDRESS_TYPE;          
    else
        sql_stmt := ('select EXPIRATION_DATE, ROWID from ' ||
                  in_ROW_TABLE || 
                  ' where COST_CENTER_CODE =  :in_COST_CENTER ' || 
                  ' and EXPIRATION_DATE is null');
        EXECUTE IMMEDIATE sql_stmt INTO v_expiration_date, v_row_id USING in_COST_CENTER;          
    end if;                 
--
--      EXECUTE IMMEDIATE sql_stmt INTO v_expiration_date, v_row_id USING in_COST_CENTER, in_ADDRESS_TYPE;
--               
  exception
     when others then
        raise no_unexpire_exp;
  
  end;
--
--************************************************************************************
-- if found, compute the expiration date using the COMPUTE_EXPIRATION_DATE function
--  in_ROW_TABLE.expiration_date := COMPUTE_EXPIRATION_DATE ( in_EFFECTIVE_DATE);
--************************************************************************************
--
    v_date := COMPUTE_EXPIRATION_DATE ( in_EFFECTIVE_DATE); --in_EFFECTIVE_DATE - 1   
--
--    
--*****************************************************************************
--  update the table/row for IN_ROW_TABLE
--*****************************************************************************
  begin
       v_break  :=  ('Entered the COMMON_TOOLS.Expire_Data_SP (Update expire date)' ); 
       v_expiration_date := v_date;
       sql_stmt := ('UPDATE ' || in_ROW_TABLE ||
                    ' SET EXPIRATION_DATE =  :v_expiration_date ' ||
                    ' WHERE  rowid = :v_row_id ');
 
       EXECUTE IMMEDIATE sql_stmt USING v_expiration_date, v_row_id;
-- 
--   
            EXCEPTION 
             WHEN OTHERS THEN 
                 raise record_update_exp;
--
  end;
end if;

EXCEPTION

   when parameter_null_exp then  
	   		v_code := errnums.en_parameter_null_err;
		      errpkg.raise_err(v_code, 'COMMON_TOOLS.EXPIRE_DATA_SP.parameter_null_exp ' 
             		,'One or more input parameteres is null ' );     
                
   when multiple_expire_exp then  
		   		v_code := errnums.en_multipl_expire_err;
			      errpkg.raise_err(v_code, 'COMMON_TOOLS.EXPIRE_DATA_SP.multipl_expire_exp ' 
             		,'More than 1 unexpired rows found for table: ' ||
                    in_ROW_TABLE ||   ' ccntr: ' ||
                  in_COST_CENTER );     
               
   when no_unexpire_exp then  
		   		v_code := errnums.en_no_unexpire_err;
			      errpkg.raise_err(v_code, 'COMMON_TOOLS.EXPIRE_DATA_SP.no_unexpire_exp ' 
             		,'No unexpired rows found for table: ' ||
                    in_ROW_TABLE ||   ' ccntr: ' ||
                  in_COST_CENTER );     
              
   when record_update_exp then  
 		   		v_code := errnums.en_record_update_err;
			      errpkg.raise_err(v_code, 'COMMON_TOOLS.EXPIRE_DATA_SP.record_update_exp ' 
            		,'Record Update Error for table: ' ||
                    in_ROW_TABLE ||   ' ccntr: ' ||
                  in_COST_CENTER  ||
                  ' ROW ID: ' || V_ROW_ID);
                   
    when others then
        v_code  := SQLCODE;
        v_errm  := substr(SQLERRM,1,500);
        errpkg.raise_err(v_code, 'COMMON_TOOLS.EXPIRE_DATA_SP Error' ||
                         v_errm || 
                        v_break );


END EXPIRE_DATA_SP;
/

