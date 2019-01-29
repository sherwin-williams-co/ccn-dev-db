/*******************************************************************************
This script will create a view GLOBAL_HIERARCHY_ATTRBT_MNTH_SNAP_VW
Created  : 01/23/2019 SXG151 CCN
*******************************************************************************/
CREATE OR REPLACE VIEW GLOBAL_HIERARCHY_ATTRBT_MNTH_SNAP_VW AS
SELECT *
  FROM GLOBAL_HIERARCHY_ATTRBT_MNTH_SNAP
 WHERE LOAD_DATE = (SELECT MAX(LOAD_DATE)
                      FROM GLOBAL_HIERARCHY_ATTRBT_MNTH_SNAP
                    );