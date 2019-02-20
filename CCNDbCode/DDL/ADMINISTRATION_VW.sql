CREATE OR REPLACE VIEW ADMINISTRATION_VW AS
  SELECT
/*******************************************************************************
This View holds all the details of administration details of a cost center

Created  : 02/20/2019 pxa852 CCN Project Team....
Modified :
*******************************************************************************/
       COST_CENTER_CODE,
       CATEGORY,
       INTERNAL_MAIL_NUMBER,
       ADMIN_COST_CNTR_TYPE,
       ALLOCATION_CC,
       DIVISION_OFFSET
  FROM ADMINISTRATION_MONTHLY_SNAPSHOT_TBL
 WHERE LOAD_DATE = (SELECT MAX(LOAD_DATE)
                      FROM ADMINISTRATION_MONTHLY_SNAPSHOT_TBL);