CREATE TABLE TEMP_PCI_MID
   (COST_CENTER_CODE VARCHAR2(4),
    PCI_MERCHANT_ID	VARCHAR2(20))
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_DATAFILES"
      ACCESS PARAMETERS
      ( RECORDS delimited by NEWLINE
        skip 1
        badfile CCN_LOAD_FILES:'TEMP_PCI_MID.bad'
        logfile CCN_LOAD_FILES:'TEMP_PCI_MID.log'
        discardfile CCN_LOAD_FILES:'TEMP_PCI_MID.dsc'
        FIELDS TERMINATED BY ','
        MISSING FIELD VALUES ARE NULL
        (COST_CENTER_CODE     CHAR(4),
        PCI_MERCHANT_ID      CHAR(20)))
      LOCATION
       ('PAX_MID.csv'
       )
    );
