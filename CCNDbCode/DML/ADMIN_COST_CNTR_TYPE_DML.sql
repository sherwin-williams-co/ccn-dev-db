--inserting new picklist values for ADMIN_COST_CNTR_TYPE into code_detail only for the lower environments
SET DEFINE OFF;
Insert into CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('ADMIN_COST_CNTR_TYPE','COD','05','DISTRICT ALLOCATION COST CTR','N',null,null,5,null,null);
Insert into CODE_DETAIL (CODE_HEADER_NAME,CODE_HEADER_TYPE,CODE_DETAIL_VALUE,CODE_DETAIL_DESCRIPTION,CODE_DETAIL_EXPIRE_FLAG,CODE_DETAIL_EXPIRE_USER,CODE_DETAIL_EXPIRE_EFF_DATE,CODE_DETAIL_ID,CODE_DETAIL_CREATE_USER,CODE_DETAIL_EFF_DATE) values ('ADMIN_COST_CNTR_TYPE','COD','06','DSC-DISTRIBUTION CENTER','N',null,null,6,'pmm4br',null);
COMMIT;
