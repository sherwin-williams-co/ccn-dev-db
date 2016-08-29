/*******************************************************************************
  Alter table script to add the temporary closed reason code column in cost center table.
  CREATED : 08/08/2016 mxk766 CCN Project
  CHANGED : 
*******************************************************************************/

ALTER TABLE COST_CENTER ADD CC_TEMP_CLOSED_CD VARCHAR2(2); 