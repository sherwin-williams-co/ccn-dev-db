/*
Created  : nxk927 04/25/2018
           Granting access for polling_hst table to ccn_utility and
           creating synonym for the same
*/
GRANT ALL ON POLLING_HST TO CCN_UTILITY;
CREATE OR REPLACE SYNONYM CCN_UTILITY.POLLING_HST FOR POLLING_HST;