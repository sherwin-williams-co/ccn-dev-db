-- Below code is for mailing details associated with Polling 
-- craeted by rxv940 on 07/28/2017

INSERT INTO MAILING_GROUP (GROUP_ID, MAIL_ID)
SELECT MAX(TO_NUMBER(GROUP_ID))+1, 'ccnoracle.team@sherwin.com' FROM MAILING_GROUP;
COMMIT;

INSERT INTO MAILING_DETAILS
(
MAIL_CATEGORY, GROUP_ID, SUBJECT, FROM_P, MESSAGE, SIGNATURE
)
SELECT 'RequestidFailure', MAX(TO_NUMBER(GROUP_ID)), 'Polling - Requestid retrieval Failure', 'ccnoracle.team@sherwin.com', 'Error while calling Java function to get the RequestID. Please check the log file.', '"Thanks
Keith D. Parker
IT Manager
Sherwin Williams - Stores IT"' FROM MAILING_GROUP;
COMMIT;

INSERT INTO MAILING_GROUP (GROUP_ID, MAIL_ID)
SELECT MAX(TO_NUMBER(GROUP_ID))+1, 'ccnoracle.team@sherwin.com' FROM MAILING_GROUP;
COMMIT;

INSERT INTO MAILING_DETAILS
(
MAIL_CATEGORY, GROUP_ID, SUBJECT, FROM_P, MESSAGE, SIGNATURE
)
SELECT 'ARCHIVINGPROCESSFAILURE', MAX(TO_NUMBER(GROUP_ID)), 'Polling Failure', 'ccnoracle.team@sherwin.com', 'Error while archiving. Please check the log file.', '"Thanks
Keith D. Parker
IT Manager
Sherwin Williams - Stores IT"' FROM MAILING_GROUP;
COMMIT;