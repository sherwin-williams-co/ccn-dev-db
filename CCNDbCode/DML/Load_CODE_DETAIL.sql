/********************************************************************************
Below script will refresh code_detail table for Credit Hierarchy

Created : 07/27/2016 vxv336 CCN Project Team....
Modified: 08/19/2016 vxv336 Removed SYSOUT
********************************************************************************/

begin
  DELETE FROM code_detail WHERE CODE_HEADER_NAME in ('ACM','DCM','RCM');
  
  CREDIT_HIERARCHY_LOAD.LOAD_CODE_DETAIL('CRDT_HIER_ACM_LOOKUP');
  CREDIT_HIERARCHY_LOAD.LOAD_CODE_DETAIL('CRDT_HIER_DCM_LOOKUP');
  CREDIT_HIERARCHY_LOAD.LOAD_CODE_DETAIL('CRDT_HIER_RCM_LOOKUP');
end;