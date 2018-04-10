/*******************************************************************************
  Alter table script to add POTENTIAL_OPEN_DATE  columns to STORE table.
  CREATED : 04/04/2018 bxa919 CCN Project...
*******************************************************************************/

--Deleting the POTENTIAL_OPEN_DATE column from COST_CENTER table .
Alter table COST_CENTER DROP COLUMN POTENTIAL_OPEN_DATE;

--Adding the POTENTIAL_OPEN_DATE column in STORE table. 
ALTER TABLE STORE ADD POTENTIAL_OPEN_DATE DATE;



