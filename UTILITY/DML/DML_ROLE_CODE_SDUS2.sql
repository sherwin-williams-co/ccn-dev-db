/*
     DML_ROLE_CODE_SDUS2.sql
     Created : axt754 CCN Project Team....
     Changed :
     This Script Inserts the new ROLE_CODE SDUS2 into ROLE_DETAILS TABLE
*/

-- Check if any role code is present with 'SDUS2'
SELECT * FROM ROLE_DETAILS WHERE ROLE_CODE = 'SDUS2';

-- Insert ROLE_CODE 'SDUS2'
INSERT INTO ROLE_DETAILS VALUES('SDUS2','Store Drafts User - DIV Enquiry Window Select','N','N','N','Y',
'<USER_RULES>
   <STORE_DRAFTS_WINDOW>
      <VALUE>OUTSTANDING_DRFT_DIVISIONS</VALUE>
   </STORE_DRAFTS_WINDOW>
</USER_RULES>',
'<USER_RULES_DESCRIPTION>
   <STORE_DRAFTS_WINDOW>
      <OUTSTANDING_DRFT_DIVISIONS>
         <VALUE>C400</VALUE>
         <VALUE>C522</VALUE>
      </OUTSTANDING_DRFT_DIVISIONS>
   </STORE_DRAFTS_WINDOW>
</USER_RULES_DESCRIPTION>');

-- Check if the role code is inserted Properly
SELECT * FROM ROLE_DETAILS WHERE ROLE_CODE = 'SDUS2';

-- Commit The transaction
COMMIT;