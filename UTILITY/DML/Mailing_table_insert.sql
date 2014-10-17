

  --insert into MAILING_GROUP table
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('7','Shahla.Husain@sherwin.com;Jaydeep.Cheruku@sherwin.com;Nirajan.Karki@sherwin.com;Keith.D.Parker@sherwin.com;Abhitej.Kasula@sherwin.com;sinthujan.thamo@sherwin.com');
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('8','Shahla.Husain@sherwin.com;Jaydeep.Cheruku@sherwin.com;Nirajan.Karki@sherwin.com;Keith.D.Parker@sherwin.com;Abhitej.Kasula@sherwin.com;sinthujan.thamo@sherwin.com');


  --insert into MAILING_DETAILS table
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('WRONG_CAT','7','Not a territory cost center','Keith.D.Parker@sherwin.com','Listed cost centers not a territory category','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'Senior Developer'||CHR(10)||'Sherwin Williams - Stores IT');
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('HIER_TRNSFR_TERRITORY','8','Terrirtory Hierarchy Transfer','Keith.D.Parker@sherwin.com','Below excel contains the details about this transfer','Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'Senior Developer'||CHR(10)||'Sherwin Williams - Stores IT');


commit;