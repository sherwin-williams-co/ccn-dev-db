/********************************************************************************** 
Below script is created to insert data into MAILING_GROUP and MAILING_DETAILS table.

Created : 06/13/2017 sxp130 CCN Project ASP-802....
Modified: 
**********************************************************************************/
REM INSERTING into MAILING_GROUP
SET DEFINE OFF;
Insert into MAILING_GROUP (GROUP_ID,MAIL_ID) values ('67','Pricing.StoresGroup@sherwin.com;ccnoracle.team@sherwin.com');


REM INSERTING into MAILING_DETAILS
SET DEFINE OFF;
Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('PRICE_DIST_FUTURE_HIER',
        '67',
        'Price District Future Hierarchy File generation',
        'ccnoracle.team@sherwin.com',
        'Please find the Price District Future Hierarchy File details attached.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');
		
commit;
