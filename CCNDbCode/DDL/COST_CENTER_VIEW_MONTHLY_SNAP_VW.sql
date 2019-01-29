/*******************************************************************************
This Script will Create a view COST_CENTER_VIEW_MONTHLY_SNAP_VW
Created  : 01/23/2019 SXG151 CCN
*******************************************************************************/
CREATE OR REPLACE VIEW COST_CENTER_VIEW_MONTHLY_SNAP_VW AS
SELECT *
  FROM COST_CENTER_VIEW_MONTHLY_SNAP
 WHERE LOAD_DATE = (SELECT MAX(LOAD_DATE)
                      FROM COST_CENTER_VIEW_MONTHLY_SNAP
                    );