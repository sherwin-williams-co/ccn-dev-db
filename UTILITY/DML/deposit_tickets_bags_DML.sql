/*******************************************************************************
  Insert scripts for Mailing group and mailing details for the Deposit Tickets/Bags 
  ordered
  CREATED : 11/21/2016 SXH487 CCN PROJECT....
  CHANGED :
*******************************************************************************/
INSERT INTO MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES(55,'ccnoracle.team@sherwin.com;smis@sherwin.com');
INSERT INTO MAILING_DETAILS
(MAIL_CATEGORY
,GROUP_ID
,SUBJECT
,FROM_P
,MESSAGE
,SIGNATURE
)
VALUES('DEP_TICKORD_EXC_RPT'
,55
,'Deposit Tickets Ordered Report'
,'ccnoracle.team@sherwin.com'
,'Please find attached the Deposit Tickets Ordered Report'
,'Thanks'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'
);

INSERT INTO MAILING_DETAILS
(MAIL_CATEGORY
,GROUP_ID
,SUBJECT
,FROM_P
,MESSAGE
,SIGNATURE
)
VALUES('DEP_BAG_TICKORD_EXC_RPT'
,55
,'Deposit Bags Ordered Report'
,'ccnoracle.team@sherwin.com'
,'Please find attached the Deposit Bags Ordered Report'
,'Thanks'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT'
);
COMMIT;