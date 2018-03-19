CREATE OR REPLACE PACKAGE CCN_BATCH_PROCESS AS
/*********************************************************** 
This package spec will have procedures and functions related 
to the batch process

Created  : 04/04/2016 nxk927 CCN project
Modified : 06/02/2017 sxp130 ASP-795 CCN project
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

PROCEDURE GENERATE_HRCHY_MISMATCH_FILE
/**********************************************************
This process takes care of generating HIER_TRNSFR_TERRITORY file

Created : 04/13/2017 pxb712 CCN project Team....
**********************************************************/
;

PROCEDURE GENERATE_STORE_PD_HRCHY_FILE
/**********************************************************
This procedure is intended to generate Price District Hierarchy reporting for stores pricing group
STORE_PDH_HRCHY.CSV
The Report is scheduled to run everyday 8am
Filters:
consider only Category = 'S' and stores attached to Price district Hierarchy

Created : 05/25/2017 rxa457 ASP-772 CCN project Team....
**********************************************************/
;

PROCEDURE GENERATE_STORE_BANK_CARD_FILE(
/**********************************************************
This procedure is intended to generate below files which describes store and merchant details
1. STORE_BANK_CARD_MERCHANT.CSV
2. STORE_BANK_CARD_SERIAL.DAT
Filters:
1 - consider only POLLING_STATUS_CODE = 'P' and CATEGORY IN ( 'S', 'O' )

Created : 05/25/2017 sxp130 CCN project Team.... - ASP-795
Changed : 03/15/2018 rxv940 CCN project Team....
          Created an input variable that gets appended to file name
**********************************************************/
IN_TMSTMP   IN VARCHAR2)
;
PROCEDURE  GENERATE_VALUE_LINK_PROCESS 
/**********************************************************
The procedure is intended to generate below files which  describes the merchant details.
1.SRA31000.TXT. 
Filters:
1 - consider only POLLING_STATUS_CODE = 'P' and CATEGORY IN ( 'P', 'Q' )
Created : 11/03/2017 BXA919 CCN project Team.... - ASP-800
Changed :
**********************************************************/
 ;

END CCN_BATCH_PROCESS;