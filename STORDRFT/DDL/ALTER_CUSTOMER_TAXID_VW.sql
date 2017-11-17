/**********************************************************

Script Name: ALTER_CUSTOMER_TAXID_VW.sql
Description: Script to alter CUSTOMER_CCN_VW table to add ORA_COSTSNTR field
             since it is containing the same data as it is in CUSTOMER_TAXID_VW_COSTCNTR table

Created    : bxa919 11/17/2017

**********************************************************/
ALTER TABLE CUSTOMER_TAXID_VW
ADD ORA_COSTCTR  VARCHAR2(6 CHAR) ;
COMMIT;