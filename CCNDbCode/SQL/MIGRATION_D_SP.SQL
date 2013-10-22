PROCEDURE MIGRATION_D_SP (
/*****************************************************************************
	MIGRATION_D_SP

	This procedure will Delete specified MIGRATION records

	MIGRATION_ID - ID of Migration Record to Delete
	ENVIRONMENT  - DEV, TEST, QA, PROD
	OBJECT_NAME	 - Name of Specific Object to Delete, If left as NULLs then
                  all Detail that match on ID and Environment will be Deleted.
  SELECT_CODE - Records to Delete "D" = Detail, "H" = Header, "B" = Both

created: 02/08/2012 TAL CCN Project....
changed:
*******************************************************************************/
/***  below are the fields required for the MIGRATION Delete ***/
	 in_MIGRATION_ID    in  varchar2
	,IN_ENVIRONMENT     in  varchar2
	,in_OBJECT_NAME     in  varchar2
  ,in_SELECT_CODE     in  varchar2
)

 is 
 v_code number;
 v_errm varchar2(500);
 v_count number;
    
-- Error #01
   migrations_select_exp          exception;
-- Error #02
   migrations_header_exp          exception;
-- Error #02
   migrations_detail_exp          exception;
    
BEGIN   --  Procedure

        IF  in_SELECT_CODE  not in  ('H', 'D', 'B' ) Then  -- Header, Detail, or Both
            raise migrations_select_exp;
--      See Error #01.
        End if;   --  Test for valid selection code

    BEGIN   -- Test for Delete Migartions_Detail

        IF  in_SELECT_CODE  =   'D'  
        or  in_SELECT_CODE  =   'B'   Then
        
            select  count(*)
              into v_count
              from MIGRATIONS_DETAIL
            where  MIGRATION_ID = in_MIGRATION_ID
             and   ENVIRONMENT  = in_ENVIRONMENT
--                 if in_Object_Name is NULL, then set in_Object_Name to Object_name              
             and   OBJECT_NAME  = NVL(in_OBJECT_NAME, MIGRATIONS_DETAIL.OBJECT_NAME); 
             
            If  v_count =  '0'   Then
                raise migrations_detail_exp;
--          See Error #02.
            Else
                DELETE  from  MIGRATIONS_DETAIL
                 where  MIGRATION_ID = in_MIGRATION_ID
                  and   ENVIRONMENT  = in_ENVIRONMENT
--                      if in_Object_Name is NULL, then set in_Object_Name to Object_name              
                  and   OBJECT_NAME  = NVL(in_OBJECT_NAME, MIGRATIONS_DETAIL.OBJECT_NAME); 
              
            End if;   --  Test for number of records = 0
             
        END IF;   --  Test for in_SELECT_CODE  =  'D'  or  'B'

    END;    -- Test for Delete Migartions_Detail

    BEGIN   -- Test for Delete Migartions_Header

        IF  in_SELECT_CODE  =   'H'  
        or  in_SELECT_CODE  =   'B'   Then
        
            select  count(*)
              into v_count
              from MIGRATIONS_HEADER
            where  MIGRATION_ID = in_MIGRATION_ID
             and   ENVIRONMENT  = in_ENVIRONMENT; 
             
            If  v_count =  '0'   Then
                raise migrations_header_exp;
--          See Error #03.
            Else            	
                DELETE  from  MIGRATIONS_HEADER
                 where  MIGRATION_ID = in_MIGRATION_ID
                  and   ENVIRONMENT  = in_ENVIRONMENT;
                 
            End if;   --  Test for number of records = 0
             
        END IF;   --  Test for in_SELECT_CODE  =  'H'  or  'B'

    END;    -- Test for Delete Migartions_Header
    
/*******************************************************************************
	  EXCEPTION ERRORS AREA
*******************************************************************************/	  
	
        EXCEPTION
          
-- Error #01
        when migrations_select_exp     then
            v_code := errnums.en_selection_code_err; 
            errpkg.raise_err(v_code, 'MIGRATION_D_SP.migrations_select_exp -' ||
            ' Selection code was entered as "' || in_SELECT_CODE || '".' ||
            ' Valid Values Are: "H" for Header, "D" for Detail, or "B" for Both.' );   

 -- Error #02
        when migrations_detail_exp     then
            v_code := errnums.en_migration_update_err; 
            errpkg.raise_err(v_code, 'MIGRATION_D_SP.migrations_detail_exp -' ||
            ' NO Migrations_Detail Records Found'       ||
            ' For: Migration_ID = ' || in_MIGRATION_ID  || ',' ||
            ' Environment = '       || in_ENVIRONMENT   || '.' );   

 -- Error #03
        when migrations_header_exp     then
            v_code := errnums.en_migration_update_err; 
            errpkg.raise_err(v_code, 'MIGRATION_D_SP.migrations_header_exp -' ||
            ' NO Migrations_Header Records Found'       ||
            ' For: Migration_ID = ' || in_MIGRATION_ID  || ',' ||
            ' Environment = '       || in_ENVIRONMENT   || '.' );  

 -- Error Others            
        when OTHERS then 
            v_code  := SQLCODE;
            v_errm  := substr(sqlerrm,1,200);
            errpkg.raise_err(v_code, 'MIGRATION_D_SP' ||
                ' TABLE IS MIGRATIONS_HEADER/DETAIL'  );
 
end MIGRATION_D_SP;
/

