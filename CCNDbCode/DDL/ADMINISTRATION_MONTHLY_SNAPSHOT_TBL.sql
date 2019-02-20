/*******************************************************************************
This script is intended to create a ADMINISTRATION_MONTHLY_SNAPSHOT_TBL table which
holds the data from administration table.This table will be loaded on monthly basis.
CREATED : 02/20/2019 pxa852 CCN Project...
*******************************************************************************/
CREATE TABLE ADMINISTRATION_MONTHLY_SNAPSHOT_TBL
    (COST_CENTER_CODE     VARCHAR2(6) NOT NULL,
     CATEGORY             VARCHAR2(1) NOT NULL,
     INTERNAL_MAIL_NUMBER VARCHAR2(3),
     ADMIN_COST_CNTR_TYPE VARCHAR2(5),
     ALLOCATION_CC        VARCHAR2(10),
     DIVISION_OFFSET      VARCHAR2(10),
     LOAD_DATE            DATE,
   CONSTRAINT ADMIN_MNTHLY_SNAPSHOT_PK PRIMARY KEY (COST_CENTER_CODE, LOAD_DATE)
   );

CREATE INDEX ADMIN_MNTHLY_SNAPSHOT_INDEX ON ADMINISTRATION_MONTHLY_SNAPSHOT_TBL (LOAD_DATE);