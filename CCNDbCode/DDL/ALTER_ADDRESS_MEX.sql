
/*******************************************************************************
  Alter table script to modify data size ADDRESS_LINE_1, ADDRESS_LINE_2 and ADDRESS_LINE_3 columns of ADDRESS_MEX table.
  CREATED : 03/12/2018 nxk927783 CCN Project...
*******************************************************************************/

ALTER TABLE ADDRESS_MEX
MODIFY (ADDRESS_LINE_1 VARCHAR2(75),
        ADDRESS_LINE_2 VARCHAR2(75),
        ADDRESS_LINE_3 VARCHAR2(75));