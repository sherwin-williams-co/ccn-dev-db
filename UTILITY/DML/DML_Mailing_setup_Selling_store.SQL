/*****************************************************************************
Below script is created to store mailing groups email id for
email for Selling Stores details

Created : 03/30/2017 gxg192 CCN Project....
Changed : 04/04/2017 gxg192 Changed mail_id
*****************************************************************************/

SET DEFINE OFF;

INSERT INTO MAILING_GROUP (GROUP_ID, MAIL_ID)
   VALUES ('51', 'croperations@sherwin.com');

/*****************************************************************************
Below script is created to store mailing details for Selling store email
*****************************************************************************/

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
    VALUES ('SELLING_STORES_MAIL_CAN',
            '51','Selling Stores Details for Canada',
            'ccnoracle.team@sherwin.com',
            'Please see the attached files for details about the cost centers that are marked as selling stores in Canada.'
            ||CHR(10)||'NOTE: If atachments are blank, there are no cost centers marked as selling stores today',
            'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
    VALUES ('SELLING_STORES_MAIL_USA',
            '51','Selling Stores Details for USA',
            'ccnoracle.team@sherwin.com',
            'Please see the attached files for details about the cost centers that are marked as selling stores in USA.'
            ||CHR(10)||'NOTE: If atachments are blank, there are no cost centers marked as selling stores today',
            'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');