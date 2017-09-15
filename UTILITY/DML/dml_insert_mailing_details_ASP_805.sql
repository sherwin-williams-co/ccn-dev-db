/**********************************************************************************
Below script is created to insert data into MAILING_GROUP and MAILING_DETAILS table.
Created : 06/26/2017 sxp130 CCN Project ASP-805....
Modified:
**********************************************************************************/
REM INSERTING into MAILING_GROUP
SET DEFINE OFF;
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('69','smis@sherwin.com;ccnoracle.team@sherwin.com');
REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
values ('DEP_BAG_TICK_ONHAND_QTY_RPT',
        '69',
        'Deposit Bag OnHand Qty File generation',
        'ccnoracle.team@sherwin.com',
        'Please find the Bank Deposit Bag OnHand Qty File details attached.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

COMMIT;

REM INSERTING into MAILING_GROUP
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('70','smis@sherwin.com;ccnoracle.team@sherwin.com');
REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)
values ('DEP_TICK_ONHAND_QTY_RPT',
        '70',
        'Deposit Ticket OnHand Qty File generation',
        'ccnoracle.team@sherwin.com',
        'Please find the Bank Deposit Ticket OnHand Qty File details attached.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

COMMIT;

