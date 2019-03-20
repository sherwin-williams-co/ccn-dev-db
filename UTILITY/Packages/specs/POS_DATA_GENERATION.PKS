create or replace PACKAGE             POS_DATA_GENERATION
IS
/*******************************************************************************
POS_DATA_GENERATION

This package is used to capture the changes done on tables and generate an XML file.

Created : 10/17/2016 MXK766 CCN Project....
Changed : 
*******************************************************************************/
TYPE REF_CURSOR IS REF CURSOR;
G_MUT_POS_DOWNLOAD_CC_IND VARCHAR2(1) := NULL;
-- Global variable to handle mutating trigger error caused by TR_COST_CENTER_UPD

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

PROCEDURE SET_FLAG_POLLING_BULK_LOADS (
/*******************************************************************************
This procedure is intended to set flag into POS_DOWNLOADS_BULK_LOADS_LKUP table

created : 02/08/2018 rxv940 CCN Project....
revised :     
*******************************************************************************/
    IN_MAINTENANCE_TYPE    IN      VARCHAR2,
    OUT_BULK_LOADS_LKUP_ID     OUT NUMBER);
    
PROCEDURE RESET_FLAG_POLLING_BULK_LOADS (
/*******************************************************************************
This procedure is intended to Reset flag into POS_DOWNLOADS_BULK_LOADS_LKUP table

created : 12/26/2017 rxv940 CCN Project....
revised :     
*******************************************************************************/
    IN_BULK_LOADS_LKUP_ID IN NUMBER);

PROCEDURE POS_ON_DEMAND_DWNLD_ROWTYPE_SP (
/*******************************************************************************
This procedure is intended to Convert the POS_ON_DEMAND_DOWNLOAD xml into rowtype.

created : 03/05/2019 pxa852 CCN Project Team....
revised :
*******************************************************************************/
    IN_TABLE_NAME            IN     VARCHAR2,
    IN_ROW_DATA              IN     VARCHAR2,
    OUT_POS_ON_DEMAND_ROW       OUT POS_ON_DEMAND_DOWNLOADS%ROWTYPE
    );

PROCEDURE PROCESS_POLLING_ON_DEMAND(
/*******************************************************************************
This procedure is to load ON DEMAND polling requests into the POS_DOWNLOADS table

Created : 03/06/2019 pxa852 CCN Project Team....
Changed :
*******************************************************************************/
    IN_ON_DEMAND_ROW  IN  POS_ON_DEMAND_DOWNLOADS%ROWTYPE,
    IN_FILE_TYPE      IN  VARCHAR2);
    
PROCEDURE POLLING_ON_DEMAND_BULK_LOADS_SP;
/*******************************************************************************
This procedure is intended to insert new POS_ON_DEMAND_DOWNLOADS records

created : 03/08/2019 pxa852 CCN Project Team....
revised :
*******************************************************************************/

PROCEDURE RETURN_STORE_POS_DOWNLOAD_HIST (
/**********************************************************
This procedure will return a ref cursor with data from
from the POS_DOWNLOAD table based on COST_CENTER_CODE for STORE Download

created : 03/11/2019 pxa852 CCN Project Team...
Modified:
**********************************************************/
    IN_COST_CENTER_CODE         IN VARCHAR2,
    OUT_STORE_POS_DWNLD_REF_CUR   OUT REF_CURSOR);

PROCEDURE RETURN_PARAM_POS_DOWNLOAD_HIST (
/**********************************************************
RETURN_POS_DOWNLOAD_HIST
This procedure will return a ref cursor with data from
from the POS_DOWNLOAD table based on COST_CENTER_CODE for PARAM Download

created : 03/11/2019 pxa852 CCN Project Team...
Modified:
**********************************************************/
    IN_COST_CENTER_CODE         IN VARCHAR2,
    OUT_PARAM_POS_DWNLD_REF_CUR   OUT REF_CURSOR);

PROCEDURE RETURN_TERR_POS_DOWNLOAD_HIST (
/**********************************************************
RETURN_POS_DOWNLOAD_HIST
This procedure will return a ref cursor with data from
from the POS_DOWNLOAD table based on COST_CENTER_CODE for TERR Download

created : 03/11/2019 pxa852 CCN Project Team...
Modified:
**********************************************************/
    IN_COST_CENTER_CODE         IN VARCHAR2,
    OUT_TERR_POS_DWNLD_REF_CUR    OUT REF_CURSOR);

PROCEDURE RETURN_TAXCURR_POS_DOWNLOAD_HIST (
/**********************************************************
RETURN_POS_DOWNLOAD_HIST
This procedure will return a ref cursor with data from
from the POS_DOWNLOAD table based on COST_CENTER_CODE for TAXCURR Download

created : 03/11/2019 pxa852 CCN Project Team...
Modified:
**********************************************************/
    IN_COST_CENTER_CODE           IN VARCHAR2,
    OUT_TAXCURR_POS_DWNLD_REF_CUR   OUT REF_CURSOR);

PROCEDURE RETURN_PRIMESUB_POS_DOWNLOAD_HIST (
/**********************************************************
RETURN_POS_DOWNLOAD_HIST
This procedure will return a ref cursor with data from
from the POS_DOWNLOADS_GL_PS table based on COST_CENTER_CODE for Primesub Download

created : 03/11/2019 pxa852 CCN Project Team...
Modified:
**********************************************************/
    IN_ACCOUNT_NUMBER              IN VARCHAR2,
    OUT_PRIMESUB_POS_DWNLD_REF_CUR   OUT REF_CURSOR);

END POS_DATA_GENERATION;