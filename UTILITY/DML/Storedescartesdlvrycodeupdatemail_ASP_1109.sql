

  ********************************************************************************** 
This script is created to insert records into MAILING_GROUP and MAILING_DETAILS tables for generating store descartes delivery code update failure report.

Created : 08/09/2018 pxa852 CCN Project ASP-1109....
Modified: 
**********************************************************************************/

SET DEFINE OFF;

Insert into MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES('121','ccnoracle.team@sherwin.com');

-- INSERTING into MAILING_DETAILS

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('STORE_DSCRTS_UI_BULK_LD_UPD_PROC_FAIL',
        '121',
        'CCN Store descartes delivery code update failure records',
        'ccnoracle.team@sherwin.com',
        'Attached the list of stores for which the descartes delivery code is not updated.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');


commit;
