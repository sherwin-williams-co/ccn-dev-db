CREATE OR REPLACE PACKAGE STORDRFT.initLoad
/**************************************************************** 
This package will load the new CCN Store Drafts Oracle Database
created : 04/29/2013 jxc517 CCN Project....
changed :
*****************************************************************/
IS

FUNCTION VALIDATE_DATA_BEFORE_LOAD(
/*****************************************************************************
	VALIDATE_DATA_BEFORE_LOAD

	This function will validate if the value is some default value in idms
  which should go as NULL in database.  

created : 04/29/2013 jxc517 CCN Project....
changed :
*****************************************************************************/
    IN_VALUE     IN    VARCHAR2) RETURN VARCHAR2;
    
FUNCTION RETURN_NUMBER(
/*****************************************************************************
	RETURN_NUMBER

	This function will return the number based on precision and scale passed

created : 04/29/2013 jxc517 CCN Project....
changed :
*****************************************************************************/
    IN_VALUE     IN    VARCHAR2,
    IN_PRECISION IN    NUMBER,
    IN_SCALE     IN    NUMBER) RETURN NUMBER;

PROCEDURE CCN_SD_INITLOAD_SP
/******************************************************************
This Procedure is a wrapper for the Initial Load of the store drafts tables
    * Deletes all the store drafts tables
    * Loads all the store drafts tables

created : 04/29/2013 jxc517 CCN Project....
changed :
******************************************************************/
;

END initLoad;