delete from hierarchy_detail where HRCHY_HDR_NAME = 'CREDIT_HIERARCHY';
delete from hierarchy_description where HRCHY_HDR_NAME = 'CREDIT_HIERARCHY';
delete FROM hierarchy_header where HRCHY_HDR_NAME = 'CREDIT_HIERARCHY';

commit;
