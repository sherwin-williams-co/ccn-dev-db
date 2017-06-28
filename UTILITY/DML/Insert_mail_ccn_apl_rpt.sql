/*
     Created: 06/19/2017 axt754 CCN Project Team..
     This script creates a new mail_category for ccn 
     accounting view report
*/
-- Insert into MAILING GROUP
INSERT INTO MAILING_GROUP 
      VALUES (86, 'psg.finplan@sherwin.com');
      
-- check the inserted value
SELECT *
  FROM MAILING_GROUP
 WHERE GROUP_ID = '86';   
 
 
-- Insert into MAILING_DETAILS 
INSERT INTO MAILING_DETAILS
    VALUES  ('CCN_ACCNT_REPORT',86,'CCN accounting view report'
            ,'ccnoracle.team@sherwin.com','Please find the attachment of ccn accounting view report'
            ,'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

-- Check the inserted value
SELECT * 
  FROM MAILING_DETAILS
 WHERE MAIL_CATEGORY = 'CCN_ACCNT_REPORT';
 

 
-- COMMIT THE TRANSACTION
COMMIT;