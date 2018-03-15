/*******************************************************************************
  Alter table script to add VOID_MARKED_BY_CCN   columns to below list of table.
  CREATED : 03/15/2018 bxa919 CCN Project...
*******************************************************************************/

Alter table STORE_DRAFTS
ADD   VOID_MARKED_BY_CCN VARCHAR2(4 BYTE);

Alter table POS_UNATTACHED_MNL_DRFT_DTL
ADD   VOID_MARKED_BY_CCN VARCHAR2(4 BYTE);

Alter table POS_UNATTCHD_MNL_DRFT_HST
ADD   VOID_MARKED_BY_CCN VARCHAR2(4 BYTE);

Alter table STORE_DRAFTS_PROD
ADD   VOID_MARKED_BY_CCN VARCHAR2(4 BYTE);

Alter table POS_HST_STORE_DRAFTS
ADD   VOID_MARKED_BY_CCN VARCHAR2(4 BYTE);

Alter table POS_STORE_DRAFTS
ADD   VOID_MARKED_BY_CCN VARCHAR2(4 BYTE);

Alter table UNATTACHED_MNL_DRFT_DTL_HST
ADD   VOID_MARKED_BY_CCN VARCHAR2(4 BYTE);

Alter table UNATTACHED_MNL_DRFT_DTL
ADD   VOID_MARKED_BY_CCN VARCHAR2(4 BYTE);

Alter table HST_STORE_DRAFTS
ADD   VOID_MARKED_BY_CCN VARCHAR2(4 BYTE);