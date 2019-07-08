/********************************************************************************** 
This script is used to create a new column called
DESIGNATED_TERMINAL_NUMBER on the STORE Table.

Created : 07/08/2019 axm868 CCN Project CCNCC-2....
Modified: 
**********************************************************************************/
SET DEFINE OFF;

ALTER TABLE STORE
  ADD DESIGNATED_TERMINAL_NUMBER VARCHAR2(5);