INSERT INTO MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES(35,'ccnoracle.team@sherwin.com');
INSERT INTO MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES(33,'ccnoracle.team@sherwin.com');
INSERT INTO MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES(34,'ccnoracle.team@sherwin.com');
INSERT INTO MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES(36,'ccnoracle.team@sherwin.com');
INSERT INTO MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES(37,'ccnoracle.team@sherwin.com');
INSERT INTO MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES(38,'ccnoracle.team@sherwin.com');

INSERT INTO MAILING_DETAILS(MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)VALUES('TICKETORDER_PROCESS_COMPLETE',34,'TICKETORDER TRACKING NUMBER PROCESS DONE.','ccnoracle.team@sherwin.com','Ticket order tracking number processing completed successfully.','Thanks,'||CHR(10)||'Sherwin Williams - Stores IT'||CHR(10)||'Primary Contact : Keith D Parker (216-566-3935)' ); 
INSERT INTO MAILING_DETAILS(MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)VALUES('TICKETORDERTRACKING_ERROR',33,'TICKETORDER TRACKING NUMBER ERROR.','ccnoracle.team@sherwin.com','Ticket order tracking number processing failed. Please check the log file.','Thanks,'||CHR(10)||'Sherwin Williams - Stores IT'||CHR(10)||'Primary Contact : Keith D Parker (216-566-3935)' ); 
INSERT INTO MAILING_DETAILS(MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)VALUES('BAGORDERTRACKING_ERROR',35,'BAGORDER TRACKING NUMBER ERROR.','ccnoracle.team@sherwin.com','Bag order tracking number processing failed. Please check the log file.','Thanks,'||CHR(10)||'Sherwin Williams - Stores IT'||CHR(10)||'Primary Contact : Keith D Parker (216-566-3935)' ); 
INSERT INTO MAILING_DETAILS(MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)VALUES('BAGORDER_PROCESS_COMPLETE',36,'BAGORDER TRACKING NUMBER PROCESSING DONE.','ccnoracle.team@sherwin.com','Bag order tracking number processing successfully completed.','Thanks,'||CHR(10)||'Sherwin Williams - Stores IT'||CHR(10)||'Primary Contact : Keith D Parker (216-566-3935)' ); 
INSERT INTO MAILING_DETAILS(MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)VALUES('BANKING_BATCH_PROCESSING_ERROR',37,'BANKING BATCH ORDER PRODESSING ERROR.','ccnoracle.team@sherwin.com','Banking batch order processing failed. Please check the log files.','Thanks,'||CHR(10)||'Sherwin Williams - Stores IT'||CHR(10)||'Primary Contact : Keith D Parker (216-566-3935)' ); 
INSERT INTO MAILING_DETAILS(MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE)VALUES('UPD_BANKING_PARAM_ERROR',38,'BANKING UPDATE BATCH ORDER ERROR.','ccnoracle.team@sherwin.com','Update of batch order failed. Please check the log files.','Thanks,'||CHR(10)||'Sherwin Williams - Stores IT'||CHR(10)||'Primary Contact : Keith D Parker (216-566-3935)' ); 

COMMIT;