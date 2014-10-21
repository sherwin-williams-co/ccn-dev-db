
  CREATE TABLE TERRITORY_PH_UP
   (	"PHONE_NUMBER" VARCHAR2(14), 
	"CARRIER" VARCHAR2(20), 
	"USERNAME" VARCHAR2(8), 
	"EMAIL_ADD" VARCHAR2(22)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_DATAFILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE Skip 1
               badfile CCN_DATAFILES:'TERRITORY_PH_U_TM.bad'
               logfile CCN_DATAFILES:'TERRITORY_PH_U_TM.log'
               FIELDS TERMINATED BY ','
               MISSING FIELD VALUES ARE NULL 
               REJECT ROWS WITH ALL NULL FIELDS
               ( 
         PHONE_NUMBER Char(14), 
         CARRIER char(20), 
	       USERNAME char(8), 
	       EMAIL_ADD char (22)
         )        )
      LOCATION
       ( 'territory_phone.csv'
       )
    )
   REJECT LIMIT UNLIMITED ;



