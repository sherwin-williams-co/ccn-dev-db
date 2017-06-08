/*
     Created: 06/07/2017 axt754 CCN Project Team..
     This script creates a new mail_category for selling stores 
     when reported error
*/
-- Insert into MAILING_DETAILS 
INSERT INTO MAILING_DETAILS
    VALUES  ('SELLING_STORES_ERROR',51,'Job Failed for Selling Store Details'
            ,'ccnoracle.team@sherwin.com','Failed to Generate Selling Store Details'
            ,'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

-- Check the inserted value
SELECT * 
  FROM MAILING_DETAILS
 WHERE MAIL_CATEGORY = 'SELLING_STORES_ERROR';
 
-- COMMIT THE TRANSACTION
COMMIT;