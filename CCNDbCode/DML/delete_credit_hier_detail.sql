/********************************************************************************
Below script will delete and insert into Hierarchy tables for Credit Hierarchy

Created : 07/27/2016 vxv336 CCN Project Team....
Modified: 
********************************************************************************/
begin
  delete from hierarchy_detail where HRCHY_HDR_NAME = 'CREDIT_HIERARCHY';
  delete from hierarchy_description where HRCHY_HDR_NAME = 'CREDIT_HIERARCHY';
  delete FROM hierarchy_header where HRCHY_HDR_NAME = 'CREDIT_HIERARCHY';
  commit;
  CREDIT_HIERARCHY_LOAD.CREDIT_HIERARCHY_LOAD_MAIN_SP;
end;