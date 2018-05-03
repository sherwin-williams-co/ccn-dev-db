/*
Created  : nxk927 04/25/2018
           Granting access for BANK_ACCOUNT_FUTURE table to ccn_utility and
           creating synonym for the same */

GRANT SELECT ON BANK_ACCOUNT_FUTURE TO CCN_UTILITY;

CREATE OR REPLACE SYNONYM CCN_UTILITY.BANK_ACCOUNT_FUTURE FOR BANK_ACCOUNT_FUTURE;