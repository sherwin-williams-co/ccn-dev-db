/*******************************************************************************
Script to insert the missing job_title in the JOB_TITLE_GROUP table for Canada 
Created : 01/18/2018 sxh487
 
*******************************************************************************/
Insert into JOB_TITLE_GROUP (JOB_TITLE, JOB_GROUP, NONMGR_IND, JOB_GRP_EXCLD) values ('Fin.Processor.Dist..Credit','Non-Management Full-time','N', 'Y');
Insert into JOB_TITLE_GROUP (JOB_TITLE, JOB_GROUP, NONMGR_IND, JOB_GRP_EXCLD) values ('Services.Coord.Div..Real Estate','Non-Management Full-time','N', 'Y');

COMMIT;