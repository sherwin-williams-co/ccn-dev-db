/**********************************************************************************
Below script is created to GRANT SELECT privilege on CCN_PHONE_INFO_VW
to CCN_UTILITY DB and creating synonymn .
Created : 08/23/2018 kxm302 CCN Project 
Modified:
**********************************************************************************/

GRANT SELECT ON CCN_PHONE_INFO_VW TO CCN_UTILITY;
CREATE OR REPLACE SYNONYM CCN_UTILITY.CCN_PHONE_INFO_VW FOR COSTCNTR.CCN_PHONE_INFO_VW;