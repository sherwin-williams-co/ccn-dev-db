/*******************************************************************************
  Insert scripts for Mailing group and mailing details for the Background process 
		checks.
  reconciliation process
  CREATED : 10/03/2016 MXK766 CCN PROJECT....
  CHANGED :
*******************************************************************************/

INSERT INTO MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES(43,'ccnoracle.team@sherwin.com');

INSERT INTO MAILING_DETAILS
(MAIL_CATEGORY
,GROUP_ID
,SUBJECT
,FROM_P
,MESSAGE,SIGNATURE
)
VALUES('BG_PROCESSES_FAILURE'
,43
,'Background processes are not executing.'
,'ccnoracle.team@sherwin.com'
,'Background processe are not executing. Please check the log file and the email message.'
,'Thanks'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'
);

INSERT INTO MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES(44,'ccnoracle.team@sherwin.com');

INSERT INTO MAILING_DETAILS
(MAIL_CATEGORY
,GROUP_ID
,SUBJECT
,FROM_P
,MESSAGE,SIGNATURE
)
VALUES('ALL_BG_PROCESSES_EXECUTING'
,44
,'Background processes are running.'
,'ccnoracle.team@sherwin.com'
,'All background processes are running fine.'
,'Thanks'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'
);

COMMIT;