/*******************************************************************************
Script to insert the missing job_title in the JOB_TITLE_GROUP table for Canada 
(Services.Coord...Store Recruitment) and updating Sales.Intern.Can.. 
Created : 12/01/2017 sxh487
 
*******************************************************************************/
Insert into JOB_TITLE_GROUP (JOB_TITLE, JOB_GROUP, NONMGR_IND, JOB_GRP_EXCLD) values ('Services.Coord...Store Recruitment','Non-Management Full-time','N', 'Y');

UPDATE JOB_TITLE_GROUP
   SET NONMGR_IND ='N',
       JOB_GRP_EXCLD ='Y'
 WHERE JOB_TITLE ='Sales.Intern.Can..';

COMMIT;