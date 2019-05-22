  CREATE TABLE TEMP_FIX_NET_BAL
   (	customer_account_number VARCHAR2(9)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CSTMR_DPSTS_DATA_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
     fields terminated BY ','
            optionally enclosed BY '"'
            missing field VALUES are NULL)
      LOCATION
       ( 'Incorrect_Redemption.csv'
       )
    );