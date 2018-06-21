/*******************************************************************************
  Alter table script to add BEGIN_DATE, TYPE and TYPE_CODE_DESC columns to CCN_ACCOUNTING_TBL table.
  CREATED : 06/02/2018 sxg151 CCN Project...
*******************************************************************************/
ALTER TABLE CCN_ACCOUNTING_TBL
ADD (BEGIN_DATE     DATE,
     TYPE_CODE      VARCHAR2(2),
     TYPE_CODE_DESC VARCHAR2(100)
     );