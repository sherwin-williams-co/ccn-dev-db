/********************************************************************************** 
This script is created to insert data into MAILING_GROUP, MAILING_DETAILS
and MAILING_FILE_DETAILS tables.

Created : 07/26/2019 axm868 CCN Project CCNBN-12....
          Run these scripts in CCN_UTILITY
Modified: 
**********************************************************************************/
SET DEFINE OFF;

SELECT * FROM MAILING_GROUP;

SELECT * FROM MAILING_DETAILS;

SELECT * FROM MAILING_FILE_DETAILS;

--Development/Test/QA
INSERT INTO MAILING_GROUP (GROUP_ID,MAIL_ID) VALUES (139,'ccndevelopment.team@sherwin.com');

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
VALUES ('BAGS_AND_TKTS_BANKING_REPORTS',
        139,
        'Banking Reports for Bags and Tickets',
        'ccnoracle.team@sherwin.com',
        'Please find the attached the Banking Reports for Bags and Tickets',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'); 

--Production
INSERT INTO MAILING_GROUP (GROUP_ID,MAIL_ID) VALUES (139,'ccnsupport.team@sherwin.com;smis@sherwin.com');

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
VALUES ('BAGS_AND_TKTS_BANKING_REPORTS',
        139,
        'Banking Reports for Bags and Tickets',
        'ccnsupport.team@sherwin.com',
        'Please find the attached the Banking Reports for Bags and Tickets',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
		
INSERT INTO MAILING_FILE_DETAILS VALUES (1,139,'BAGS_AND_TKTS_BANKING_REPORTS','BANKING_DATA_FILES','A');

COMMIT;

SELECT * FROM MAILING_GROUP;

SELECT * FROM MAILING_DETAILS;

SELECT * FROM MAILING_FILE_DETAILS;