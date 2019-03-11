/********************************************************************************** 
This script is created to insert records into MAILING_GROUP and MAILING_DETAILS tables for generating on demand polling download failure report.

Created : 03/08/2019 pxa852 CCN Project Team ASP-1067....
Modified: 
**********************************************************************************/

SET DEFINE OFF;

Insert into MAILING_GROUP(GROUP_ID,MAIL_ID) VALUES('135','ccnoracle.team@sherwin.com');

-- INSERTING into MAILING_DETAILS

Insert into MAILING_DETAILS (MAIL_CATEGORY,GROUP_ID,SUBJECT,FROM_P,MESSAGE,SIGNATURE) 
values ('POLLING_ON_DEMAND_UPLOAD_PROC_FAIL',
        '135',
        'CCN On Demand Polling Download failure records',
        'ccnoracle.team@sherwin.com',
        'Attached the list of costcenters for which the pos download is not triggered.',
        'Thanks,'||CHR(10)||'Keith D. Parker'||CHR(10)||'IT Manager'||CHR(10)||'Sherwin Williams - Stores IT');

commit;