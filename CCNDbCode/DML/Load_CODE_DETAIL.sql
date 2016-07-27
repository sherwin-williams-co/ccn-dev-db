begin
  DELETE FROM code_detail WHERE CODE_HEADER_NAME in ('ACM','DCM','RCM','SYSOUT');
  
  CREDIT_HIERARCHY_LOAD.LOAD_CODE_DETAIL('CRDT_HIER_ACM_LOOKUP');
  CREDIT_HIERARCHY_LOAD.LOAD_CODE_DETAIL('CRDT_HIER_DCM_LOOKUP');
  CREDIT_HIERARCHY_LOAD.LOAD_CODE_DETAIL('CRDT_HIER_RCM_LOOKUP');
end;