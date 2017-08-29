CREATE OR REPLACE VIEW DESCARTES_STORES_TIMEZONE_VW AS 
  SELECT 
        /********************************************************************************
        This script Creates new view DESCARTES_STORES_TIMEZONE_VW 
        to provide drivers cost centers time zone to GEMS for Descartes Feed.

        Currently, This view handles US Stores and returns NULL for other countries

        Created : 08/28/2017 rxa457 CCN Project Team....

        ********************************************************************************/
        COST_CENTER_CODE,
        COMMON_TOOLS.GET_TIMEZONE(COST_CENTER_CODE) TIME_ZONE
    FROM COST_CENTER;
