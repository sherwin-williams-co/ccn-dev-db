/*******************************************************************************
Script to insert the missing job_title in the JOB_TITLE_GROUP table for Canada 
Sales.Sales Rep.Can.N.PC Commercial
Sales.Sales Rep.Can.N.PC Multi-Segment
Sales.Sales Rep.Can.N.PC Resid Repaint
Created : 11/01/2018 pxa852
 
*******************************************************************************/
select * from job_title_group where JOB_TITLE IN ('Sales.Sales Rep.Can.N.PC Commercial','Sales.Sales Rep.Can.N.PC Multi-Segment','Sales.Sales Rep.Can.N.PC Resid Repaint') ;
--no rows selected
Insert into JOB_TITLE_GROUP (JOB_TITLE, JOB_GROUP, NONMGR_IND, JOB_GRP_EXCLD) values ('Sales.Sales Rep.Can.N.PC Commercial','Sales Rep','N', 'Y');
Insert into JOB_TITLE_GROUP (JOB_TITLE, JOB_GROUP, NONMGR_IND, JOB_GRP_EXCLD) values ('Sales.Sales Rep.Can.N.PC Multi-Segment','Sales Rep','N', 'Y');
Insert into JOB_TITLE_GROUP (JOB_TITLE, JOB_GROUP, NONMGR_IND, JOB_GRP_EXCLD) values ('Sales.Sales Rep.Can.N.PC Resid Repaint','Sales Rep','N', 'Y');
COMMIT;