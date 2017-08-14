CREATE OR REPLACE VIEW TAXWARE_VW AS 
  SELECT
/*******************************************************************************
This view will provide the TAXWare information.

Created  : 08/11/2017 gxg192 CCN Project
Modified :
*******************************************************************************/
         COST_CENTER_CODE
        ,TWJ_STATE AS TW_STATE_CODE
        ,TWJ_ZIP AS TW_ZIPCODE
        ,TWJ_GEO AS TW_GEO_CODE
        ,TWJ_COUNTRY AS TW_COUNTRY
        ,TWJ_COMPANY AS TW_COMPANY
FROM TAXWARE;