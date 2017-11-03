/*
This script inserts the data to send email for Descartes address feed failure

Created : 10/28/2017 jxc517 CCN Project Team....
Changed :
*/
SET DEFINE OFF;
INSERT INTO MAILING_DETAILS
       (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
VALUES ('DESCARTES_ADDR_FEED_FAIL',
        '45',
        'Descartes Address feed failure',
        'ccnoracle.team@sherwin.com',
        'Descartes Address feed failed. Please check "DESCARTES_ADRS_FEED_CC" table for failure status',
        'Thanks' || CHR(10) || 'Keith D. Parker' || CHR(10) || 'IT Manager' ||CHR(10) || 'Sherwin Williams - Stores IT');

COMMIT;
