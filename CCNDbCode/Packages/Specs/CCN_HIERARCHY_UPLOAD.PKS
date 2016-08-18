create or replace PACKAGE CCN_HIERARCHY_UPLOAD
    AS

PROCEDURE BUILD_HIERARCHY_INSERT_CLOB(
/******************************************************************************
BUILD_HIERARCHY_INSERT_CLOB

This procedure builds the xml as clob for Hierarchy Insert Process based on 
input parameters
created : 12/18/2013 JXC517 CCN Project....

******************************************************************************/
                IN_CC_CODE             IN        COST_CENTER.COST_CENTER_CODE%TYPE,
                IN_MANAGER_ID          IN        VARCHAR2,
                IN_HIERARCHY_NAME      IN        HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE,
                IN_COMPOSITE_KEYVALUE  IN        VARCHAR2,
                IN_EFFECTIVE_DATE      IN        DATE,
                OUT_XML_AS_CLOB        OUT       CLOB);

PROCEDURE BUILD_HIERARCHY_TRNSFR_CLOB(
/******************************************************************************
BUILD_HIERARCHY_TRNSFR_CLOB

This procedure builds the xml as clob for Hierarchy Transfer Process based on 
input parameters
created : 1/14/2014 JXC517 CCN Project....

******************************************************************************/
                IN_CC_CODE                  IN        COST_CENTER.COST_CENTER_CODE%TYPE,
                IN_MANAGER_ID               IN        VARCHAR2,
                IN_HIERARCHY_NAME           IN        HIERARCHY_DETAIL.HRCHY_HDR_NAME%TYPE,
                IN_FROM_COMPOSITE_KEYVALUE  IN        VARCHAR2,
                IN_TO_COMPOSITE_KEYVALUE    IN        VARCHAR2,
                IN_EFFECTIVE_DATE           IN        DATE,
                OUT_XML_AS_CLOB                OUT    CLOB);

PROCEDURE HIERARCHY_BULK_TRNSFR_PROCESS
/******************************************************************************
HIERARCHY_BULK_TRNSFR_PROCESS

This procedure is the for the Hierarchy bulk transfer process

Created : JXC517 1/14/2014
******************************************************************************/
;

PROCEDURE HIERARCHY_BULK_LOAD_PROCESS
/******************************************************************************
HIERARCHY_LOAD_PROCESS

This procedure is the for the Hierarchy bulk upload process

Created : SH 12/23/2013
******************************************************************************/
;

END CCN_HIERARCHY_UPLOAD;