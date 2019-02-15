/*******************************************************************************
This Script will Create a view COST_CENTER_VIEW_MONTHLY_SNAP_VW
Created  : 01/23/2019 SXG151 CCN
         : 02/15/2019 kxm302 CCN project
         : Renamed the column names for COST_CENTER_VIEW_MONTHLY_SNAP table
*******************************************************************************/
CREATE OR REPLACE VIEW COST_CENTER_VIEW_MONTHLY_SNAP_VW AS
SELECT *
  FROM COST_CENTER_VIEW_MONTHLY_SNAP
 WHERE LOAD_DATE = (SELECT MAX(LOAD_DATE)
                      FROM COST_CENTER_VIEW_MONTHLY_SNAP
                    );