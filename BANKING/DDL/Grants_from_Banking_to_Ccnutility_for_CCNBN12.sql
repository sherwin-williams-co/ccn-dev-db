/********************************************************************************** 
This script is created to give Select privileges on these Tables to
the CCN_UTILITY Schema

Created : 07/26/2019 axm868 CCN Project CCNBN-12....
          Run this script in BANKING Schema
Modified: 
**********************************************************************************/
GRANT SELECT ON ERROR_LOG TO CCN_UTILITY;
GRANT SELECT ON BANK_DEP_TICKORD TO CCN_UTILITY;
GRANT SELECT ON BANK_DEP_BAG_TICKORD TO CCN_UTILITY;
GRANT SELECT ON BANK_DEP_TICK TO CCN_UTILITY;
GRANT SELECT ON BANK_DEP_BAG_TICK TO CCN_UTILITY;
GRANT SELECT ON BANK_DEP_TICK_BAG_EXCLD_CCS TO CCN_UTILITY;