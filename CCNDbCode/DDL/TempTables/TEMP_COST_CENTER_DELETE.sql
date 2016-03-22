CREATE TABLE TEMP_COST_CENTER_DELETE 
       (COST_CENTER_CODE VARCHAR2(6)
       ) 
       ORGANIZATION EXTERNAL 
        ( TYPE ORACLE_LOADER
          DEFAULT DIRECTORY CCN_DATAFILES
          ACCESS PARAMETERS
          ( records delimited by newline SKIP 1
          badfile "CCN_LOAD_FILES":'COST_CENTER_DELETE.bad'
          logfile "CCN_LOAD_FILES":'COST_CENTER_DELETE.log'
             FIELDS TERMINATED BY ',' 
             LRTRIM
             missing field values are null 
             ( 
               COST_CENTER_CODE
             ) 
                           )
          LOCATION
           ( 'COST_CENTER_DELETE.csv'
           )
        );