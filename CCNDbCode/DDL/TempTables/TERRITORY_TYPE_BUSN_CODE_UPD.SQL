/************************************************************************************************************
Script Name : TERRITORY_TYPE_BUSN_CODE_UPD.sql
Purpose     : For creating TERRITORY_TYPE_BUSN_CODE_UPD table.
              This is an external table which is used for storing data from TERRITORY_TYPE_BUSN_CODE_UPD.csv
              loaded through batch process.
Modified    : 06/27/2019 akj899 CCNCC-4 Project....
              Added field TERRITORY_TYP_OF_BUSN_SGMNT_CD
*************************************************************************************************************/
DROP TABLE TERRITORY_TYPE_BUSN_CODE_UPD;

CREATE TABLE TERRITORY_TYPE_BUSN_CODE_UPD
   (COST_CENTER_CODE         VARCHAR2(6), 
    TERRITORY_TYPE_BUSN_CODE VARCHAR2(2),
    TERRITORY_TYP_OF_BUSN_SGMNT_CD  VARCHAR2(2)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE SKIP 1 
       badfile "CCN_LOAD_FILES":'TERRITORY_TYPE_BUSN_CODE_UPD.bad' 
       logfile "CCN_LOAD_FILES":'TERRITORY_TYPE_BUSN_CODE_UPD.log' 
       FIELDS TERMINATED BY ',' 
       OPTIONALLY ENCLOSED BY '"' 
       LDRTRIM MISSING FIELD VALUES ARE NULL
       REJECT ROWS WITH ALL NULL FIELDS
       (COST_CENTER_CODE,TERRITORY_TYPE_BUSN_CODE,TERRITORY_TYP_OF_BUSN_SGMNT_CD)
          )
      LOCATION
       ( 'TERRITORY_TYPE_BUSN_CODE_UPD.csv'
       )
    )
   REJECT LIMIT UNLIMITED ;

