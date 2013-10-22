PROCEDURE MIGRATION_U_SP (
/*******************************************************************************
	MIGRATION_U_SP

	This procedure is intended to Update MIGRATION tables both Header and
  Detail. This procedure will be used to perform updates for any migration
  procedures.

created : 02/06/2012 blr CCN Project....
revised :  

*******************************************************************************/
 in_row_data             in  varchar2 --sys.xmltype
)  

 IS
  
 v_code                 number;
 v_errm                 varchar2(500);
 
--Select Header for Migration table 

CURSOR table_fields_hdr_cur is
     
       	SELECT column_name
          ,data_length column_size
          ,data_type
      	FROM all_tab_columns
      	WHERE TABLE_NAME = 'MIGRATIONS_HEADER'
        order by column_id asc
      	;
--/* 
--Select Detail for Migration table


CURSOR table_fields_dtl_cur is
     
        	SELECT column_name
          ,data_length column_size
          ,data_type
      	FROM all_tab_columns
      	WHERE TABLE_NAME = 'MIGRATIONS_DETAIL'
        order by column_id asc
      	;        
--*/ 

 v_row_value              varchar2(1000); 
 v_Row_data               sys.xmltype := xmltype(in_Row_data); 
 v_migrate_hdr_rowtype    MIGRATIONS_HEADER%rowtype;
 v_migrate_dtl_rowtype    MIGRATIONS_DETAIL%rowtype;  
 v_table_name             varchar2(20)  :=  '                '; 
 migrations_update_err    EXCEPTION;
 
 
--
--Mainline logic for setting up the Migration Header and Detail tables for updating a Migration.

BEGIN 
 
-- dbms_output.put_line('Begin Main Logic for Updating  ' );   
     
      
for table_fields_rec in table_fields_hdr_cur loop   
           
 if (v_Row_data.existsNode('/'|| 'MIGRATIONS_UI/MIGRATIONS_HEADER/' || table_fields_rec.column_name ||'/text()') = 1) then

         if (table_fields_rec.data_type <> 'DATE') then
           v_row_value :=  
               v_Row_data.extract('/'|| 'MIGRATIONS_UI/MIGRATIONS_HEADER/' || table_fields_rec.column_name ||'/text()').getStringVal();                  
   
         else
       
           v_row_value := rpad(v_Row_data.extract('/'|| 'MIGRATIONS_UI/MIGRATIONS_HEADER/' ||  table_fields_rec.column_name ||'/text()').getStringVal()
                   ,10); 
                        
         end if;
    
     
/***  below is a list of all the fields in the table  for Migration_header***/

	  	case table_fields_rec.column_name
 			when 'MIGRATION_ID'              then  v_migrate_hdr_rowtype.MIGRATION_ID            := TO_NUMBER(v_row_value);
 			when 'ENVIRONMENT'               then  v_migrate_hdr_rowtype.ENVIRONMENT             := v_row_value;
			when 'NAME'                      then  v_migrate_hdr_rowtype.NAME                    := v_row_value;
			when 'DESCRIPTION'               then  v_migrate_hdr_rowtype.DESCRIPTION             := v_row_value;
			when 'MIGRATION_DATE'            then  v_migrate_hdr_rowtype.MIGRATION_DATE          := TO_DATE(v_row_value,'MM-DD-YYYY');
 			when 'MIGRATION_TIMESTAMP'       then  v_migrate_hdr_rowtype.MIGRATION_TIMESTAMP     := v_row_value;
			when 'STATUS'                    then  v_migrate_hdr_rowtype.STATUS                  := v_row_value;
			when 'UPDT_USER'                 then  v_migrate_hdr_rowtype.UPDT_USER               := v_row_value;
 			when 'UPDT_TIMESTAMP'            then  v_migrate_hdr_rowtype.UPDT_TIMESTAMP          := v_row_value;
  	ELSE
			     null;		
		  END CASE;	   	

 ELSE
    null ;
 end if;

end loop ; 


--Align Detail for Migration table 

--/*


 for table_fields_rec in table_fields_dtl_cur loop
       
       -- dbms_output.put_line(v_Row_data.extract('MIGRATIONS_UI/MIGRATONS_DETAIL/MIGRATION_ID/ENVIRONMENT/OBJECT_NAME/text()').getStringVal());
      
      if (v_Row_data.existsNode('/'|| 'MIGRATIONS_UI/MIGRATIONS_DETAIL/' || table_fields_rec.column_name ||'/text()') = 1) then

         if (table_fields_rec.data_type <> 'DATE') then          
             v_row_value :=  
                  v_Row_data.extract('/'|| 'MIGRATIONS_UI/MIGRATIONS_DETAIL/' || table_fields_rec.column_name ||'/text()').getStringVal(); 
                   
          else
       
          v_row_value := rpad(v_Row_data.extract('/'|| 'MIGRATIONS_UI/MIGRATIONS_DETAIL/' || table_fields_rec.column_name ||'/text()').getStringVal()
                  ,10); 
                                               
        end if;
    
    
--*/ 
/***  below is a list of all the fields in the table for Migration_detail ***/
 
	  	case table_fields_rec.column_name
      when 'MIGRATION_ID'              then  v_migrate_dtl_rowtype.MIGRATION_ID            := TO_NUMBER(v_row_value);
 		  when 'ENVIRONMENT'               then  v_migrate_dtl_rowtype.ENVIRONMENT             := v_row_value;
  		when 'OBJECT_NAME'               then  v_migrate_dtl_rowtype.OBJECT_NAME             := v_row_value;
			when 'OBJECT_PATH'               then  v_migrate_dtl_rowtype.OBJECT_PATH             := v_row_value;
			when 'OBJECT_TYPE'               then  v_migrate_dtl_rowtype.OBJECT_TYPE             := v_row_value;
 			when 'VERSION'                   then  v_migrate_dtl_rowtype.VERSION                 := v_row_value;
			when 'UPDT_USER'                 then  v_migrate_dtl_rowtype.UPDT_USER               := v_row_value;
 			when 'UPDT_TIMESTAMP'            then  v_migrate_dtl_rowtype.UPDT_TIMESTAMP          := v_row_value;
  ELSE
			null;		
	  	END CASE;	   	

 ELSE
    null;
 end if;

end loop;


--
--
  
  IF ((v_migrate_hdr_rowtype.MIGRATION_ID =  v_migrate_dtl_rowtype.MIGRATION_ID) and           
      (v_migrate_hdr_rowtype.ENVIRONMENT  = v_migrate_dtl_rowtype.ENVIRONMENT)  ) THEN  
     
--UPDATE MIGRATIONS_HEADER;  
 

-- IF v_migrate_hdr_rowtype.MIGRATION_DATE  is not null then
    v_migrate_hdr_rowtype.MIGRATION_DATE  := CURRENT_DATE;
    v_migrate_hdr_rowtype.MIGRATION_TIMESTAMP := CURRENT_TIMESTAMP;
-- END IF;    
 
    v_migrate_hdr_rowtype.UPDT_TIMESTAMP := CURRENT_TIMESTAMP;
           
         UPDATE MIGRATIONS_HEADER 
         SET   NAME             = v_migrate_hdr_rowtype.name, 
               DESCRIPTION      = v_migrate_hdr_rowtype.description, 
               MIGRATION_DATE   = v_migrate_hdr_rowtype.migration_date, 
               MIGRATION_TIMESTAMP   = v_migrate_hdr_rowtype.migration_timestamp, 
               STATUS           = v_migrate_hdr_rowtype.status,                
               UPDT_USER        = v_migrate_hdr_rowtype.updt_user, 
               UPDT_TIMESTAMP   = v_migrate_hdr_rowtype.updt_timestamp 
           WHERE MIGRATION_ID   = v_migrate_hdr_rowtype.MIGRATION_ID   
              and ENVIRONMENT   = v_migrate_hdr_rowtype.ENVIRONMENT;     
  --      dbms_output.put_line('after update statement of header ');           
              
           COMMIT;   
       
--/*

 --UPDATE MIGRATIONS_DETAIL;
   
  v_migrate_dtl_rowtype.UPDT_TIMESTAMP := CURRENT_TIMESTAMP;   
  
  v_table_name := 'MIGRATIONS_DETAIL';
              
        UPDATE MIGRATIONS_DETAIL  
          SET OBJECT_PATH     = v_migrate_dtl_rowtype.object_path ,
              OBJECT_TYPE     = v_migrate_dtl_rowtype.object_type,
              VERSION         = v_migrate_dtl_rowtype.version,  
              UPDT_USER       = v_migrate_dtl_rowtype.updt_user,  
              UPDT_TIMESTAMP  = v_migrate_dtl_rowtype.UPDT_TIMESTAMP
          Where MIGRATION_ID  = v_migrate_dtl_rowtype.MIGRATION_ID   
             and ENVIRONMENT  = v_migrate_dtl_rowtype.ENVIRONMENT
             and OBJECT_NAME  = v_migrate_dtl_rowtype.OBJECT_NAME;
             
    
          COMMIT;  
           
   ELSE  
 --   dbms_output.put_line('DETAIL & HEADER KEYS DONT MATCH FOR UPDATE' );   
                 RAISE  migrations_update_err;
      
      
     
          
END IF;    
       
--*/        
          

--EXCEPTION ROUTINE FOR ERRORS  ----

 EXCEPTION
  
    when  migrations_update_err then  
	    v_code := errnums.en_migration_update_err ;
	    errpkg.raise_err(v_code, 'MIGRATION_U_SP.migrations_update_err  ' ,
        'MIGRATION_UI_PKG ' || 
        'Selected Migration_Id for Header was "' || v_migrate_hdr_rowtype.migration_id || ', ' || 
        'Selected ENVIRONMENT for Header was "' || v_migrate_hdr_rowtype.environment || ', ' || 
        'Selected Migration_Id for Detail was "' || v_migrate_dtl_rowtype.migration_id || ', ' ||         
        'Selected ENVIRONMENT for Detail was "' || v_migrate_dtl_rowtype.environment || ', ' ||
        'Problem: DETAIL & HEADER keys do not match cannot update. '); 
         
	  WHEN OTHERS THEN 
      v_code  := SQLCODE;
      v_errm  := substr(SQLERRM,1,200);
      errpkg.raise_err(v_code, 'MIGRATION_U_SP' ||
             'TABLE_NAME' || V_TABLE_NAME);
             
END MIGRATION_U_SP;
/

