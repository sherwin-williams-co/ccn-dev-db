/*

Created by rxv940 on 03/16/2018
Run this in COSTCNTR
This should be run on PROD on Mar 31(Sat)
ASP-1040

*/

 -- SELECT for backup purposes 
    SELECT *
      FROM GENERAL_LEDGER_ACCOUNTS
     WHERE GL_ACCOUNT_NUMBER = '0400056';

 -- Expire by updating the expiration date for account '0400056'
    UPDATE GENERAL_LEDGER_ACCOUNTS
       SET EXPIRATION_DATE = SYSDATE
     WHERE GL_ACCOUNT_NUMBER = '0400056';

    COMMIT;
    
 -- Insert a new account and its children     
    INSERT INTO GENERAL_LEDGER_ACCOUNTS
    VALUES ('7599124', 'HOMEOWNER WELCOME BUILDER WARRANTY', '064', SYSDATE, 'pmm4br', NULL);
    INSERT INTO PRGM_GL_ACCNT_RLTN_DTLS
    VALUES ('7599124', 'STOREXP', '0', 'false', SYSDATE, 'pmm4br', NULL);
    
    COMMIT;
