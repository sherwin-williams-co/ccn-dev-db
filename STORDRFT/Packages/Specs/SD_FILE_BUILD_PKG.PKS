create or replace PACKAGE SD_FILE_BUILD_PKG
/**************************************************************** 
This package will have all the procedures to build the files on server

created : 07/25/2014 jxc517 CCN Project....
changed :
*****************************************************************/
IS

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
  
created : nxk927 7/29/2015 CCN Project....
changed :
**********************************************************/
IN_DATE      IN     DATE);

PROCEDURE SD_1099_MTCHD_PRCSNG_RPRT(
/**********************************************************
	This procedure is intended to select records from 
  MATCHED PROCESSING REPORT #1 BY STORE NO. & DRAFT NO.
  
created : nxk927 7/29/2015 CCN Project....
changed :
**********************************************************/
IN_DATE      IN     DATE);

PROCEDURE SD_1099_NO_VNDR_ON_BNK_TP_RPRT (
/*******************************************************************************
	This procedure is intended to select records from 
  NO MATCH FOUND ON BANK TAPE FILE BY STORE NO. & DRAFT NO.

Created : nxk927 7/29/2015 CCN Project....
Changed : 
*******************************************************************************/
IN_DATE      IN     DATE);

PROCEDURE SD_1099_TXPYR_ID_AP_TRNS_CRT(
/**********************************************************
	This procedure is intended to select records from 
  TAXPAYER ID AP TRANS CREATE

Created : nxk927 7/29/2015 CCN Project....
Changed : :
**********************************************************/
IN_DATE      IN     DATE);

END SD_FILE_BUILD_PKG;