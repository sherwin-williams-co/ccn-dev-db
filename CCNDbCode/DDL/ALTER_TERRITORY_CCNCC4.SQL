/*******************************************************************************
  Alter table script to add column to territory table.
  Call to RECREATE_MISMTCH_ARCHV_TBL_SP will ad the new column in archive table
  CREATED : 06/26/2019 akj899 CCNCC-4 CCN Project Team...
*******************************************************************************/
ALTER TABLE TERRITORY
ADD (TERRITORY_TYP_OF_BUSN_SGMNT_CD  VARCHAR2(2)
     );

BEGIN
    CC_ARCHIVE_DELET_RECREATE_PKG.RECREATE_MISMTCH_ARCHV_TBL_SP();
END;