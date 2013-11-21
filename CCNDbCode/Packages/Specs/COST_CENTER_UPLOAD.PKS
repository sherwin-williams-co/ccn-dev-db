PACKAGE COST_CENTER_UPLOAD AS 
PROCEDURE COST_CENTER_UPSERT( 
 /******************************************************************************
	COST_CENTER_UPSERT   --    Cost Center Update delete Procedure

	This procedure is intended to update the database for the following tables used in
        Cost Center UI.
	Tables: 
              COST_CENTER
           ,  ADMINISTRATION, STORE, OTHER, REAL_ESTATE, TERRITORY,
            , STATUS
            , TYPE
            , MARKETING
            , PHONE
            , TAXWARE
            , ADDRESS tables.  

*******************************************************************************/

 IN_ROW_DATA  IN VARCHAR2);
 
 PROCEDURE BATCH_LOAD_PROCESS
/******************************************************************************
BATCH_LOAD_PROCESS

This procedure is the core process for the cost center bulk upload batch
that invokes all the 5 categories of cost center creations
Territory, Store, Administration, Real Estate and Other

******************************************************************************/
;
 END COST_CENTER_UPLOAD;
/

