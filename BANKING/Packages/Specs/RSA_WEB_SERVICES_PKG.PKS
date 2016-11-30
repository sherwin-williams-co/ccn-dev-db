create or replace PACKAGE RSA_WEB_SERVICES_PKG AS 
/**********************************************************
This Package contains all the procedures used to
communicate with RSA Web Services

Created : 08/03/2015 jxc517 CCN Project....
Changed :
**********************************************************/

TYPE REF_CURSOR IS REF CURSOR;

PROCEDURE CREATE_DEPOSIT_TICKET_ORDER( 
/******************************************************************************
This procedure is intended to create an order via RSA Web Service

Created : 08/03/2015 jxc517 CCN Project....
Changed : 06/10/2015 jxc517 CCN Project....
          Addded parameter to pass order GUID to corresponding team
Changed : 11/30/2016 nxk927 CCN Project....
          Addded parameter to pass order date instead of effective date in the orders
*******************************************************************************/
    IN_DEP_TICK_REC  IN     BANK_DEP_TICK%ROWTYPE,
    IN_ORDER_DATE    IN     DATE,
    IN_ORDER_GUID    IN     VARCHAR2);

PROCEDURE CREATE_DEPOSIT_BAG_ORDER( 
/******************************************************************************
This procedure is intended to create an bag order via RSA Web Service

Created : 09/28/2015 jxc517 CCN Project....
Changed : 06/10/2015 jxc517 CCN Project....
          Addded parameter to pass order GUID to corresponding team
Changed : 11/30/2016 nxk927 CCN Project....
          Addded parameter to pass order date instead of effective date in the orders
*******************************************************************************/
    IN_DEP_BAG_TICK_REC  IN     BANK_DEP_BAG_TICK%ROWTYPE,
    IN_USER_ID           IN     VARCHAR2,
    IN_ORDER_DATE        IN     DATE,
    IN_ORDER_GUID        IN     VARCHAR2);

END RSA_WEB_SERVICES_PKG;