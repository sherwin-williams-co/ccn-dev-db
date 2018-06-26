/*******************************************************************************
This script update the mailing category details in MAILING_DETAILS table
for the group id "86" to send the both (CCN_ACCNT_REPORT/ADMIN_HRCHY_FORMAT files 

CREATED : 06/26/2018 sxg151 CCN PROJECT....ASP-1075
*******************************************************************************/

--Update MAILING_DETAILS

UPDATE MAILING_DETAILS
   SET  MAIL_CATEGORY = 'CCN_ACCNT_EPM_REPORT'
       ,SUBJECT       =  'CCN Accounting/EPM Reports'
       ,MESSAGE       = 'Please find attached the CCN Accounting/EPM Reports'
 WHERE GROUP_ID = '86';

-- This script inserts the file details in MAILING_FILE_DETAILS table to attached the two files in an email.

INSERT INTO MAILING_FILE_DETAILS (FILE_ID,GROUP_ID,FILE_NAME,DIRECTORY_NAME,IS_ACTIVE) 
values (1,'86','CCN_ACCNT_REPORT','CCN_DATAFILES','A');
INSERT INTO MAILING_FILE_DETAILS (FILE_ID,GROUP_ID,FILE_NAME,DIRECTORY_NAME,IS_ACTIVE) 
values (2,'86','ADMIN_HRCHY_FORMAT','CCN_DATAFILES','A');

COMMIT;

SELECT * FROM MAILING_DETAILS  WHERE GROUP_ID = '86';
SELECT * FROM MAILING_FILE_DETAILS WHERE GROUP_ID = '86';


/********************************************************************
06/26/2018. Adding .Fabio.DiSanza@sherwin.com
*********************************************************************/
--Execute only in PROD


update mailing_group 
set mail_id = 'ccnoracle.team@sherwin.com;psg.finplan@sherwin.com;fabio.disanza@sherwin.com;'
where group_id = '86';

commit;

select * from mailing_group where group_id = '86';