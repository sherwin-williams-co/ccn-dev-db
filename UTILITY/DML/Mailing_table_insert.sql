

  --insert into MAILING_DETAILS table
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) values ('WRONG_CAT','7','Not a territory cost center','Keith.D.Parker@sherwin.com','Listed cost centers not a territory category','Thanks,
Keith D. Parker
Senior Developer
Sherwin Williams - Stores IT');


  --insert into MAILING_GROUP table
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('7','Shahla.Husain@sherwin.com;Jaydeep.Cheruku@sherwin.com;Nirajan.Karki@sherwin.com;Keith.D.Parker@sherwin.com;Abhitej.Kasula@sherwin.com;sinthujan.thamo@sherwin.com');

commit;