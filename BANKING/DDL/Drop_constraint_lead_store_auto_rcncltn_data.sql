/*
**************************************************************************** 
This script is created to drop a constraint on LEAD_STORE_AUTO_RCNCLTN_DATA table.
Since data in this table is static per month, constraint is not required on this table.

Created : 08/17/2017 gxg192 CCN Project.... 
Changed : 
****************************************************************************
*/

    ALTER TABLE LEAD_STORE_AUTO_RCNCLTN_DATA
DROP CONSTRAINT LEAD_BANK_AutoRecon_FK;