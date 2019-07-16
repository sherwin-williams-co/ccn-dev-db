/*******************************************************************************
  Alter table script to add column to territory table.
  CREATED : 06/26/2019 akj899 CCNCC-4 CCN Project Team...
*******************************************************************************/
ALTER TABLE TERRITORY
ADD (TERRITORY_TYP_OF_BUSN_SGMNT_CD  VARCHAR2(2)
     );