/*
ASP-1255 This script will add STORECCN column in CCN_HEADERS_T table.
         AND drop obsolete 4 chars column store_no .       
Created  : 05/31/2019 sxs484 
*/
    ALTER TABLE CCN_HEADERS_T
    ADD (STORECCN VARCHAR2(6));

    ALTER TABLE CCN_HEADERS_T
    DROP COLUMN STORE_NO
    ;
/