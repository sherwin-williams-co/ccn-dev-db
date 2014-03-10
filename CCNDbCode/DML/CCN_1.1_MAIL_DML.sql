  --insert into MAILING_GROUP table
  Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('1','Nirajan.Karki@sherwin.com;Shahla.Husain@sherwin.com;Jaydeep.Cheruku@sherwin.com;Keith.D.Parker@sherwin.com');
  Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('2','Nirajan.Karki@sherwin.com;Shahla.Husain@sherwin.com;Jaydeep.Cheruku@sherwin.com;Keith.D.Parker@sherwin.com');
  Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('3','Nirajan.Karki@sherwin.com;Shahla.Husain@sherwin.com;Jaydeep.Cheruku@sherwin.com;Keith.D.Parker@sherwin.com');
  Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('4','Nirajan.Karki@sherwin.com;Shahla.Husain@sherwin.com;Jaydeep.Cheruku@sherwin.com;Keith.D.Parker@sherwin.com');
  Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('5','Nirajan.Karki@sherwin.com;Shahla.Husain@sherwin.com;Jaydeep.Cheruku@sherwin.com;Keith.D.Parker@sherwin.com');


  --insert into MAILING_DETAILS table
  INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) VALUES ('ADD_TERMINAL','1','Adding Terminal','Keith.D.Parker@sherwin.com','Terminal XXXXX has been Added Successfully','Thanks,  
Keith D. Parker 
Senior Developer 
Sherwin Williams - Stores IT');
  Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('INIT_LOAD_START','2','InitLoad Status Updates','Keith.D.Parker@sherwin.com','Init Load Process has been Started.','Thanks,  
Keith D. Parker 
Senior Developer 
Sherwin Williams - Stores IT');
  INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) VALUES ('INIT_LOAD_END','2','InitLoad Status Updates','Keith.D.Parker@sherwin.com','Init Load Process Completed Successfully.','Thanks,  
Keith D. Parker 
Senior Developer 
Sherwin Williams - Stores IT');
  Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('HIER_LOAD_START','3','Hierarchy Loading Status Updates','Keith.D.Parker@sherwin.com','Hierarchy Loading Process has been Started.','Thanks,  
Keith D. Parker 
Senior Developer 
Sherwin Williams - Stores IT');
  INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) VALUES ('HIER_LOAD_END','3','Hierarchy Loading Status Updates','Keith.D.Parker@sherwin.com','Hierarchy Loading Process Completed Successfully.','Thanks,  
Keith D. Parker 
Senior Developer 
Sherwin Williams - Stores IT');
  INSERT INTO MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) VALUES ('START_JBOSS','4','JBoss Status Updates','Keith.D.Parker@sherwin.com','Data loading completed successfully and JBoss Started Again.','Thanks,  
Keith D. Parker 
Senior Developer 
Sherwin Williams - Stores IT');
  Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('STOP_JBOSS','4','JBoss Status Updates','Keith.D.Parker@sherwin.com','JBoss Shutdown Successfully to speed up the database loading process.','Thanks,  
Keith D. Parker 
Senior Developer 
Sherwin Williams - Stores IT');
  Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('INCOMPLETE_CC','5','Incomplete Cost Centers List','Keith.D.Parker@sherwin.com','Please find attached the list of incomplete cost centers.','Thanks,  
Keith D. Parker 
Senior Developer 
Sherwin Williams - Stores IT');