create or replace PACKAGE COST_CENTER_UPLOAD AS 
 
 FUNCTION BUILD_TAG(
/******************************************************************************
BUILD_TAG

This function will build the tag based on passed input parameters

******************************************************************************/
                      IN_VALUE     IN VARCHAR2,
                      IN_TAG_NAME  IN VARCHAR2,
                      IN_DATE_FLAG IN VARCHAR2 DEFAULT 'N')
   RETURN VARCHAR2;

PROCEDURE LOG_ERROR(
/******************************************************************************
LOG_ERROR

This procedure is an autonomous transaction that logs the errors and proceeds 
with the execution of rest of the cost centers

******************************************************************************/
                    IN_CC      IN VARCHAR2,
                    IN_SQLERRM IN VARCHAR2,
                    IN_SQLCODE IN NUMBER);

 PROCEDURE BATCH_LOAD_PROCESS
/******************************************************************************
BATCH_LOAD_PROCESS

This procedure is the core process for the cost center bulk upload batch
that invokes all the 5 categories of cost center creations
Territory, Store, Administration, Real Estate and Other

******************************************************************************/
;

PROCEDURE UI_LOAD_PROCESS(
/******************************************************************************
UI_LOAD_PROCESS

This procedure is the core process for the cost center bulk upload through UI
that invokes one of the 5 categories of cost center creations
Territory, Store, Administration, Real Estate and Other based on the parameters passed

IN_BLOB          - blob value delimited by , and termianted by new line character
IN_CATEGORY_CODE - A ADMINISTRATIVE, M	MANUFACTURING, O	OTHER, R	REAL ESTATE, S	STORE, T	TERRITORY

******************************************************************************/
IN_BLOB            IN       BLOB,
IN_CATEGORY_CODE   IN       COST_CENTER.CATEGORY%TYPE);

 END COST_CENTER_UPLOAD;

