create or replace PACKAGE SD_FILE_BUILD_PKG
/**************************************************************** 
This package will have all the procedures to build the files on server

created : 07/25/2014 jxc517 CCN Project....
changed :
*****************************************************************/
IS

FUNCTION GET_CUSTOMER_TAX_ID(
/*****************************************************************************
	This function will return the tax id for the customer id passed in

created : 08/19/2015 jxc517 CCN Project....
changed :
*****************************************************************************/
IN_CUSTOMER_ACCOUNT_NUMBER   VARCHAR2) RETURN VARCHAR2;

FUNCTION GET_CUSTOMER_VENDOR_NO(
/*****************************************************************************
	This function will return the vendor number for the customer id passed in

created : 08/19/2015 jxc517 CCN Project....
changed :
*****************************************************************************/
IN_CUSTOMER_ACCOUNT_NUMBER   VARCHAR2) RETURN VARCHAR2;

FUNCTION FORMAT_INPUT_FOR_FILE(
/*****************************************************************************
	FORMAT_INPUT_FOR_FILE

	This function will return the formatted data as requested  

created : 07/25/2014 jxc517 CCN Project....
changed :
*****************************************************************************/
IN_VALUE         IN VARCHAR2,
IN_PADDING_VALUE IN VARCHAR2,
IN_LENGTH        IN NUMBER,
IN_PRECISION     IN NUMBER DEFAULT 0
) RETURN VARCHAR2;

PROCEDURE BUILD_1099_FILE(
/*****************************************************************************
	BUILD_1099_FILE

	This procedure will build the 1099 file from CPR views.  

Run Example:
Monthly file for october will be run on 01-Nov-2014
Mid Monthly file for october will be run on 15-Nov-2014
Difference file will be (Mid Monthly file - Monthly file)

created : 07/25/2014 jxc517 CCN Project....
changed : 11/24/2014 jxc517 CCN Project....
          Modified to include date parameter to rnu for previous month
          Modified to include a seperate logic to build diff file along with mid monthly file
*****************************************************************************/
IN_DATE           IN DATE,
IN_MID_MNTHLY_IND IN VARCHAR2 DEFAULT 'N');

PROCEDURE BUILD_1099_FILE_FOR_FSS(
/*****************************************************************************
	This procedure will build the 1099 file from CPR views that will be sent for FSS(Financial Shared Services)

created : 04/07/2015 jxc517 CCN Project....
changed : 
*****************************************************************************/
IN_DATE           IN DATE);

PROCEDURE STORE_DRAFT_INTALLER_1099 
/**********************************************************

	This procedure will build the 1099 intaller file from CPR views.  

created : 7/29/2014
changed :
**********************************************************/
(in_date in date) 
;

PROCEDURE OUTSTANDING_DRAFT_EXC
/**********************************************************

	This procedure will generate the Outstanding draft excel sheet
  and mailed to the department depending on the division code

created : nxk927 6/18/2015
changed :
**********************************************************/
(IN_DATE IN DATE,
IN_DIV  IN VARCHAR2);

PROCEDURE SD_1099_NO_MTCHD_VENDOR_RPRT(
/**********************************************************
	This procedure is intended to select records from 
  NO MATCH FOUND ON BANK TAPE FILE BY STORE NO. & DRAFT NO.
  
created : 7/29/2015 nxk927 CCN Project....
changed : 12/02/2015 nxk927 CCN Project Team....
          passing the 1099 picked start date and end date parameter.
          Currently not using but we might need in later.
**********************************************************/
IN_1099_PICKED_ST_DT   IN     DATE,
IN_1099_PICKED_END_DT  IN     DATE);

PROCEDURE SD_1099_MTCHD_PRCSNG_RPRT(
/**********************************************************
	This procedure is intended to select records from 
  MATCHED PROCESSING REPORT #1 BY STORE NO. & DRAFT NO.
  
created : 7/29/2015 nxk927 CCN Project....
changed : 12/02/2015 nxk927 CCN Project Team....
          passing the FSS start date and end date as  parameter so this can be called from UI as well
          on demand
**********************************************************/
IN_FSS_SENT_ST_DT      IN     DATE,
IN_FSS_SENT_END_DT     IN     DATE);

PROCEDURE SD_1099_NO_VNDR_ON_BNK_TP_RPRT(
/*******************************************************************************
	This procedure is intended to select records from 
  NO MATCH FOUND ON BANK TAPE FILE BY STORE NO. & DRAFT NO.

Created : 7/29/2015 nxk927 CCN Project....
Changed : 12/02/2015 nxk927 CCN Project Team....
          passing the 1099 picked start date and end date parameter.
          Currently not using but we might need in later.
*******************************************************************************/
IN_FSS_SENT_ST_DT      IN     DATE,
IN_FSS_SENT_END_DT     IN     DATE);

PROCEDURE SD_1099_TXPYR_ID_AP_TRNS_CRT(
/**********************************************************
	This procedure is intended to select records from 
  TAXPAYER ID AP TRANS CREATE

Created : 7/29/2015 nxk927 CCN Project....
Changed : 12/02/2015 nxk927 CCN Project Team....
          passing the 1099_PICKED start date and end date as  parameter so this can be called from UI as well
          on demand
**********************************************************/
IN_FSS_SENT_ST_DT      IN     DATE,
IN_FSS_SENT_END_DT     IN     DATE);

PROCEDURE SD_1099_CONSOLIDATED_RPT(
/******************************************************************************
  This procedure is a wrapper for store draft 1099 info feed to ap report
  
Created : 12/02/2015 nxk927 CCN Project....
Changed : 
*******************************************************************************/
IN_FSS_SENT_ST_DT      IN     DATE,
IN_FSS_SENT_END_DT     IN     DATE);

END SD_FILE_BUILD_PKG;