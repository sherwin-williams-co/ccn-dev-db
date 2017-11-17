/*******************************************************************************
This table is created for Royal bank Report Details
Created  : 11/16/2917 sxh487 CCN Project.
*******************************************************************************/
CREATE TABLE ROYAL_BANK_DTL_EXT_TBL 
   (	TRANSIT_NUMBER VARCHAR2(5), 
	ACCOUNT_NUMBER VARCHAR2(11), 
	TRANSIT_TYPE VARCHAR2(2), 
	SUB_CODE VARCHAR2(2), 
	SERIAL_NUMBER VARCHAR2(11), 
	AMOUNT VARCHAR2(11), 
	STATUS_FLAG VARCHAR2(1), 
	FILLER VARCHAR2(1), 
	ISSUE_DATE VARCHAR2(11), 
	PAID_DATE VARCHAR2(11), 
	TRANS_CODE VARCHAR2(4), 
	FILLER1 VARCHAR2(1), 
	CHECK_NUMBER VARCHAR2(11), 
	FILLER2 VARCHAR2(9), 
	STATUS VARCHAR2(2), 
	TOLRNC_AMOUNT VARCHAR2(3), 
	DESCRIPTION VARCHAR2(32), 
	DB_AMOUNT VARCHAR2(15)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY STORDRFT_DATAFILES
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile     STORDRFT_DATAFILES:'ROYAL_BANK_DTL_EXT_TBL.bad'
        logfile     STORDRFT_DATAFILES:'ROYAL_BANK_DTL_EXT_TBL.log'
        discardfile STORDRFT_DATAFILES:'ROYAL_BANK_DTL_EXT_TBL.dsc'
        LOAD WHEN ((13:14) ='10' OR (13:14) ='30' OR (13:14) ='60' OR (13:14) ='70')
        FIELDS MISSING FIELD VALUES ARE NULL
              (TRANSIT_NUMBER  CHAR(5),
               ACCOUNT_NUMBER  CHAR(7),
               TRANSIT_TYPE    CHAR(2),
               SUB_CODE        CHAR(2),
               SERIAL_NUMBER   CHAR(8),
               AMOUNT          CHAR(11),
               STATUS_FLAG     CHAR(1),
               FILLER          CHAR(1),
               ISSUE_DATE      CHAR(6),
               PAID_DATE       CHAR(6),
               TRANS_CODE      CHAR(3),
               FILLER1         CHAR(1),
               CHECK_NUMBER    CHAR(9),
               FILLER2         CHAR(9),
               STATUS          CHAR(2),
               TOLRNC_AMOUNT   CHAR(3),
               DESCRIPTION     POSITION(30:62)              CHAR(32),
               DB_AMOUNT       POSITION(64:79)              CHAR(15)
               )                )
      LOCATION
       ( 'DAREPORT.txt'
       )
    )
   REJECT LIMIT UNLIMITED ;