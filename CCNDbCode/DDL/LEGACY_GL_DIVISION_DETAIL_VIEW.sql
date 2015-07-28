  CREATE OR REPLACE FORCE VIEW LEGACY_GL_DIVISION_DETAIL_VIEW AS 
  SELECT *
/*******************************************************************************
This View will give all the details of LEGACY_GL_DIVISION hierarchy linked to the cost center

Created  : 07/28/2015 nxk927 CCN Project....
Modified : 
*******************************************************************************/
    FROM HIERARCHY_DETAIL_VIEW
   WHERE HRCHY_HDR_NAME = 'LEGACY_GL_DIVISION';
/   