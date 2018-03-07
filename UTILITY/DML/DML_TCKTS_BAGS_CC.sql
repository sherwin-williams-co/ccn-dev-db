/*
Script Name: DML_TCKTS_BAGS_CC.sql
Purpose    : 
             

Created : 03/02/2018 axt754 CCN Project....
Changed :
*/

INSERT INTO MAILING_GROUP (GROUP_ID,MAIL_ID) VALUES ('105','ccnoracle.team@sherwin.com');

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY, GROUP_ID, SUBJECT, FROM_P, MESSAGE, SIGNATURE) 
                     VALUES ('CC_TCKT_BAG_NOT_EXISTS', 
                             '105', 
                             'Cost centers which are active but not having deposit bag details', 
                             'ccnoracle.team@sherwin.com', 
                             'Please find the attachment of cost centers in banking concentration, which are active but not having deposit bag details', 
                             'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');   
                             
INSERT INTO MAILING_DETAILS (MAIL_CATEGORY, GROUP_ID, SUBJECT, FROM_P, MESSAGE, SIGNATURE) 
                     VALUES ('CC_TCKTS_NOT_EXISTS', 
                             '105', 
                             'Cost centers which are active but not having deposit ticket details', 
                             'ccnoracle.team@sherwin.com', 
                             'Please find the attachment of cost centers in banking concentration, which are active but not having deposit ticket details', 
                             'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');  