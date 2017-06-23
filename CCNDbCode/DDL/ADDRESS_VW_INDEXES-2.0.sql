/********************************************************************************************************************************************
Adding Non Unique Indexes on HOME STORE FIELD in DISPATCH_TERMINAL for Performance improvement of ADDRESS_VW
Task - ASP-765

Created : 06/21/2017 rxa457 CCN Project Team....
Changed :
********************************************************************************************************************************************/

CREATE INDEX DISPATCH_TERMINAL_NX01 ON DISPATCH_TERMINAL(HOME_STORE);


