/*******************************************************************************************
Script Name : TEMP_ACH_DRFTS_EXT_CTRL.sql
Purpose     : For creating TEMP_ACH_DRFTS_EXT_CTRL table.
              This is an external table which is used for storing data from stores_ach.txt file
             loaded through batch process.

Created : 02/22/2019 pxa852 CCN Project Team....
********************************************************************************************/
DROP TABLE TEMP_ACH_DRFTS_EXT_CTRL;

CREATE TABLE TEMP_ACH_DRFTS_EXT_CTRL
   (COST_CENTER_CODE VARCHAR2(6),
    BANK_DEP_AMT     VARCHAR2(12),
    BANK_ACCOUNT_NBR VARCHAR2(25)
   )
   ORGANIZATION EXTERNAL
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "BANKING_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE
       badfile BANKING_LOAD_FILES:'TEMP_UAR_ACH.bad'
        logfile BANKING_LOAD_FILES:'TEMP_UAR_ACH.log'
        discardfile BANKING_LOAD_FILES:'TEMP_UAR_ACH.dsc'
        LOAD WHEN ((1:2) = '62')
         FIELDS missing field values are null
         (COST_CENTER_CODE POSITION(40:46)   CHAR(6),
          BANK_DEP_AMT     POSITION(30:40)   CHAR(10),
          BANK_ACCOUNT_NBR POSITION(13:29)   CHAR(17))
                        )
      LOCATION
       ( 'stores_ach.txt'
       )
    );