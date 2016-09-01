/*******************************************************************************
  Alter table script to add SPRAY_EQP_RPR_IND and BOOK_PLN_PROFILE_CD columns to cost center table.
  CREATED : 09/01/2016 axd783 CCN Project...
*******************************************************************************/
ALTER TABLE COST_CENTER
ADD (SPRAY_EQP_RPR_IND  VARCHAR2(1),
     BOOK_PLN_PROFILE_CD  VARCHAR2(2)
     );