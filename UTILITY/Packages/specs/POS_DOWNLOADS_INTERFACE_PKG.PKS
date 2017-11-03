create or replace PACKAGE POS_DOWNLOADS_INTERFACE_PKG IS


PROCEDURE INIT_LOAD_BY_APP_NAME(
/*******************************************************************************
This procedure is used to create an WS diff file with the list of newly added cost centers

Created : 10/12/2017 rxv940 CCN Project....
Changed :
*********************************************************************************/
      IN_APP_NAME                VARCHAR2,
      IN_LOAD_TYPE               VARCHAR2,
      OUT_XML_DATA          OUT  CLOB,
      OUT_PRE_REQ_ID        OUT VARCHAR2,
      OUT_FILE_NAME         OUT VARCHAR2
      );



PROCEDURE WS_DIFF_BY_FILE_TYPE(
/*******************************************************************************
This procedure is used to create an WS diff file with the list of newly added cost centers

Created : 10/12/2017 rxv940 CCN Project....
Changed :
*********************************************************************************/
      IN_FILE_TYPE       VARCHAR2,
      IN_STR_LIST        VARCHAR2,
      OUT_LIST       OUT VARCHAR2
      );

PROCEDURE POS_DOWNLOADS_UPD_SP(
/*******************************************************************************
This procedure is used do update on the table POS_DOWNLOADS 

Created : 10/17/2016 rxv940 CCN Project....
Changed : 06/02/2017 rxv940 CCN Project....
        : Selecting only the first 36 characters of Request_id.
*******************************************************************************/
    IN_APP_NAME  VARCHAR2, -- can be "STORE", "TERR", "PARAM', "PrimeSub", "TAXCURR"
    IN_FILE_NAME POS_DOWNLOADS.FILE_NAME%TYPE,
    IN_RQST_ID   POS_DOWNLOADS.POLLING_REQUEST_ID%TYPE); 

END POS_DOWNLOADS_INTERFACE_PKG;