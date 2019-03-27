/***********************************************************************
 Archive cost centers as per Pats request (LAD)

  Created: 03/27/2019 dxp896 CCN Proj Team...
************************************************************************/
set serveroutput on;
set timing on;
set heading off;
set verify off;

declare

BEGIN

      CC_ARCHIVE_DELET_RECREATE_PKG.PROCESS;

exception
when others then 
dbms_output.put_line('Archive cost centers as per Pats request error ' || SQLERRM || SQLCODE );
end;