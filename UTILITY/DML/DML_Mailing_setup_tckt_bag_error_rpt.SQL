/***************************************************************************** 
Below script is created to store mailing groups email id for 
Ticket & Bag Error report

created : 12/20/2016 gxg192 CCN Project....
changed : 12/21/2016 gxg192 Added CCN Oracle team's email id and Message
        : 12/21/2016 gxg192 Changed mail_id field
*****************************************************************************/

SET DEFINE OFF;

INSERT INTO MAILING_GROUP (GROUP_ID, MAIL_ID)
   VALUES ('48', 'ccnoracle.team@sherwin.com; smis@sherwin.com');
   
INSERT INTO MAILING_GROUP (GROUP_ID, MAIL_ID)
   VALUES ('49', 'ccnoracle.team@sherwin.com; smis@sherwin.com');

/***************************************************************************** 
Below script is created to store mailing details for Ticket & Bag Error report
*****************************************************************************/
   
INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
    VALUES ('DEP_BAGORD_ERROR_RPT',
            '48','Deposit Bags Error Report',
            'ccnoracle.team@sherwin.com',
            'Attached are the Deposit Bag orders that erred from today''s batch.',
            'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
    VALUES ('DEP_TICKORD_ERROR_RPT',
            '49','Deposit Tickets Error Report',
            'ccnoracle.team@sherwin.com',
            'Attached are the Deposit Ticket orders that erred from today''s batch.',
            'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');