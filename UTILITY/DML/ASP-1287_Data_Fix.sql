/*******************************************************************************
Script to insert the missing job_title in the JOB_TITLE_GROUP table for Canada 
Sales.Sales Rep.Can..PC Multi-Segment New Store
Created : 07/11/2019 axm868 ASP-1287
*******************************************************************************/
SELECT * FROM JOB_TITLE_GROUP WHERE JOB_TITLE = 'Sales.Sales Rep.Can..PC Multi-Segment New Store';
INSERT INTO JOB_TITLE_GROUP (JOB_TITLE,JOB_GROUP,NONMGR_IND,JOB_GRP_EXCLD)
VALUES('Sales.Sales Rep.Can..PC Multi-Segment New Store','Sales Rep','N','Y');
COMMIT;
SELECT * FROM JOB_TITLE_GROUP WHERE JOB_TITLE = 'Sales.Sales Rep.Can..PC Multi-Segment New Store';