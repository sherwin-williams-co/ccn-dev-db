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

PROCEDURE BUILD_1099_FILE
/*****************************************************************************
	BUILD_1099_FILE

	This procedure will build the 1099 file from CPR views.  

created : 07/25/2014 jxc517 CCN Project....
changed :
*****************************************************************************/
;

END SD_FILE_BUILD_PKG;