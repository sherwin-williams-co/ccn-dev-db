create or replace PACKAGE          HIERARCHY_BATCH_PKG
AS 
/*******************************************************************************
  This Package is a wrapper for all batch processes of ccn application

Created : 10/02/2015 SX410 CCN Project....
Changed :
**********************************************************/
PROCEDURE HIERARCHY_BATCH_PROCESS
/******************************************************************************
  This procedure is a wrapper to call HIERARCHY_HIST_INSERT to insert history 
  records accordingly Also deletes the expired record

Created : 10/02/2015 SX410 CCN Project....
Changed :
*******************************************************************************/
;
END HIERARCHY_BATCH_PKG;