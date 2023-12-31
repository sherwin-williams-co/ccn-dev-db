/*******************************************************************************
  The table is used to hold the tracking information of bag orders. 
		This is an external table and points tot he file bagordertracking.txt.
  CREATED : 06/21/2016 MXK766 CCN PROJECT....
  CHANGED : 
*******************************************************************************/
CREATE TABLE TEMP_BAGORDER_TRACKING
(
	ORDER_ID              VARCHAR2(100),
	ORDER_TRACKING_NUMBER VARCHAR2(100),
	EXTERNAL_ORDER_ID_GUI VARCHAR2(100)
)
ORGANIZATION EXTERNAL 
( 
TYPE ORACLE_LOADER
DEFAULT DIRECTORY "BANKING_LOAD_FILES"
ACCESS PARAMETERS
	(  
	RECORDS DELIMITED BY NEWLINE
	BADFILE BANKING_LOAD_FILES:'TEMP_BAGORDER_TRACKING.bad'
	DISCARDFILE BANKING_LOAD_FILES:'TEMP_BAGORDER_TRACKING.dis'
	LOGFILE BANKING_LOAD_FILES:'TEMP_BAGORDER_TRACKING.log'
	SKIP 1
	FIELDS TERMINATED BY ","  OPTIONALLY ENCLOSED BY '"'
	MISSING FIELD VALUES ARE NULL
		(
			ORDER_ID              CHAR(100),
			ORDER_TRACKING_NUMBER CHAR(100),
			EXTERNAL_ORDER_ID_GUI CHAR(100)
		) 
	)
LOCATION
	( 
		'bagordertracking.txt'
	)
);