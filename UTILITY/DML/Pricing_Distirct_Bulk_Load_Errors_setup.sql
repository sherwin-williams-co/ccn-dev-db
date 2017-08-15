/*****************************************************************************
Below script is used to set up mailing process for Pricing District Bulk Load process

Created : 08/15/2017 jxc517 CCN Project Team....
Changed : 
*****************************************************************************/
SELECT * FROM MAILING_GROUP WHERE GROUP_ID = 71;
INSERT INTO MAILING_GROUP (GROUP_ID, MAIL_ID) VALUES ('71', 'ccnoracle.team@sherwin.com');
SELECT * FROM MAILING_GROUP WHERE GROUP_ID = 71;

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
    VALUES ('PD_HRCHY_BULK_INSERT_FAIL',
            '71',
            'Pricing District Hierarchy Bulk Insert Failures',
            'ccnoracle.team@sherwin.com;jmkeating@sherwin.com;baeverden@sherwin.com',
            'Please see the attached files for details about the cost centers that failed during Pricing District Bulk Load Process.',
            'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
    VALUES ('PD_HRCHY_BULK_TRANSFER_FAIL',
            '71',
            'Pricing District Hierarchy Bulk Transfer Failures',
            'ccnoracle.team@sherwin.com;jmkeating@sherwin.com;baeverden@sherwin.com',
            'Please see the attached files for details about the cost centers that failed during Pricing District Bulk Transfer Process.',
            'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

SELECT * FROM MAILING_DETAILS WHERE MAIL_CATEGORY IN ('PD_HRCHY_BULK_INSERT_FAIL', 'PD_HRCHY_BULK_TRANSFER_FAIL');

COMMIT;
