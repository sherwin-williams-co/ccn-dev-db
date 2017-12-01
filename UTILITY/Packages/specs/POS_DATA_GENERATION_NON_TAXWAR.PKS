create or replace PACKAGE POS_DATA_GENERATION_NON_TAXWAR 
IS
/*******************************************************************************
POS_DATA_GENERATION_NON_TAXWAR

This package is used to capture the changes done on tables and generate an XML file.

Created : 09/08/2017 rxv940 CCN Project....
Changed : 
*******************************************************************************/

PROCEDURE POS_TRG_EVENT_LOG(
/*******************************************************************************
This procedure is used to capture the changes done on tables into 
pos_downloads_non_taxware table

Created : 09/08/2017 rxv940 CCN Project....
Changed : 
*******************************************************************************/
    IN_COUNTRY_CODE     IN VARCHAR2, 
    IN_DATA_SOURCE      IN VARCHAR2, 
    IN_DATA_OPERATION   IN VARCHAR2,
    IN_FILE_TYPE        IN VARCHAR2,
    IN_STATE_CODE      IN VARCHAR2);
    
PROCEDURE TAX_CUR_UPD_SP (
 /*******************************************************************************
This Procedure is to generate the Init load process

Created : 09/18/2017 rxv940 CCN Project....
Changed :
*******************************************************************************/
    IN_POS_ID      IN       POS_DOWNLOADS_NON_TAXWARE.POS_ID%TYPE,
    OUT_XML_VALUE      OUT  CLOB,
    OUT_REQ_VALUE      OUT  VARCHAR2,
    OUT_FILE_NAME      OUT  VARCHAR2);
    
FUNCTION RETURN_POS_DOWNLOADS(
/*******************************************************************************
This Function is used to return the POS_DOWNLOADS_NON_TAXWAR information

Created : 09/11/2017 rxv940 CCN Project....
Changed :
*******************************************************************************/
    IN_POS_ID    IN NUMBER,
    IN_FILE_NAME IN VARCHAR2)  RETURN POS_DOWNLOADS_NON_TAXWARE%ROWTYPE;   
    
PROCEDURE POS_DOWNLOADS_UPD_SP(
/*******************************************************************************
This procedure is used do update on the table POS_DOWNLOADS_NON_TAXWARE 

Created : 10/17/2016 rxv940 CCN Project....
Changed :                   
*******************************************************************************/
    IN_POS_DOWNLOADS POS_DOWNLOADS_NON_TAXWARE%ROWTYPE);    
    
PROCEDURE POS_DOWNLOADS_UPD_SP(
/*******************************************************************************
This procedure is used do update on the table POS_DOWNLOADS_NON_TAXWARE 

Created : 11/03/2016 rxv940 CCN Project....
Changed :                   
*******************************************************************************/
    IN_FILE_NAME  IN    POS_DOWNLOADS_NON_TAXWARE.FILE_NAME%TYPE,
    IN_RQST_ID    IN    POS_DOWNLOADS_NON_TAXWARE.POLLING_REQUEST_ID%TYPE);
    
PROCEDURE POS_TRG_EVENT_LOG(
/*******************************************************************************
This procedure is used to capture the changes done on tables into pos_downloads 
table

Created : 09/08/2017 rxv940 CCN Project....
Changed : 
*******************************************************************************/
    IN_COST_CENTER_CODE IN VARCHAR2,
    IN_DATA_SOURCE      IN VARCHAR2, 
    IN_DATA_OPERATION   IN VARCHAR2,
    IN_FILE_TYPE        IN VARCHAR2);

END POS_DATA_GENERATION_NON_TAXWAR;