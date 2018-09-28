/*******************************************************************************
Alter table script to add descartes_delivery_code field to store tables.

CREATED : 08/09/2018 pxa852 CCN Project...
*******************************************************************************/

   alter table store add descartes_delivery_code VARCHAR2(1);
  
   commit;


 -- Execute below procedure to add new column to ARC_STORE table.

BEGIN
   CC_ARCHIVE_DELET_RECREATE_PKG.RECREATE_MISMTCH_ARCHV_TBL_SP();
END;