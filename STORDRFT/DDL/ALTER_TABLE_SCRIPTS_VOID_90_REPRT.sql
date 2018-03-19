/*******************************************************************************
  Alter table script to add VOID_MARKED_BY_CCN   columns to below list of table.
  CREATED : 03/15/2018 bxa919 CCN Project...
*******************************************************************************/


ALTER TABLE STORE_DRAFTS 
ADD VOID_MARKED_BY_CCN VARCHAR2(1);

ALTER TABLE UNATTACHED_MNL_DRFT_DTL_HST 
ADD VOID_MARKED_BY_CCN VARCHAR2(1);

ALTER TABLE UNATTACHED_MNL_DRFT_DTL 
ADD VOID_MARKED_BY_CCN VARCHAR2(1);

ALTER TABLE HST_STORE_DRAFTS 
ADD VOID_MARKED_BY_CCN VARCHAR2(1);