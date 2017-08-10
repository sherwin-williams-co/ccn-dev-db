/*******************************************************************************
Script to insert the missing job_title in the JOB_TITLE_GROUP table for Canada 
(Services.Mgr.Div..Property Maint)
Created : 08/10/2017 sxh487
 
*******************************************************************************/
Insert into JOB_TITLE_GROUP (JOB_TITLE,JOB_GROUP,NONMGR_IND,JOB_GRP_EXCLD) values ('Services.Mgr.Div..Property Maint','Manager','Y','N');
 
COMMIT;