/*******************************************************************************
Created : 09/14/2018 pxa852 CCN Project Team...
          The script will create store_hst table to track changes on store table.
Changed :
*******************************************************************************/

CREATE TABLE STORE_HST
   (COST_CENTER_CODE             VARCHAR2(6) NOT NULL,
    CATEGORY                     VARCHAR2(1) NOT NULL,
    PERP_INV_START_DATE          DATE,
    CLASSIFICATION_CODE          VARCHAR2(2),
    INVENTORY_INDICATOR          VARCHAR2(1),
    RURAL_METRO_ZONE_CODE        VARCHAR2(1),
    SELLING_STORE_FLAG           VARCHAR2(1),
    SALES_VOL_CLASS_CODE         VARCHAR2(2),
    SELLING_STORE_FLAG_MARK_DT   DATE,
    POTENTIAL_OPEN_DATE          DATE,
    POS_VERSION_NBR              VARCHAR2(20),
    POS_VERSION_NBR_APPLIED_DATE DATE,
    DESCARTES_DELIVERY_CODE      VARCHAR2(1),
    CHANGED_DATE                 DATE
   );