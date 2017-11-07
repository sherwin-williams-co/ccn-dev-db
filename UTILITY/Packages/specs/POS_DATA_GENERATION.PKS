create or replace PACKAGE             POS_DATA_GENERATION
IS
/*******************************************************************************
POS_DATA_GENERATION

This package is used to capture the changes done on tables and generate an XML file.

Created : 10/17/2016 MXK766 CCN Project....
Changed : 
*******************************************************************************/

PROCEDURE POS_TRG_EVENT_LOG(
/*******************************************************************************
This procedure is used to capture the changes done on tables into pos_downloads 
table

Created : 10/17/2016 MXK766 CCN Project....
Changed : 
*******************************************************************************/
    IN_COST_CENTER_CODE IN VARCHAR2, 
    IN_DATA_SOURCE      IN VARCHAR2, 
    IN_DATA_OPERATION   IN VARCHAR2,
    IN_FILE_TYPE        IN VARCHAR2);
    
PROCEDURE GENERATE_POS_STORE_UPD_SP(
/*******************************************************************************
This procedure is used to read the changes that happen for any Price district cost centers
and generate an XML document with those changes.

Created : 11/02/2017 rxv940 CCN Project....
*******************************************************************************/
    IN_POS_ID      IN       POS_DOWNLOADS.POS_ID%TYPE,
    OUT_XML_VALUE      OUT  CLOB,
    OUT_REQ_VALUE      OUT  VARCHAR2,
    OUT_FILE_NAME      OUT  VARCHAR2);
    
PROCEDURE GEN_POS_TERRITORY_UPD_SP(
/*******************************************************************************
This procedure is used to read the changes that happen for any Territory
and generate an XML document with those changes.

Created : 11/02/2017 rxv940 CCN Project....
Changed : 
*******************************************************************************/
    IN_POS_ID       IN  POS_DOWNLOADS.POS_ID%TYPE,
    OUT_XML_VALUE      OUT  CLOB,
    OUT_REQ_VALUE      OUT  VARCHAR2,
    OUT_FILE_NAME      OUT  VARCHAR2);
    
PROCEDURE GEN_PARAM_UPD_SP(
/*******************************************************************************
This procedure is used to read the changes that happen for any Territory
and generate an XML document with those changes.
Created : 11/02/2017 rxv940 CCN Project....
Changed : 
*******************************************************************************/
    IN_POS_ID      IN  POS_DOWNLOADS.POS_ID%TYPE,
    OUT_XML_VALUE      OUT  CLOB,
    OUT_REQ_VALUE      OUT  VARCHAR2,
    OUT_FILE_NAME      OUT  VARCHAR2);

FUNCTION CHECK_COST_CENTER_CATEGORY(
/*******************************************************************************
This function is used to return the category from the cost center table.

Created : 10/17/2016 MXK766 CCN Project....
Changed :
*******************************************************************************/
    IN_COST_CENTER_CODE IN VARCHAR2) RETURN VARCHAR2;

FUNCTION RETURN_POS_DOWNLOADS(
/*******************************************************************************
This Function is used to return the POS_DOWNLOADS information

Created : 11/09/2016 MXK766 CCN Project....
Changed :
*******************************************************************************/
    IN_POS_ID    IN NUMBER,
    IN_FILE_NAME IN VARCHAR2) RETURN POS_DOWNLOADS%ROWTYPE;

PROCEDURE POS_DOWNLOADS_UPD_SP(
/*******************************************************************************
This procedure is used do update on the table POS_DOWNLOADS 

Created : 10/17/2016 MXK766 CCN Project....
Changed :
*******************************************************************************/
    IN_POS_DOWNLOADS POS_DOWNLOADS%ROWTYPE);

PROCEDURE INIT_LOAD_TERR_SP(
/*******************************************************************************
This procedure is used to create a territory Init load file.

The expected XML should be as given below.
NOTE: The order of the XML elements should be maintained as the xsd is looking for
the order of the XML elements.

Created : 10/17/2016 MXK766 CCN Project....
Changed :
*********************************************************************************/
    IN_LOAD_TYPE   IN       VARCHAR2);

PROCEDURE INIT_LOAD_STORE_SP(
/*******************************************************************************
This procedure is used to create a Store Init load file.

Created : 02/23/2017 RXV940 CCN Project....
Changed :
*********************************************************************************/
    IN_LOAD_TYPE   IN       VARCHAR2);

PROCEDURE INIT_LOAD_STORE_SP(
/*******************************************************************************
This procedure is used to create a Store Init load file fro WS diff

Created : 10/12/2017 rxv CCN Project....
Changed :
*********************************************************************************/
    IN_LOAD_TYPE   IN       VARCHAR2,
    OUT_XML_VALUE      OUT  CLOB,
    OUT_REQ_VALUE      OUT  VARCHAR2,
    OUT_FILE_NAME      OUT  VARCHAR2);

PROCEDURE INIT_LOAD_TERR_SP(
/*******************************************************************************
This procedure is used to create a territory Init load file.

Created : 10/12/2017 rxv940 CCN Project....
Changed : 
*******************************************************************************/
    IN_LOAD_TYPE   IN       VARCHAR2,
    OUT_XML_VALUE      OUT  CLOB,
    OUT_REQ_VALUE      OUT  VARCHAR2,
    OUT_FILE_NAME      OUT  VARCHAR2);
    
PROCEDURE POS_DOWNLOADS_UPD_SP(
/*******************************************************************************
This procedure is used do update on the table POS_DOWNLOADS 

Created : 10/20/2017 rxv940 CCN Project....
Changed :
*******************************************************************************/
    IN_FILE_NAME POS_DOWNLOADS.FILE_NAME%TYPE,
    IN_RQST_ID   POS_DOWNLOADS.POLLING_REQUEST_ID%TYPE);
    
END POS_DATA_GENERATION;