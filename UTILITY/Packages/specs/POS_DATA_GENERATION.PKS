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

PROCEDURE POS_MASTER_SP(
/*******************************************************************************
This procedure is used to generate file based upon the costcentercode and filetype.

Created : 10/17/2016 MXK766 CCN Project....
Changed :
*******************************************************************************/
   IN_COST_CENTER_CODE             IN  POS_DOWNLOADS.COST_CENTER_CODE%TYPE);

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

PROCEDURE INIT_LOAD_TERR_SP
/*******************************************************************************
This procedure is used to create a territory Init load file.

The expected XML should be as given below.
NOTE: The order of the XML elements should be maintained as the xsd is looking for
the order of the XML elements.

Created : 10/17/2016 MXK766 CCN Project....
Changed :
*********************************************************************************/
;

PROCEDURE INIT_LOAD_STORE_SP
/*******************************************************************************
This procedure is used to create a Store Init load file.

Created : 02/23/2017 RXV940 CCN Project....
Changed :
*********************************************************************************/
;

PROCEDURE INIT_LOAD_PARAM_SP
/*******************************************************************************
This procedure is used to create a PARAM Init load file.

Created : 03/30/2017 rxv940 CCN Project....
Changed :
*********************************************************************************/
;

PROCEDURE NEW_STORES_INIT_LOAD_PROCESS
/*******************************************************************************
This procedure is used to create an Initload for STORE, TERR and PARAM all at once

Created : 04/10/2017 rxv940 CCN Project....
Changed :
*********************************************************************************/
;

PROCEDURE GENERATE_STORE_LIST_FROM_WS_SP(
/*******************************************************************************
This procedure is used to create an Initload for STORE, TERR and PARAM based
on the input parameter. This is a temp code for Web Service differencing

Created : 09/28/2017 rxv940 CCN Project....
Changed :
*********************************************************************************/
           IN_FILE_TYPE VARCHAR2)
;

END POS_DATA_GENERATION;