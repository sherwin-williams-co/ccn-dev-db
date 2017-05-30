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

PROCEDURE GENERATE_PCI_MISMATCH_FILE
/**********************************************************
This process takes care of generating PCI_TERMINAL_MISMATCH file

Created : 04/11/2017 pxb712 CCN project Team....
**********************************************************/
;

PROCEDURE GENERATE_HRCHY_MISMATCH_FILE
/**********************************************************
This process takes care of generating HIER_TRNSFR_TERRITORY file

Created : 04/13/2017 pxb712 CCN project Team....
**********************************************************/
;

PROCEDURE GENERATE_STORE_DATA_FILE
/**********************************************************
This procedure is intended to generate below files which describes store and merchant details
1. MID_BC.CSV
2. SERIAL_BC.CSV
Filters:
1 - consider only POLLING_STATUS_CODE = 'P' and CATEGORY IN ( 'S', 'O' )

Created : 05/25/2017 sxp130 CCN project Team.... - ASP-795
Changed :
**********************************************************/
;

END CCN_BATCH_PROCESS;