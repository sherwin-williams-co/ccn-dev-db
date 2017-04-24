--Drop if table already exists

DROP TABLE PCI_TERMINAL_MAIL;
DROP TABLE HIERARCHY_TRANSFER_MAIL;

--script to create PCI_TERMINAL_MAIL table

CREATE TABLE "COSTCNTR"."PCI_TERMINAL_MAIL" 
   (	
   /*****************************************************************************
   Created: 04/24/2012 pxb712 CCN Project.... This table is used to store all the records regarding PCI till 6.30PM batch email sent..
   **************************************************************************/
    "COST_CENTER_CODE" VARCHAR2(6), 
	"TERMINAL_NUMBER" VARCHAR2(5), 
	"ENTRY_DATE" DATE, 
	"PCI_TERMINAL_ID" VARCHAR2(50)
   );

  
--script to create HIERARCHY_TRANSFER_MAIL table

CREATE TABLE "COSTCNTR"."HIERARCHY_TRANSFER_MAIL" 
   (	
   /*****************************************************************************
   Created: 04/24/2012 pxb712 CCN Project.... This table is used to store all the records related Hierarchy and Hierarchy DAD till 6.30PM batch email sent..
   **************************************************************************/
    "PROCESS_NAME" VARCHAR2(50), 
	"HRCHY_DTL_PREV_LVL_FROM" VARCHAR2(100), 
	"HRCHY_DTL_PREV_LVL_TO" VARCHAR2(100), 
	"HRCHY_DTL_CURR_ROW_VAL" VARCHAR2(100), 
	"ENTRY_DATE" DATE
   );

