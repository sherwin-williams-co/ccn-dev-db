/*
Script Name: DML_SQ_FT_MAILING_DTLS.sql
Purpose    : 
             

Created : 02/20/2018 axt754 CCN Project....
Changed :
*/


INSERT INTO MAILING_DETAILS (MAIL_CATEGORY, GROUP_ID, SUBJECT, FROM_P, MESSAGE, SIGNATURE) 
                     VALUES ('SQ_FT_CC_NOT_EXISTS_IN_CCN', 
                             '26', 
                             'Sq footage Batch Cost centers not Exists in CCN', 
                             'ccnoracle.team@sherwin.com', 
                             'Please find the attachment of cost centers from sq footage batch process which are not present in CCN', 
                             'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
                             
COMMIT;