/********************************************************************************************************************************************
Inserting new mailing group ID for 'VALUELINK_FILE_FAILURE' email ID's. This mailing group will be used to send failure emails while generating value link file.
Inserts into MAILING_DEAILS for 'VALUELINK FILE FAILURE'

Created : 11/06/2017 bxa919 CCN Project Team....

********************************************************************************************************************************************/

REM INSERTING into MAILING_GROUP
SET DEFINE OFF;

Insert into 	mailing_details (MAIL_CATEGORY,
				GROUP_ID,
				SUBJECT,
				FROM_P,
				MESSAGE,
				SIGNATURE) 
values 			('VALUELINK FILE FAILURE',
				'97',
				'VALUE_LINK FILE GENERATION FAILURE',
				'ccnoracle.team@sherwin.com',
				'Error while generating value link file',
				'Thanks
				 Keith D. Parker IT Manager 
				 Sherwin Williams - Stores IT');

REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
Insert into 	mailing_group (GROUP_ID,MAIL_ID) 
values 			('97','ccnoracle.team@sherwin.com')

COMMIT;