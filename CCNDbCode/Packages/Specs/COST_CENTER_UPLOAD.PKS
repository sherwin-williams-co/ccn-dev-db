create or replace PACKAGE COST_CENTER_UPLOAD AS

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
IN_BLOB            IN       BLOB);

PROCEDURE READ_CATEGORY_FROM_BLOB(
/******************************************************************************
READ_CATEGORY_FROM_BLOB

This procedure will get the category info for the uploaded file from UI

IN_BLOB          - blob value delimited by , and termianted by new line character
created : 03/09/2018 mxv711 added to read category from blob ASP-824

******************************************************************************/
    IN_BLOB        IN       BLOB,
    OUT_CATEGORY   OUT      COST_CENTER.CATEGORY%TYPE);

 END COST_CENTER_UPLOAD;