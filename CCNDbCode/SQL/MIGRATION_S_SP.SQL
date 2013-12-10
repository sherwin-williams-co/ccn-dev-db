CREATE OR REPLACE PROCEDURE MIGRATION_S_SP   (
/**********************************************************
	MIGRATION_S_SP

	This procedure is intended to return a ref cursor with data from -
	from the MIGRATIONS_HEADER and MIGRATIONS_DETAIL tables.  

created : 02/06/2013 TAL CCN Project....
updated : 99/99/9999
**********************************************************/
  in_MIGRATION_ID        in  MIGRATIONS_DETAIL.MIGRATION_ID%type
, in_ENVIRONMENT         in  MIGRATIONS_DETAIL.ENVIRONMENT%type
, out_MIGRATIONS_HEADER_REF_CUR OUT sys_refcursor
, out_MIGRATIONS_DETAIL_REF_CUR OUT sys_refcursor
  )
   is

v_code number;
v_errm  varchar2(500);
  
BEGIN
                    
  BEGIN   -- MIGRATION_HEADER_REF_CUR
              
    OPEN out_MIGRATIONS_HEADER_REF_CUR FOR
			  
    SELECT * 
      FROM  MIGRATIONS_HEADER
      where MIGRATION_ID    = in_MIGRATION_ID
       and  ENVIRONMENT     = in_ENVIRONMENT ;
              
    EXCEPTION 
      WHEN OTHERS THEN 
        v_code  := SQLCODE;
        v_errm  := substr(SQLERRM,1,200);
        errpkg.raise_err(v_code,  
              ' MIGRATIONS_S_SP - MIGRATIONS_HEADER Error ' ||
              ' MIGRATION_ID = '  || in_MIGRATION_ID  ||
              ' ENVIRONMENT = '   || in_ENVIRONMENT   );
              
  END;    -- MIGRATION_HEADER_REF_CUR


  BEGIN   -- MIGRATION_DETAIL_REF_CUR

    OPEN out_MIGRATIONS_DETAIL_REF_CUR FOR
			  
    SELECT * 
      FROM  MIGRATIONS_DETAIL
      where MIGRATION_ID    = in_MIGRATION_ID
       and  ENVIRONMENT     = in_ENVIRONMENT
       ;
	  
    EXCEPTION 
      WHEN OTHERS THEN 
        v_code  := SQLCODE;
        v_errm  := substr(SQLERRM,1,200);
        errpkg.raise_err(v_code,  
              ' MIGRATIONS_S_SP - MIGRATIONS_DETAIL ' || 
              ' MIGRATION_ID = '  || in_MIGRATION_ID  ||
              ' ENVIRONMENT = '   || in_ENVIRONMENT   );
              
  END;    -- MIGRATION_DETAIL_REF_CUR

END MIGRATION_S_SP;

