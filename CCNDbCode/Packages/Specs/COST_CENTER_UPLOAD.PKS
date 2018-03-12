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

 END COST_CENTER_UPLOAD;