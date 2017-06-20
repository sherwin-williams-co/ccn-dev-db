/********************************************************************************************************************************************
Adding Non Unique Indexes on cost center code field in ADDRESS_..tables and TERRITORY HOME STORE FIELD for Performance improvement of ADDRESS_VW
Task - ASP-804

Created : 06/13/2017 rxa457 CCN Project Team....
Changed :
********************************************************************************************************************************************/
CREATE INDEX ADDRESS_OTHER_NX01 ON ADDRESS_OTHER(COST_CENTER_CODE);
CREATE INDEX ADDRESS_USA_NX01 ON ADDRESS_USA(COST_CENTER_CODE);
CREATE INDEX ADDRESS_CAN_NX01 ON ADDRESS_CAN(COST_CENTER_CODE);
CREATE INDEX ADDRESS_MEX_NX01 ON ADDRESS_MEX(COST_CENTER_CODE);
CREATE INDEX ADDRESS_BRB_NX01 ON ADDRESS_BRB(COST_CENTER_CODE);

CREATE INDEX TERRITORY_NX01 ON TERRITORY(HOME_STORE);


