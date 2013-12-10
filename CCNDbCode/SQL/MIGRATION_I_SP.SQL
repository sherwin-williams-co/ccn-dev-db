CREATE OR REPLACE procedure MIGRATION_I_SP (
/*********************************************************************************
	MIGRATION_I_SP

	This procedure is intended to insert new MIGRATIONS_HEADER and MIGRATIONS_DETAIL
  Table rows

	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
  XMLDATA   -  The data being inserted 
  
created: 02/07/2013 MDH CCN Project....
*********************************************************************************/
/***  below are the fields required for the ROWTYPE call: Table_name, Row_Data, Table_Rowtype ***/
 in_row_data              in  varchar2 --sys.xmltype
)
 is 
 v_code          number;
 v_errm          varchar2(500);
 v_row_value     varchar2(500);
 v_Row_data      sys.xmltype := xmltype(in_Row_data);
 v_migrations_hdr_rowtype  MIGRATIONS_HEADER%rowtype;
 v_migrations_dtl_rowtype  MIGRATIONS_DETAIL%rowtype; 
--
  no_migrations_detail_err    EXCEPTION;
--
--
--
cursor table_fields_hdr_cur is

    	SELECT column_name
          ,data_length column_size
          ,data_type
      	FROM all_tab_columns
      	WHERE TABLE_NAME = 'MIGRATIONS_HEADER'
        order by column_id asc
      	;
--       
cursor table_fields_dtl_cur is

    	SELECT column_name
          ,data_length column_size
          ,data_type
      	FROM all_tab_columns
      	WHERE TABLE_NAME = 'MIGRATIONS_DETAIL'
        order by column_id asc
      	;
        
begin
-- *************************************************************************
--               Convert MIGRATIONS_HEADER  XML to ROWTYPE                --
-- *************************************************************************
 for table_fields_rec in table_fields_hdr_cur loop
     
  if (v_Row_data.existsNode('/MIGRATIONS_UI/MIGRATIONS_HEADER/' || table_fields_rec.column_name ||'/text()') = 1) then

    if (table_fields_rec.data_type <> 'DATE') then
        v_row_value := v_Row_data.extract('/MIGRATIONS_UI/MIGRATIONS_HEADER/' || table_fields_rec.column_name ||'/text()').getStringVal()
                                              ; 
    else
          v_row_value := v_Row_data.extract('/MIGRATIONS_UI/MIGRATIONS_HEADER/' || table_fields_rec.column_name ||'/text()').getStringVal()
                                              ; 
    end if;
    
--      dbms_output.put_line('row value is ' || v_row_value);
 
/***  below is a list of all the fields in the table  ***/

	  CASE table_fields_rec.column_name
			when 'MIGRATION_ID'              then  v_migrations_hdr_rowtype.MIGRATION_ID            := v_row_value;
			when 'ENVIRONMENT'               then  v_migrations_hdr_rowtype.ENVIRONMENT             := v_row_value;
			when 'NAME'                      then  v_migrations_hdr_rowtype.NAME                    := v_row_value;
			when 'DESCRIPTION'               then  v_migrations_hdr_rowtype.DESCRIPTION             := v_row_value;
			when 'MIGRATION_DATE'            then  v_migrations_hdr_rowtype.MIGRATION_DATE          := TO_DATE(v_row_value,'MM-DD-YYYY');
 			when 'MIGRATION_TIMESTAMP'       then  v_migrations_hdr_rowtype.MIGRATION_TIMESTAMP     := v_row_value;
			when 'STATUS'                    then  v_migrations_hdr_rowtype.STATUS                  := v_row_value;
			when 'UPDT_USER'                 then  v_migrations_hdr_rowtype.UPDT_USER               := v_row_value;
 			when 'UPDT_TIMESTAMP'            then  v_migrations_hdr_rowtype.UPDT_TIMESTAMP          := v_row_value;
     ELSE
			null;		
		END CASE;	   	

 ELSE
    null ;
 end if;
 
end loop ;
--
--
-- *************************************************************************
--                Convert MIGRATIONS_DETAIL  XML to ROWTYPE               --
-- *************************************************************************
--

 for table_fields_rec in table_fields_dtl_cur loop

  if (v_Row_data.existsNode('/MIGRATIONS_UI/MIGRATIONS_DETAIL/' || table_fields_rec.column_name ||'/text()') = 1) then

    if (table_fields_rec.data_type <> 'DATE') then
        v_row_value := v_Row_data.extract('/MIGRATIONS_UI/MIGRATIONS_DETAIL/' || table_fields_rec.column_name ||'/text()').getStringVal()
                                              ; 
    else
          v_row_value := v_Row_data.extract('/MIGRATIONS_UI/MIGRATIONS_DETAIL/' || table_fields_rec.column_name ||'/text()').getStringVal()
                                              ; 
    end if;
    
--      dbms_output.put_line('row value is ' || v_row_value);
 
/***  below is a list of all the fields in the table  ***/

	  CASE table_fields_rec.column_name
			when 'MIGRATION_ID'              then  v_migrations_dtl_rowtype.MIGRATION_ID            := v_row_value;
			when 'ENVIRONMENT'               then  v_migrations_dtl_rowtype.ENVIRONMENT             := v_row_value;
			when 'OBJECT_NAME'               then  v_migrations_dtl_rowtype.OBJECT_NAME             := v_row_value;
			when 'OBJECT_PATH'               then  v_migrations_dtl_rowtype.OBJECT_PATH             := v_row_value;
			when 'OBJECT_TYPE'               then  v_migrations_dtl_rowtype.OBJECT_TYPE             := v_row_value;
 			when 'VERSION'                   then  v_migrations_dtl_rowtype.VERSION                 := v_row_value;
			when 'UPDT_USER'                 then  v_migrations_dtl_rowtype.UPDT_USER               := v_row_value;
 			when 'UPDT_TIMESTAMP'            then  v_migrations_dtl_rowtype.UPDT_TIMESTAMP          := v_row_value;
     ELSE
			null;		
		END CASE;	   	

 ELSE
    null ;
 end if;

end loop ;
--
--
--  Make sure there is a MIGRATIONS_DETAIL record to be stored when header is stored.
if v_migrations_dtl_rowtype.ENVIRONMENT    is null  or
   v_migrations_dtl_rowtype.OBJECT_NAME    is null  or 
   v_migrations_dtl_rowtype.OBJECT_PATH    is null  or 
   v_migrations_dtl_rowtype.OBJECT_TYPE    is null  or 
   v_migrations_dtl_rowtype.VERSION        is null  or 
   v_migrations_dtl_rowtype.UPDT_TIMESTAMP is null  then 
      raise no_migrations_detail_err;
 end if;
--
--
   v_migrations_hdr_rowtype.MIGRATION_ID   := MIGRATION_ID_SEQ.nextval;
   v_migrations_hdr_rowtype.UPDT_TIMESTAMP := CURRENT_TIMESTAMP;
   v_migrations_dtl_rowtype.MIGRATION_ID   := v_migrations_hdr_rowtype.MIGRATION_ID;
   v_migrations_dtl_rowtype.UPDT_TIMESTAMP := CURRENT_TIMESTAMP;   
--   OUT_MIGRATIONS_HEADER   :=  v_migrations_hdr_rowtype;
--
--  insert into MIGRATIONS_HEADER Table
--                  
      insert into MIGRATIONS_HEADER values v_migrations_hdr_rowtype;
--
--
--  insert into MIGRATIONS_DETAIL Table
--                  
      insert into MIGRATIONS_DETAIL values v_migrations_dtl_rowtype;      
      
      commit;
      
  EXCEPTION
         
   when no_migrations_detail_err then  
        v_code := errnums.en_no_migrations_detail_err;
        errpkg.raise_err(v_code, 'MIGRATIONS_I_SP.no_migrations_detail_err ',    
        'Migration ID "' || v_migrations_hdr_rowtype.MIGRATION_ID || '". ' || 
        'Environment "' || v_migrations_hdr_rowtype.ENVIRONMENT || '". ' ||         
        'CCN_MIGRATIONS_UI_PKG ' || 'No MIGRATIONS_DETAIL row was sent for processing. '); 
        
	  WHEN OTHERS THEN 
      v_code  := SQLCODE;
      v_errm  := substr(SQLERRM,1,200);
--      errpkg.raise_err(v_code, 'All_TABLE_COL_I_SP' ||
      errpkg.raise_err(v_code, 'MIGRATION_I_SP' ||      
             ' TABLE IS MIGRATIONS_HEADER/DETAIL');
 
end MIGRATION_I_SP;

