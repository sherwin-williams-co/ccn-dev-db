/*******************************************************************************
  Insert scripts for Mailing group and mailing details for the Store bank deposites
  reconciliation process
  CREATED : 09/13/2016 MXK766 CCN PROJECT....
  CHANGED :
*******************************************************************************/

INSERT INTO MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES(39,'ccnoracle.team@sherwin.com');

INSERT INTO MAILING_DETAILS
(MAIL_CATEGORY
,GROUP_ID
,SUBJECT
,FROM_P
,MESSAGE,SIGNATURE
)
VALUES('STORE_BANK_DPST_RECON_DT_COMPLETE'
,39
,'STORE BANK DEPOSIT RECONCILIATION DATA COMPLETE PROCESS DONE.'
,'ccnoracle.team@sherwin.com'
,'Store bank deposit reconciliation data file generation completed successfully.'
,'Thanks'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'
);

INSERT INTO MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES(40,'ccnoracle.team@sherwin.com');

INSERT INTO MAILING_DETAILS
(MAIL_CATEGORY
,GROUP_ID
,SUBJECT
,FROM_P
,MESSAGE,SIGNATURE
)
VALUES('STORE_BANK_DPST_RECON_DT_ERROR'
,40
,'STORE BANK DEPOSIT RECONCILIATION DATA COMPLETE FAILED.'
,'ccnoracle.team@sherwin.com'
,'Store bank deposit reconciliation data file generation process failed. Please check the log files.'
,'Thanks'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'
);

INSERT INTO MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES(41,'smis1@sherwin.com');

INSERT INTO MAILING_DETAILS
(MAIL_CATEGORY
,GROUP_ID
,SUBJECT
,FROM_P
,MESSAGE,SIGNATURE
)
VALUES('STORE_BANK_DPST_RECON_DT'
,41
,'STORE BANK DEPOSIT RECONCILIATION DATA.'
,'ccnoracle.team@sherwin.com'
,'Please find the attached excel sheet for list of store bank deposit reconciliation data for the last two weeks.'
,'Thanks'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'
);

COMMIT;