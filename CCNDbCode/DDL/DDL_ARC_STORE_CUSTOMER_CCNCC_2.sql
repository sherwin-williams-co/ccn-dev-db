/*******************************************************************************
Alter table script to add new column DESIGNATED_TERMINAL_NUMBER field to ARC_STORE table.

CREATED : 07/08/2019 axm868 CCNCC-2 CCN Project...
*******************************************************************************/

BEGIN
    CC_ARCHIVE_DELET_RECREATE_PKG.RECREATE_MISMTCH_ARCHV_TBL_SP();
END;