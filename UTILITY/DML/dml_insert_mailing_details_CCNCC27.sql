/********************************************************************************** 
This script is created to insert data into MAILING_GROUP, MAILING_DETAILS
and MAILING_FILE_DETAILS tables.

Created : 07/12/2019 axm868 CCN Project CCNCC-27....
          Run these scripts in CCN_UTILITY
Modified: 
**********************************************************************************/
SET DEFINE OFF;

SELECT * FROM MAILING_GROUP;

SELECT * FROM MAILING_DETAILS;

SELECT * FROM MAILING_FILE_DETAILS;

--Development/Test/QA
INSERT INTO MAILING_GROUP (GROUP_ID,MAIL_ID) VALUES (138,'ccnoracle.team@sherwin.com');

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
VALUES ('CCN_CLOSE_CC_ISSUE_DTLS_FILE_MAIL',
        138,
        'Report for reasons for failure of closing Cost Center CCCCCC',
        'ccnoracle.team@sherwin.com',
        'Please find the attached the report with reasons for failure of closing the store',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'); 

--Production
INSERT INTO MAILING_GROUP (GROUP_ID,MAIL_ID) VALUES (138,'ccnsupport.team@sherwin.com;smis@sherwin.com');

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
VALUES ('CCN_CLOSE_CC_ISSUE_DTLS_FILE_MAIL',
        138,
        'Report for reasons for failure of closing Cost Center CCCCCC',
        'ccnsupport.team@sherwin.com',
        'Please find the attached the report with reasons for failure of closing the store',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
		
INSERT INTO MAILING_FILE_DETAILS VALUES (1,138,'CCN_CLOSE_CC_ISSUE_DTLS_FILE_MAIL','CCN_DATAFILES','A');

COMMIT;

SELECT * FROM MAILING_GROUP;

SELECT * FROM MAILING_DETAILS;

SELECT * FROM MAILING_FILE_DETAILS;