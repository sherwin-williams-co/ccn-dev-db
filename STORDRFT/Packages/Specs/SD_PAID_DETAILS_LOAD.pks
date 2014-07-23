create or replace PACKAGE SD_PAID_DETAILS_LOAD
/**************************************************************** 
This package will update paid details in the existing CCN Store Drafts Oracle Database
created : 07/23/2014 jxc517 CCN Project....
changed :
*****************************************************************/
IS

FUNCTION VALIDATE_DATA_BEFORE_LOAD(
/*****************************************************************************
	VALIDATE_DATA_BEFORE_LOAD

	This function will validate if the value is some default value in idms
  which should go as NULL in database.  

created : 07/23/2014 jxc517 CCN Project....
changed :
*****************************************************************************/
    IN_VALUE     IN    VARCHAR2) RETURN VARCHAR2;
    
PROCEDURE CCN_SD_PAID_LOAD_SP
/******************************************************************
This Procedure is a wrapper for the Paid details update of the store drafts tables

created : 07/23/2014 jxc517 CCN Project....
changed :
******************************************************************/
;

END SD_PAID_DETAILS_LOAD;

