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

FUNCTION IS_VALUE_CHANGED(
/*****************************************************************************
	FORMAT_INPUT_FOR_FILE

	This function will return the formatted data as requested  

created : 07/25/2014 jxc517 CCN Project....
changed :
*****************************************************************************/
IN_PREV_VALUE IN VARCHAR2,
IN_CURR_VALUE IN VARCHAR2) RETURN BOOLEAN;

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

PROCEDURE STORE_DRAFT_INTALLER_1099 
/**********************************************************

	This procedure will build the 1099 intaller file from CPR views.  

created : 7/29/2014
changed :
**********************************************************/
(in_date in date) 
;

END SD_FILE_BUILD_PKG;

