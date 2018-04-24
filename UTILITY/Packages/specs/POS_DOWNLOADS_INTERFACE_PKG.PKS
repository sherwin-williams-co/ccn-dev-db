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
    
FUNCTION IS_MAINTENANCE_RQRD_FNC 
/************************************************************************
This Function checks the file processed status in POS_DOWNLOADS  table and returns 'Y' if 
there are any unprocessed records 

Created : 11/7/2017  bxa919 CCN Project....
Changed :
************************************************************************/
RETURN VARCHAR2;

PROCEDURE GET_POLLING_MAINTENANCE_DTLS (
/*******************************************************************************
This Function checks the Unprocessed records in POS_DOWNLOAD table and returns the 
Pos_ID and APPLICATION_NAME details .

Created : 11/7/2017  bxa919 CCN Project....
Changed :
*******************************************************************************/
   OUT_REF_CUR     OUT SYS_REFCURSOR);
 
PROCEDURE PROCESS_POLLING_REQUEST_ID(
/*******************************************************
This pocedure passes the POS_ID and invokes the corresponding procedures based
on the Application name.

Created : 11/7/2017  bxa919 CCN Project....
Changed :
*******************************************************/
IN_POS_ID		  IN     VARCHAR2,
IN_APP_NAME		IN     VARCHAR2,
OUT_XML			     OUT CLOB,
OUT_FILE_NAME	   OUT VARCHAR2,
OUT_PREV_REQ_ID	 OUT VARCHAR2
); 

PROCEDURE VALIDATE_POS_QUEUE_MESSAGE(
/*******************************************************************************
This procedure is used to create an WS diff file with the list of newly added cost centers

Created : 11/08/2017 rxv940 CCN Project....
Changed : 
*********************************************************************************/
      IN_STR_LIST   IN     VARCHAR2,
      OUT_LIST         OUT VARCHAR2);

PROCEDURE PROCESS_STORE_POS_STRT_DT_LOAD(
/*******************************************************************************
This procedure is used to to validate the messages and update POLLING.POLLING_START_DATE field in CCN.

Created : 04/10/2018 nxk927 CCN Project....
Changed :    
*********************************************************************************/
IN_STR_LIST   IN     VARCHAR2);


END POS_DOWNLOADS_INTERFACE_PKG;