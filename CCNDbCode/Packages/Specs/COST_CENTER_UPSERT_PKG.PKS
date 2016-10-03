create or replace PACKAGE COST_CENTER_UPSERT_PKG AS 
PROCEDURE CC_UPSERT_PROCESS( 
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
Changed: 10/03/2016 MXR916 CCN Project
         Added Input Parameter IN_OVERWRITE_FLAG with default value as N 

*******************************************************************************/

 IN_ROW_DATA         IN VARCHAR2,
 IN_OVERWRITE_FLAG   IN varchar2 default 'N');

 END COST_CENTER_UPSERT_PKG;
 
 