CREATE OR REPLACE PACKAGE CCN_BATCH_PROCESS AS
/*********************************************************** 
This package spec will have procedures and functions related 
to the batch process

Created  : 04/04/2016 nxk927 CCN project
Modified : 
************************************************************/
  
PROCEDURE NEWLY_CRTD_COST_CENTER
/**********************************************************
	This procedure is intended to generate a file with the list of new cost centers
  created on previous day

Created : 04/04/2016 nxk927 CCN project
**********************************************************/
;

PROCEDURE GENERATE_SELLING_STORE_FILE(
/**********************************************************
	This procedure is intended to generate a file with the list of new selling stores
  created on the date passed

1 - consider only open/valid store cost centers under USA/CAN/PRI countries
2 - cost center should be a complete cost center => should be part of global, facts and legacy hierarchies
3 - selling store flag should have been set to "Y" on that day
4 - consider only mailling address for any country code

Created : 09/27/2016 jxc517 CCN project Team....
Changed :
**********************************************************/
IN_DATE       IN     DATE);

END CCN_BATCH_PROCESS;