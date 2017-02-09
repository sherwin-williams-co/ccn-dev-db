/*******************************************************************************
  Insert scripts for Mailing group and mailing details for the Pos file generation 
  CREATED : 10/18/2016 MXK766 CCN PROJECT....
  CHANGED :
*******************************************************************************/

INSERT INTO MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES(45,'ccnoracle.team@sherwin.com');

INSERT INTO MAILING_DETAILS
(MAIL_CATEGORY
,GROUP_ID
,SUBJECT
,FROM_P
,MESSAGE,SIGNATURE
)
VALUES('POLLING_FAILURE_MAIL'
,45
,'Polling process failure'
,'ccnoracle.team@sherwin.com'
,'Polling process failed. Please check for the log files in the email message'
,'Thanks'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'
);

INSERT INTO MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES(46,'ccnoracle.team@sherwin.com');

INSERT INTO MAILING_DETAILS
(MAIL_CATEGORY
,GROUP_ID
,SUBJECT
,FROM_P
,MESSAGE,SIGNATURE
)
VALUES('FTPFAILURE'
,46
,'FTP Failure'
,'ccnoracle.team@sherwin.com'
,'FTP Failed, Please check for the file names in the email message'
,'Thanks'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'
);

COMMIT;