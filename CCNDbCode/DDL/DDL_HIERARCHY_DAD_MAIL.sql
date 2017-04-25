
--script to create HIERARCHY_TRANSFER_MAIL table

CREATE TABLE HIERARCHY_TRANSFER_MAIL 
   (	
   /*****************************************************************************
   Created: 04/24/2012 pxb712 CCN Project.... 
   This table is used to store all the records related Hierarchy and Hierarchy DAD till 6.30PM batch email sent..
   **************************************************************************/
    PROCESS_NAME VARCHAR2(50), 
	HRCHY_DTL_PREV_LVL_FROM VARCHAR2(100), 
	HRCHY_DTL_PREV_LVL_TO VARCHAR2(100), 
	HRCHY_DTL_CURR_ROW_VAL VARCHAR2(100), 
	ENTRY_DATE DATE
   );
   
CREATE INDEX ENTRY_DATE_IDX ON HIERARCHY_TRANSFER_MAIL (ENTRY_DATE);


    
