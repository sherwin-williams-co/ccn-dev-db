/*####################################################################
This scrit Removing PCI Terminal fields from CCN and all dependencies 

Created    : 01/23/2018 SXG151 CCN Team...

####################################################################*/

-- Dropping init load package for PCI fields and the temp table used there
DROP PACKAGE INITLOAD_PCI_ID;

drop table TEMP_PCI_MID_DID_INFO;
drop table TEMP_PCI_TERMINAL_INFO;
drop table PCI_TERMINAL_MAIL;

--Dropping these fields from Terminal table 
alter table
     TERMINAL
drop
    (PCI_TERMINAL_ID, PCI_VALUE_LINK_MID,PCI_VAL_LINK_ALT_MID);
	
