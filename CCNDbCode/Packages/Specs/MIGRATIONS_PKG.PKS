create or replace
PACKAGE MIGRATIONS_PKG AS
/*********************************************************** 
This package SPEC has procedures and functions related to the MIGRATIONS table

created : 02/12/2013 kdp CCN project
revisions: 

************************************************************/

PROCEDURE MIGRATION_S_SP   (
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
  ); 
  
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
        );   

PROCEDURE MIGRATIONS_I_SP (
/*******************************************************************************
	MIGRATION_I_SP

	This procedure is intended to insert new MIGRATIONS_HEADER and MIGRATIONS_DETAIL
  Table rows

	OracleTableName -Table name for row -varible 
            (based on the table that was updated)
  XMLDATA   -  The data being inserted 
  
created: 02/07/2013 MDH CCN Project....
*******************************************************************************/
     in_row_data               in  varchar2 --sys.xmltype
           );   

PROCEDURE MIGRATION_U_SP (
/*******************************************************************************
	MIGRATION_U_SP

	This procedure is intended to Update MIGRATION tables for header null
  records.


created : 02/06/2012 blr CCN Project....
revised :  

*******************************************************************************/
 in_row_data             in  varchar2 --sys.xmltype
);

END MIGRATIONS_PKG;