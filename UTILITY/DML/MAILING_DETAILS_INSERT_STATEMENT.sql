Insert into 	mailing_details (MAIL_CATEGORY,
				GROUP_ID,
				SUBJECT,
				FROM_P,
				MESSAGE,
				SIGNATURE) 
values 			('VALUELINK_FILE_FAILURE',
				'97',
				'VALUE_LINK_FILE_GENERATION_FAILURE',
				'ccnoracle.team@sherwin.com',
				'Error while executing generate_value_link procedure',
				'Thanks
				 Keith D. Parker IT Manager 
				 Sherwin Williams - Stores IT');

Insert into 	mailing_group (GROUP_ID,MAIL_ID) 
values 			('97','ccnoracle.team@sherwin.com')