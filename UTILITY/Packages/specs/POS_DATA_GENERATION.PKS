CREATE OR REPLACE PACKAGE CCN_UTILITY.POS_DATA_GENERATION
IS
/*******************************************************************************
POS_DATA_GENERATION

This package is used to capture the changes done on tables and generate an XML file.

created : 10/17/2016 MXK766 CCN Project....
changed : 
*******************************************************************************/

PROCEDURE POS_TRG_EVENT_LOG(
/*******************************************************************************
POS_TRG_EVENT_LOG

This procedure is used to capture the changes done on tables into pos_downloads 
table

created : 10/17/2016 MXK766 CCN Project....
changed : 
*******************************************************************************/
    IN_COST_CENTER_CODE IN VARCHAR2, 
    IN_DATA_SOURCE      IN VARCHAR2, 
    IN_DATA_OPERATION   IN VARCHAR2,
    IN_FILE_TYPE        IN VARCHAR2
);

PROCEDURE POS_MASTER_SP(
/*******************************************************************************
POS_MASTER_SP

This procedure is used to generate file based upon the costcentercode and filetype.

created : 10/17/2016 MXK766 CCN Project....
changed :
*******************************************************************************/
   IN_COST_CENTER_CODE             IN  POS_DOWNLOADS.COST_CENTER_CODE%TYPE
);

FUNCTION RETURN_COST_CENTER_CODE(
/*******************************************************************************
RETURN_COST_CENTER_CODE

This function is used to return the COST_CENTER information

created : 10/17/2016 MXK766 CCN Project....
changed :
*******************************************************************************/
    IN_APPLICATION IN VARCHAR2,
    IN_DATA        IN XMLTYPE, 
    IN_XPATH       IN VARCHAR2
)
RETURN VARCHAR2;

FUNCTION CHECK_COST_CENTER_CATEGORY(
/*******************************************************************************
CHECK_COST_CENTER_CATEGORY

This function is used to return the category from the cost center table.

created : 10/17/2016 MXK766 CCN Project....
changed :
*******************************************************************************/
    IN_COST_CENTER_CODE IN VARCHAR2)
RETURN VARCHAR2;

FUNCTION RETURN_POS_DOWNLOADS(
/*******************************************************************************
RETURN_POS_DOWNLOADS

This Function is used to return the POS_DOWNLOADS information

created : 11/09/2016 MXK766 CCN Project....
changed :
*******************************************************************************/
    IN_POS_ID    IN NUMBER,
    IN_FILE_NAME IN VARCHAR2) RETURN POS_DOWNLOADS%ROWTYPE;

PROCEDURE POS_DOWNLOADS_UPD_SP(
/*******************************************************************************
POS_DOWNLOADS_UPD_SP

This procedure is used do update on the table POS_DOWNLOADS 

created : 10/17/2016 MXK766 CCN Project....
changed :
*******************************************************************************/
    IN_POS_DOWNLOADS POS_DOWNLOADS%ROWTYPE
);

END POS_DATA_GENERATION;