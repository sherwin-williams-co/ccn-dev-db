/*****************************************************************************
Below script is to add a column to track the drafts marked as stopped from CCN side

created : 05/11/2016 jxc517 CCN Project....
changed :
*****************************************************************************/
ALTER TABLE STORE_DRAFTS ADD STOP_PAY_MARKED_BY_CCN_IND VARCHAR2(1);
ALTER TABLE HST_STORE_DRAFTS ADD STOP_PAY_MARKED_BY_CCN_IND VARCHAR2(1);
ALTER TABLE UNATTACHED_MNL_DRFT_DTL ADD STOP_PAY_MARKED_BY_CCN_IND VARCHAR2(1);
ALTER TABLE UNATTACHED_MNL_DRFT_DTL_HST ADD STOP_PAY_MARKED_BY_CCN_IND VARCHAR2(1);
