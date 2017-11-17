/*******************************************************************************
This table is created for Royal bank Report Debit and cash adjustments
Created  : 11/16/2917 sxh487 CCN Project.
*******************************************************************************/
CREATE TABLE ROYAL_BANK_DEBITS_EXT_TBL 
   (  TRANSIT_NUMBER VARCHAR2(5), 
      ACCOUNT_NUMBER VARCHAR2(11), 
      TRANSIT_TYPE VARCHAR2(2), 
      DESCRIPTION VARCHAR2(32), 
      DB_AMOUNT VARCHAR2(15)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY STORDRFT_DATAFILES
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
        badfile     STORDRFT_DATAFILES:'ROYAL_BANK_DEBITS_EXT_TBL.bad'
        logfile     STORDRFT_DATAFILES:'ROYAL_BANK_DEBITS_EXT_TBL.log'
        discardfile STORDRFT_DATAFILES:'ROYAL_BANK_DEBITS_EXT_TBL.dsc'
        LOAD WHEN ((13:14) ='05')
        FIELDS MISSING FIELD VALUES ARE NULL
              (TRANSIT_NUMBER  CHAR(5),
               ACCOUNT_NUMBER  CHAR(7),
               TRANSIT_TYPE    CHAR(2),
               DESCRIPTION     POSITION(30:62)              CHAR(32),
               DB_AMOUNT       POSITION(64:79)              CHAR(15)
               )                )
      LOCATION
       ( 'DAREPORT.txt'
       )
    )
   REJECT LIMIT UNLIMITED ;