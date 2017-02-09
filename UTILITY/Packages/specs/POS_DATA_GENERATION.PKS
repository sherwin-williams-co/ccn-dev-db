CREATE OR REPLACE PACKAGE CCN_UTILITY.POS_DATA_GENERATION
IS
/*******************************************************************************
POS_DATA_GENERATION

This package is used to capture the changes done on tables and generate an XML file.

created : 10/17/2016 MXK766 CCN Project....
changed : 
*******************************************************************************/

G_POS_ID NUMBER;
TYPE TYP_POS_ID IS TABLE OF NUMBER;

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

This procedure is used to read the POS_ID and identify which files should be called for the POS_ID

created : 10/17/2016 MXK766 CCN Project....
changed :
*******************************************************************************/
   IN_POS_ID             IN  POS_DATA_GENERATION.TYP_POS_ID
);

FUNCTION CHECK_COST_CENTER_CATEGORY(
/*******************************************************************************
CHECK_COST_CENTER_CATEGORY

This function is used to return the category from the cost center table.

created : 10/17/2016 MXK766 CCN Project....
changed :
*******************************************************************************/
    IN_COST_CENTER_CODE IN VARCHAR2)
RETURN VARCHAR2;


END POS_DATA_GENERATION;
/