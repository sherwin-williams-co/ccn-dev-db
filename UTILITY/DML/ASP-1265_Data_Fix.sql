/*******************************************************************************
Script to insert the missing job_title in the JOB_TITLE_GROUP table for Canada 
Sales.Sales Rep.Can.N.PC Res Repaint New Store
Created : 01/10/2019 sxc403
*******************************************************************************/
SELECT * FROM JOB_TITLE_GROUP WHERE JOB_TITLE = 'Sales.Sales Rep.Can.N.PC Res Repaint New Store';

INSERT INTO JOB_TITLE_GROUP (JOB_TITLE,JOB_GROUP,NONMGR_IND,JOB_GRP_EXCLD)
VALUES('Sales.Sales Rep.Can.N.PC Res Repaint New Store','Sales Rep','N','Y');

commit;

SELECT * FROM JOB_TITLE_GROUP WHERE JOB_TITLE = 'Sales.Sales Rep.Can.N.PC Res Repaint New Store';


