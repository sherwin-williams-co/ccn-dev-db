create or replace PACKAGE STR_BNK_DPST_RCNCL_PRCSS_TST
AS
/**********************************************************
  This Package contains procedured to perform the "Store Bank
  Deposit Daily Reconciliation" process

Created : 06/19/2015 jxc517 CCN Project....
Changed :
**********************************************************/
TYPE REF_CURSOR IS REF CURSOR;

FUNCTION GET_BNK_ACCNT_NBR_FOR_CC(
/******************************************************************************
 This function will return the bank account number for the cost center for the date minus
 delay date.

created : 07/25/2017 nxk927 CCN Project....
revised :
*******************************************************************************/
IN_COST_CENTER_CODE IN VARCHAR2,
IN_DATE             IN DATE) RETURN VARCHAR2;

PROCEDURE GET_LEAD_BANK_RECORD(
/******************************************************************************
  This procedure gets the lead bank record for the cost center passed in

Created : 06/22/2015 jxc517 CCN Project....
Changed : Parameter IN_COST_CENTER_CODE should be passed as 4 characters. If 6 characters
          use substr(cc,3)
Changed : 06/20/2017 jxc517/nxk927 CCN Project....
          Added IN_DATE parameter
          Added condition to get the lead bank account number as of the Bank Deposit Day
*******************************************************************************/
IN_COST_CENTER_CODE       IN     VARCHAR2,
IN_DATE                   IN     DATE,
OUT_LEAD_BANK_RECORD         OUT LEAD_BANK_CC%ROWTYPE);

FUNCTION RETURN_REFEED_CODE(
/*****************************************************************************
  This function will return the refeed code from the Refeed_lookup_tb for the 
  passed Tcode

Created : 08/23/2016 nxk927 CCN Project....
Changed :
*****************************************************************************/
IN_TCODE         IN VARCHAR2
) RETURN VARCHAR2;


PROCEDURE LOAD_DATA(
/******************************************************************************
  This procedure will load the table that will be used to generate the data
  for the UAR.POSITION file

Created : 07/27/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_DATE            IN         DATE);

PROCEDURE GENERATE_FILES(
/******************************************************************************
  This procedure will generate the uar.position file and the serail.dat file

Created : 07/27/2015 nxk927 CCN Project....
Changed :
*******************************************************************************/
IN_DATE            IN         DATE);

FUNCTION COST_CENTER_LOOK_UP_FNC(
/**********************************************************
THIS FUNCTION WILL RETURN 6 DIGIT COST_CENTER_CODE
WHEN THE 4-DIGIT CODE IS PASSED OR JUST THE 4 DIGIT COST CENTER CODE IF MATCHING COST CENTER CODE IS NOT FOUND
ERROR IS RAISED IF ERROR FLAG IS SET TO YES ELSE NO ERROR WILL BE RAISED

CREATED : 06/08/2017 RXA457 CCN PROJECT TEAM..
**********************************************************/
IN_COST_CENTER IN COST_CENTER.COST_CENTER_CODE%TYPE ,
IN_ERROR_FLAG IN VARCHAR DEFAULT 'Y')
RETURN VARCHAR2;

PROCEDURE LOAD_SUMMARY_EXTRCT_CNTRL_FL(
/*****************************************************************************
	This procedure will load the data into SUMMARY_EXTRCT_CNTRL_FL_PREV from
  TEMP_SUMMARY_EXTRCT_CNTRL_FL [using SRA10510 file ] for next day's use

Created : 06/25/2015 jxc517 CCN Project....
Changed : 10/07/2015 nxk927 CCN Project....
          added column Load_date and combined MONTH, DAY AND YEAR to get date column 
        : 01/29/2016 nxk927/dxv848 CCN Project....
          changed the code to avoid dublicated while inserting
        : 04/19/2016 nxk927 CCN Project....
          Inserting the data as it is, in different table and inserting the data in
          SUMMARY_EXTRCT_CNTRL_FL with the bank account for the cost center as is in our database
        : 05/13/2016 nxk927 CCN Project....
          removed the substr(rec.COST_CENTER_CODE,3) as was used by mistake
        : 03/21/2017 nxk927 CCN Project....
          New Column ORIGINATED_BANK_ACCNT_NBR added
        : 05/23/2017 rxa457 CCN Project...
          asp-761.. insert into SUMMARY_EXTRCT_CNTRL_FL, UAR_SUMMARY_EXTRCT_CNTRL_FL changed (due to impact from dropping column filler field from SUMMARY_EXTRCT_CNTRL_FL,FROM UAR_SUMMARY_EXTRCT_CNTRL_FL);
          cost_center_code field changed to 6 digit equivalent;
          Amount field changed to NUMBER(10,2) from Varchar2
Changed : 06/20/2017 jxc517/nxk927 CCN Project....
          Added IN_DATE parameter
          Signature change in call to GET_LEAD_BANK_RECORD
        : 06/28/2017 nxk927 CCN Project....
          logging the error before raising the error if any error occurs
        : 07/20/2017 nxk927 CCN Project....
          Data source changed. (data source will be new pos)
        : 07/25/2017 nxk927 CCN Project....
          calling the function to get the bank account number
        : 07/26/2017 nxk927 CCN Project....
          UAR table has to remain the same as in the output file
        : 07/27/2017 nxk927 CCN Project....
          loading the table with load date as of the passed date rather than using sysdate.
          Passing the transaction date to get the bank account number rather than the in_date
        : 10/04/2017 nxk927 CCN Project....
          added a logic to see if the data has been previously loaded.
        : 10/13/2017 nxk927 CCN Project....
          changed the data source to local table as we will be loading the data daily in our local table
          (POS_SUMMARY_EXTRCT_CNTRL_FL). This table will be loaded daily in POS_BANKING_DAILY_LOAD package
*****************************************************************************/
    IN_DATE            IN         DATE);

PROCEDURE LOAD_POS_SUMMARY_EXTRCT_DATA(
/*****************************************************************************
	This procedure will load the POS data from  CCN_BATCH_SUMMARY into POS_SUMMARY_EXTRCT_CNTRL_FL

Created : 06/22/2018 nxk927 CCN Project....
Changed : 
*****************************************************************************/
    IN_DATE            IN         DATE);

END STR_BNK_DPST_RCNCL_PRCSS_TST;