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
 END COST_CENTER_UPLOAD;
/

