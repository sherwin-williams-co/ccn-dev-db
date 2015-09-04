CREATE OR REPLACE PACKAGE RSA_WEB_SERVICES_PKG AS 
/**********************************************************
This Package contains all the procedures used to
communicate with RSA Web Services

Created : 08/03/2015 jxc517 CCN Project....
Changed :
**********************************************************/

TYPE REF_CURSOR IS REF CURSOR;

PROCEDURE CREATE_ORDER( 
/******************************************************************************
This procedure is intended to create an order via RSA Web Service

Created : 08/03/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
    IN_ROW_DATA  IN  CLOB);

PROCEDURE UPDATE_ORDER( 
/******************************************************************************
This procedure is intended to update an order via RSA Web Service

Created : 08/03/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
    IN_ROW_DATA  IN  CLOB);

PROCEDURE SEARCH_ORDER( 
/******************************************************************************
This procedure is intended to search orders via RSA Web Service

Created : 08/03/2015 jxc517 CCN Project....
Changed : 
*******************************************************************************/
    IN_ROW_DATA  IN  CLOB);

END RSA_WEB_SERVICES_PKG;

