/*******************************************************************************
  Insert script to add the code header and code detail information
  CREATED : 08/08/2016 mxk766 CCN Project
  CHANGED : 
*******************************************************************************/
SET DEFINE OFF;

INSERT INTO CODE_HEADER 
(CODE_HEADER_NAME
,CODE_HEADER_TYPE
,CODE_HEADER_DESCRIPTION
,CODE_HEADER_EXPIRE_FLAG
,CODE_HEADER_EXPIRE_USER
,CODE_HEADER_EXPIRE_EFF_DATE
,CODE_HEADER_DTL_VAL_SIZE
,CODE_HEADER_DTL_VAL_DEFAULT
,CODE_HEADER_CREATE_USER
,CODE_HEADER_EFF_DATE
,CODE_HEADER_IDENTIFIER
) 
VALUES 
(
 'CC_TEMP_CLOSED_CD'
,'COD'
,'COST CENTER TEMPORARY CLOSED REASON'
,'N'
,NULL
,NULL
,2
,NULL
,NULL
,NULL
,NULL);

 
INSERT INTO CODE_DETAIL 
(
CODE_HEADER_NAME,
CODE_HEADER_TYPE,
CODE_DETAIL_VALUE,
CODE_DETAIL_DESCRIPTION,
CODE_DETAIL_EXPIRE_FLAG,
CODE_DETAIL_EXPIRE_USER,
CODE_DETAIL_EXPIRE_EFF_DATE,
CODE_DETAIL_ID,
CODE_DETAIL_CREATE_USER,
CODE_DETAIL_EFF_DATE
) 
VALUES 
(
'CC_TEMP_CLOSED_CD',
'COD',
'01',
'01-CLOSED DUE TO RENOVATION',
NULL,
NULL,
NULL,
1,
NULL,
NULL
);

INSERT INTO CODE_DETAIL 
(
CODE_HEADER_NAME,
CODE_HEADER_TYPE,
CODE_DETAIL_VALUE,
CODE_DETAIL_DESCRIPTION,
CODE_DETAIL_EXPIRE_FLAG,
CODE_DETAIL_EXPIRE_USER,
CODE_DETAIL_EXPIRE_EFF_DATE,
CODE_DETAIL_ID,
CODE_DETAIL_CREATE_USER,
CODE_DETAIL_EFF_DATE
) 
VALUES 
(
'CC_TEMP_CLOSED_CD',
'COD',
'02',
'02-CLOSED DUE TO ROOF REPAIR',
NULL,
NULL,
NULL,
2,
NULL,
NULL
); 

COMMIT;