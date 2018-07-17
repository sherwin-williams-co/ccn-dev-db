/**********************************************************************************
Below script is created to GRANT SELECT privilege on ADMINORG_HIERARCHY_ATTRBT_VW
to CCN_UTILITY DB and creating synonymn .
Created : 07/17/2018 kxm302 CCN Project 
Modified:
**********************************************************************************/

GRANT SELECT ON ADMINORG_HIERARCHY_ATTRBT_VW TO CCN_UTILITY;
CREATE OR REPLACE SYNONYM CCN_UTILITY.GLOBAL_HIERARCHY_ATTRBT_VW FOR COSTCNTR.ADMINORG_HIERARCHY_ATTRBT_VW;