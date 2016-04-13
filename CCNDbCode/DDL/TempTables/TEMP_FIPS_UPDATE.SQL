CREATE TABLE TEMP_FIPS_UPDATE
   (FIPS_CODE         VARCHAR2(10),
    "CATEGORY"        VARCHAR2(1),
    COST_CENTER_CODE  VARCHAR2(4),
    STORE_SUFF        VARCHAR2(1),
    COUNTY            VARCHAR2(16),
    CITY              VARCHAR2(16),
    "STATE"           VARCHAR2(2),
    ZIP_CODE          VARCHAR2(5),
    ZIP_SUFF          VARCHAR2(4))
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_DATAFILES"
      ACCESS PARAMETERS
      ( RECORDS delimited by NEWLINE
        badfile CCN_DATAFILES:'TEMP_FIPS_UPDATE.bad'
        logfile CCN_DATAFILES:'TEMP_FIPS_UPDATE.log'
        discardfile CCN_DATAFILES:'TEMP_FIPS_UPDATE.dsc'
          FIELDS
           (FIPS_CODE        POSITION(1:10)       CHAR(10),
            "CATEGORY"       POSITION(17:17)      CHAR(1),
            COST_CENTER_CODE POSITION(18:21)      CHAR(4),
            STORE_SUFF       POSITION(22:22)      CHAR(1),
            COUNTY           POSITION(25:40)      CHAR(16),
            CITY             POSITION(41:57)      CHAR(16),
            "STATE"          POSITION(57:58)      CHAR(2),
            ZIP_CODE         POSITION(65:69)      CHAR(5),
            ZIP_SUFF         POSITION(70:73)      CHAR(4))
            )
      LOCATION
       ('CCN_FIPS_USA_UPDATE.TXT'
        )
    );