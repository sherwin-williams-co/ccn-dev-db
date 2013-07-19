
-- Define TEMP_TAXWARE
-- Updated: tal 08/29/2012

DROP   TABLE "COSTCNTR"."TEMP_TAXWARE" ;

CREATE TABLE "COSTCNTR"."TEMP_TAXWARE"
  (
    cost_center_code           varchar2(06 byte) ,
    cost_center_code_old       varchar2(04 byte) ,
    twj_state                  varchar2(02 byte) ,
    twj_zip                    varchar2(10 byte) ,
    twj_geo                    varchar2(02 byte) ,
    twj_maintenance_date       varchar2(08 byte) ,
    twj_country                varchar2(02 byte) ,
    twj_company                varchar2(02 byte) 
  )  
  
ORGANIZATION EXTERNAL

  ( type oracle_loader default directory ccn_load_files access parameters 
  ( RECORDS FIXED 40

fields ( 
    cost_center_code           char(06) ,
    filler_01                  char(01) ,
    cost_center_code_old       char(04) ,
    filler_02                  char(01) ,
    twj_state                  char(02) ,
    twj_zip                    char(10) ,
    twj_geo                    char(02) ,
    twj_maintenance_date       char(08) ,
    twj_country                char(02) ,
    twj_company                char(02) ,
    end_marker_x               char(01) ,
    carr_return                char(01) 
)  
) 

location ( ccn_load_files: 'COSTCTR_DATASTAX.TXT' )

  )
  REJECT LIMIT 0