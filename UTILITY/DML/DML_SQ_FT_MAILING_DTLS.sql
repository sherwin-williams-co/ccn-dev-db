/*
Script Name: DML_SQ_FT_MAILING_DTLS.sql
Purpose    : 
             

Created : 02/20/2018 axt754 CCN Project....
Changed : 04/13/2018 changed the body and subject
*/

INSERT INTO MAILING_GROUP (GROUP_ID,MAIL_ID) VALUES ('104','ccnoracle.team@sherwin.com');

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY, GROUP_ID, SUBJECT, FROM_P, MESSAGE, SIGNATURE) 
                     VALUES ('SQ_FT_CC_NOT_EXISTS_IN_CCN', 
                             '104', 
                             'CCN Sq Footage Batch Process Error', 
                             'ccnoracle.team@sherwin.com', 
                             'Please find the attachment that contains the reason for which cost centers lease/own code (or) sq footage update failed.', 
                             'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');                     
COMMIT;