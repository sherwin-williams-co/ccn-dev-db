/*******************************************************************************
Alter table script to add LAD_CUSTOMER_TYPE and ALLOCATION_CC fields to LAD_CUSTOMER table.

CREATED : 10/01/2018 kxm302/sxg151 CCN Project...
*******************************************************************************/

alter table LAD_CUSTOMER add (LAD_CUSTOMER_TYPE VARCHAR2(2),ALLOCATION_CC VARCHAR2(10));

 -- Execute below procedure to add new column to ARC_STORE table.
BEGIN
    CC_ARCHIVE_DELET_RECREATE_PKG.RECREATE_MISMTCH_ARCHV_TBL_SP();
END;