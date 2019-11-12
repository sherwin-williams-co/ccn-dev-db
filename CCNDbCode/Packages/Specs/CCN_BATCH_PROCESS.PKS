create or replace PACKAGE CCN_BATCH_PROCESS AS
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

PROCEDURE POS_TERM_TRAN_UPDATE
/**********************************************************
	This procedure is intended to UPDATE POS_LAST_TRAN_DATE and POS_LAST_TRAN_NUMBER
  in termianl table

Created : 12/01/2017 nxk927 CCN project
**********************************************************/
;

FUNCTION GET_LOAD_RUNCYCLE
/******************************************************************************
  This function will get the runcycle for the days load

Created : 09/28/2017 nxk927 CCN Project....
Changed : 11/15/2018 pxa852 CCN Project...
          Changed the datatype to number as run cycle id is a number in PNP_CCN_HEADER
*******************************************************************************/
RETURN NUMBER;

PROCEDURE LOAD_ADDRESS_GEO_DETAILS
/******************************************************************************
  This Procedure Will load the data from ADDRESS_GEO_V

Created : 03/12/2018 sxg151 CCN Project....
Changed :
*******************************************************************************/
;

PROCEDURE LOAD_DSC_CODE_DESC_DETAILS
/******************************************************************************
  This Procedure Will load the data into CCN_DSC_CODE_DESC table from EHDA.V_AXESP0549@AOM_QA.WORLD

Created : 04/24/2018 sxg151 CCN Project....
Changed :
*******************************************************************************/
;

PROCEDURE GEN_ADMINORG_HRCHY_ATTR_FILE
/******************************************************************************
  This Procedure Will generate xlsx  report from ADMINORG_HIERARCHY_ATTRBT_VW

Created : 07/17/2018 kxm302 CCN Project....
Changed :
*******************************************************************************/
;

PROCEDURE CC_NUMERIC_SEQ_ROSTER_RPT
/******************************************************************************
  This Procedure takes care of generating CCN05000 REPORT 43

Created : 08/09/2018 kxm302 CCN Project....
Changed :
*******************************************************************************/
;

PROCEDURE GENERATE_CCN_PHONE_INFO_RPT;
/******************************************************************************
This procedure is intended to generate an CCN Phone details xlsx  report from CCN_PHONE_INFO_VW.

Filters:
Created : 08/23/2018 kxm302 CCN project Team....
*******************************************************************************/

PROCEDURE CCN_MONTHLY_SNAPSHOT_SP
/**********************************************************
This process will invoke to load data into tables from the Views

Created : 01/25/2019 sxg151 CCN project Team....
        : ASP-1205 : Monthly (2nd to last business day) views for hierarchy attribute and cost center
**********************************************************/
;

PROCEDURE ADMINISTRATION_MONTHLY_SNAPSHOT_SP
/**********************************************************
This process will invoke to load data into administration monthly sanpshot table

Created : 02/20/2019 pxa852 CCN project Team....
Modified:
**********************************************************/
;

PROCEDURE STORE_DISPATCH_SERVICES_UPD
/******************************************************************************
  This Procedure Will update the store dispatch service field values.

Created : 10/08/2019 akj899 CCNA2-55 Project Changes
Changed :
*******************************************************************************/
;

PROCEDURE GNRT_STORE_BANK_CARD_MRCHNT_FL(
/******************************************************************************************
This Procedure create file STORE_BANK_CARD_MERCHANT_FL.CSV on the server
File structure:
MERCHANT_ID,SUBSTR(MERCHANT_ID, 7, 4),PCI_MERCHANT_ID,DISCOVER_ID,PCI_DISCOVER_ID,AMEX_SE_ID
Filters:
POLLING_STATUS_CODE = 'P'
CATEGORY IN ('S','O')
created : 05/25/2017 sxp130 ASP-795
modified: 09/06/2017 sxp130 ASP-795 - Incorporated code changes for PAT E-Mail on
        : Tuesday, September 05, 2017 10:54AM - PAT's E-mail.
        : 10/02/2017 rxa457 CCN Project Team...
          file name changed merchtb.dat
        :01/19/2018 bxa919 CCN Project Team...
         adding new columns MERCH_ID_CAN_MC,PCI_MERCH_ID_CAN_MC from bank_card table 
         to populate in the file..
modified: 03/15/2018 rxv940 CCN Project Team....
          Removing out the email part and logic involved in creating CLOB for email
          - shell script FTP'es
        : 03/16/2018 nxk927
          polling status code Q added in the filter
        : 06/12/2018 nxk927 CCN Project Team....
          EXPIRATION_DATE column name changed to POLL_STATUS_EXP_DT
        : 06/22/2018 sxg151 CCN Project Team...
          Added logic to send an email along with FTP ASP - 1082.
        : 06/19/2018 sxg151 CCN Project Team...
          Removed CHR(13) in APPEND_CLOB  procedure "Text file line breaks wrong, after the file is transferred to UAR(Windows)server".
        : 10/14/2019 jxc517 CCN Project Team....
          Modified the signature to more file creation process from oracle to java side
          Removed code to email using database code
*******************************************************************************************/
    IN_TMSTMP    IN         VARCHAR2,
    OUT_CLOB        OUT     CLOB,
    OUT_FILE_NM     OUT     VARCHAR2);

PROCEDURE GNRT_STORE_BANK_CARD_SERIAL_FL(
/******************************************************************************************
This Procedure create file STORE_BANK_CARD_SERIAL.CSV on the server
Filters:
POLLING_STATUS_CODE = 'P'
CATEGORY IN ('S','O')
created : 05/25/2017 sxp130 ASP-795
modified: 02/23/2018 nxk927
          polling status code Q added in the filter
modified: 03/15/2018 rxv940 CCN Project Team....
          Removing out the email part and logic involved in creating CLOB for email
          - shell script FTP'es
modified: 03/16/2018 nxk927
          Considering all the records without merchant id and using 0's for null merchant id, null discover id and
          null AMEX_SE_ID
        : 06/22/2018 sxg151 CCN Project Team...
          Added logic to send an email along with FTP ASP - 1082
        : 10/14/2019 jxc517 CCN Project Team....
          Modified the signature to more file creation process from oracle to java side
          Removed code to email using database code
*******************************************************************************************/
    IN_TMSTMP    IN         VARCHAR2,
    OUT_CLOB        OUT     CLOB,
    OUT_FILE_NM     OUT     VARCHAR2);

END CCN_BATCH_PROCESS;