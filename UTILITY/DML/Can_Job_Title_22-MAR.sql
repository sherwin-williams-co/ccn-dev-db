/*******************************************************************************
Script to insert the missing job_title in the JOB_TITLE_GROUP table for Canada 
(Sales.Driver.SWDS Can.I.)
Created : 03/22/2018 sxh487
 
*******************************************************************************/
select * from job_title_group where JOB_TITLE ='Sales.Driver.SWDS Can.I.';
--no rows selected

Insert into JOB_TITLE_GROUP (JOB_TITLE, JOB_GROUP, NONMGR_IND, JOB_GRP_EXCLD) values ('Sales.Driver.SWDS Can.I.','Non-Management Full-time','N', 'Y');

COMMIT;