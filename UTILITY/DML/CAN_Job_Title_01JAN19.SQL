/*******************************************************************************
Script to insert the missing job_title in the JOB_TITLE_GROUP table for Canada 
HR.Spec.Div..Recruitment
Created : 01/10/2019 mxs216
*******************************************************************************/

SELECT * FROM JOB_TITLE_GROUP WHERE JOB_TITLE = 'HR.Spec.Div..Recruitment';
--no rows selected

INSERT INTO job_title_group (job_title, job_group, nonmgr_ind, job_grp_excld) VALUES ('HR.Spec.Div..Recruitment', 'Non-Management Full-time', 'N', 'Y');
COMMIT;