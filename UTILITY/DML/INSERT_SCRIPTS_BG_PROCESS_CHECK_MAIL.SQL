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
VALUES('SRA1100_BP_ERROR'
,43
,'SRA1100_bp.sh Background process not running.'
,'ccnoracle.team@sherwin.com'
,'SRA1100_bp.sh Background process not running. Please check the log file.'
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
VALUES('DEPOSITS_ORDER_BP_ERROR'
,44
,'deposits_order_bp.sh Background process not running.'
,'ccnoracle.team@sherwin.com'
,'deposits_order_bp.sh Background process not running. Please check the log file.'
,'Thanks'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'
);

INSERT INTO MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES(45,'ccnoracle.team@sherwin.com');

INSERT INTO MAILING_DETAILS
(MAIL_CATEGORY
,GROUP_ID
,SUBJECT
,FROM_P
,MESSAGE,SIGNATURE
)
VALUES('HOST_HIEARARCHY_BP_ERROR'
,45
,'host_hierarchy.sh Background process not running.'
,'ccnoracle.team@sherwin.com'
,'host_hierarchy.sh Background process not running. Please check the log file.'
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
VALUES('AUDIT_FILES_CHECK_BP_ERROR'
,46
,'audit_files_check.sh Background process not running.'
,'ccnoracle.team@sherwin.com'
,'audit_files_check.sh Background process not running. Please check the log file.'
,'Thanks'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'
);


INSERT INTO MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES(47,'ccnoracle.team@sherwin.com');

INSERT INTO MAILING_DETAILS
(MAIL_CATEGORY
,GROUP_ID
,SUBJECT
,FROM_P
,MESSAGE,SIGNATURE
)
VALUES('HOST_UNIX_COMMAND_BP_ERROR' 
,47
,'host_unix_command.sh Background process not running.'
,'ccnoracle.team@sherwin.com'
,'host_unix_command.sh Background process not running. Please check the log file.'
,'Thanks'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'
);

INSERT INTO MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES(48,'ccnoracle.team@sherwin.com');

INSERT INTO MAILING_DETAILS
(MAIL_CATEGORY
,GROUP_ID
,SUBJECT
,FROM_P
,MESSAGE,SIGNATURE
)
VALUES('ALL_BG_PROCESSES_EXECUTING'
,48
,'All background processes are executing fine.'
,'ccnoracle.team@sherwin.com'
,'All background processes are executing fine in the server.'
,'Thanks'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'
);

COMMIT;