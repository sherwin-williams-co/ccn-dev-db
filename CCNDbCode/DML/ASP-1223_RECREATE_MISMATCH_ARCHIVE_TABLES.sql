/***********************************************************************
 Execute the below script only if there are any differences in the data types

  Created: 03/27/2019 dxp896 CCN Proj Team...
************************************************************************/
set serveroutput on;
set timing on;
set heading off;
set verify off;

declare

BEGIN

      CC_ARCHIVE_DELET_RECREATE_PKG.RECREATE_MISMTCH_ARCHV_TBL_SP;

exception
when others then 
dbms_output.put_line('ReCreate Mismatch Archive Tables error ' || SQLERRM || SQLCODE );
end;