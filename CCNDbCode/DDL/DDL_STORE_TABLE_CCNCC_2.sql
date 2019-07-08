/********************************************************************************** 
This script is used to create a new column called
DESIGNATED_TERMINAL_NUMBER on the STORE Table.

Added similar Alter scripts for STORE_HST and ARC_STORE Tables

Created : 07/08/2019 axm868 CCN Project CCNCC-2....
Modified: 
**********************************************************************************/
SET DEFINE OFF;

ALTER TABLE STORE
  ADD DESIGNATED_TERMINAL_NUMBER VARCHAR2(5);  
  
ALTER TABLE STORE_HST
  ADD DESIGNATED_TERMINAL_NUMBER VARCHAR2(5);
  
ALTER TABLE ARC_STORE
  ADD DESIGNATED_TERMINAL_NUMBER VARCHAR2(5);