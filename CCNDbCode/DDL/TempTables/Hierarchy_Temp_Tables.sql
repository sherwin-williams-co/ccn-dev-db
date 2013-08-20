-- create the external table for Hierarchy loading a change
CREATE TABLE ADMIN_SALES_AREA_EXT_DETAIL
                   ( HRCHY_HDR_NAME         VARCHAR2(100),
    		     HRCHY_DTL_LEVEL        VARCHAR2(2),
    		     HRCHY_DTL_PREV_LVL_VAL VARCHAR2(1000),
    	             HRCHY_DTL_CURR_LVL_VAL VARCHAR2(1000),
    		     HRCHY_DTL_NEXT_LVL_VAL VARCHAR2(1000),
    		     HRCHY_DTL_EFF_DATE     DATE,
    		     HRCHY_DTL_EXP_DATE     DATE,
    		     HRCHY_DTL_DESC         VARCHAR2(100),
                     UPPER_LVL_VER_VALUE    VARCHAR2(1000)
                   ) 
     ORGANIZATION EXTERNAL 
     ( 
       TYPE ORACLE_LOADER 
       DEFAULT DIRECTORY ccn_datafiles
       ACCESS PARAMETERS 
       ( 
         records delimited by newline 
         FIELDS TERMINATED BY '~' 
         LRTRIM
         missing field values are null 
         ( 
           HRCHY_HDR_NAME,
	   HRCHY_DTL_LEVEL,
	   HRCHY_DTL_PREV_LVL_VAL,
	   HRCHY_DTL_CURR_LVL_VAL,
	   HRCHY_DTL_NEXT_LVL_VAL,
	   HRCHY_DTL_EFF_DATE DATE 'YYYYMMDD',
	   HRCHY_DTL_EXP_DATE DATE 'YYYYMMDD',
	   HRCHY_DTL_DESC,
           UPPER_LVL_VER_VALUE
         ) 
       ) 
       LOCATION ('admin_to_sales_area.txt') 
     ) 
     PARALLEL 
     REJECT LIMIT UNLIMITED; 

-- create the external table for Hierarchy loading
CREATE TABLE ADMIN_SALES_DIST_EXT_DETAIL
                   ( HRCHY_HDR_NAME         VARCHAR2(100),
    		     HRCHY_DTL_LEVEL        VARCHAR2(2),
    		     HRCHY_DTL_PREV_LVL_VAL VARCHAR2(1000),
    	             HRCHY_DTL_CURR_LVL_VAL VARCHAR2(1000),
    		     HRCHY_DTL_NEXT_LVL_VAL VARCHAR2(1000),
    		     HRCHY_DTL_EFF_DATE     DATE,
    		     HRCHY_DTL_EXP_DATE     DATE,
    		     HRCHY_DTL_DESC         VARCHAR2(100),
                     UPPER_LVL_VER_VALUE    VARCHAR2(1000)
                   ) 
     ORGANIZATION EXTERNAL 
     ( 
       TYPE ORACLE_LOADER 
       DEFAULT DIRECTORY ccn_datafiles
       ACCESS PARAMETERS 
       ( 
         records delimited by newline 
         FIELDS TERMINATED BY '~' 
         LRTRIM
         missing field values are null 
         ( 
           HRCHY_HDR_NAME,
	   HRCHY_DTL_LEVEL,
	   HRCHY_DTL_PREV_LVL_VAL,
	   HRCHY_DTL_CURR_LVL_VAL,
	   HRCHY_DTL_NEXT_LVL_VAL,
	   HRCHY_DTL_EFF_DATE DATE 'YYYYMMDD',
	   HRCHY_DTL_EXP_DATE DATE 'YYYYMMDD',
	   HRCHY_DTL_DESC,
           UPPER_LVL_VER_VALUE
         ) 
       ) 
       LOCATION ('admin_to_sales_district.txt') 
     ) 
     PARALLEL 
     REJECT LIMIT UNLIMITED; 

-- create the external table for Hierarchy loading
CREATE TABLE ADMIN_SALES_DIV_EXT_DETAIL
                   ( HRCHY_HDR_NAME         VARCHAR2(100),
    		     HRCHY_DTL_LEVEL        VARCHAR2(2),
    		     HRCHY_DTL_PREV_LVL_VAL VARCHAR2(1000),
    	             HRCHY_DTL_CURR_LVL_VAL VARCHAR2(1000),
    		     HRCHY_DTL_NEXT_LVL_VAL VARCHAR2(1000),
    		     HRCHY_DTL_EFF_DATE     DATE,
    		     HRCHY_DTL_EXP_DATE     DATE,
    		     HRCHY_DTL_DESC         VARCHAR2(100),
                     UPPER_LVL_VER_VALUE    VARCHAR2(1000)
                   ) 
     ORGANIZATION EXTERNAL 
     ( 
       TYPE ORACLE_LOADER 
       DEFAULT DIRECTORY ccn_datafiles
       ACCESS PARAMETERS 
       ( 
         records delimited by newline 
         FIELDS TERMINATED BY '~' 
         LRTRIM
         missing field values are null 
         ( 
           HRCHY_HDR_NAME,
	   HRCHY_DTL_LEVEL,
	   HRCHY_DTL_PREV_LVL_VAL,
	   HRCHY_DTL_CURR_LVL_VAL,
	   HRCHY_DTL_NEXT_LVL_VAL,
	   HRCHY_DTL_EFF_DATE DATE 'YYYYMMDD',
	   HRCHY_DTL_EXP_DATE DATE 'YYYYMMDD',
	   HRCHY_DTL_DESC,
           UPPER_LVL_VER_VALUE
         ) 
       ) 
       LOCATION ('admin_to_sales_division.txt') 
     ) 
     PARALLEL 
     REJECT LIMIT UNLIMITED; 

-- create the external table for Hierarchy loading
CREATE TABLE ADMIN_SALES_DIV_EXT_DETAIL
                   ( HRCHY_HDR_NAME         VARCHAR2(100),
    		     HRCHY_DTL_LEVEL        VARCHAR2(2),
    		     HRCHY_DTL_PREV_LVL_VAL VARCHAR2(1000),
    	             HRCHY_DTL_CURR_LVL_VAL VARCHAR2(1000),
    		     HRCHY_DTL_NEXT_LVL_VAL VARCHAR2(1000),
    		     HRCHY_DTL_EFF_DATE     DATE,
    		     HRCHY_DTL_EXP_DATE     DATE,
    		     HRCHY_DTL_DESC         VARCHAR2(100),
                     UPPER_LVL_VER_VALUE    VARCHAR2(1000)
                   ) 
     ORGANIZATION EXTERNAL 
     ( 
       TYPE ORACLE_LOADER 
       DEFAULT DIRECTORY ccn_datafiles
       ACCESS PARAMETERS 
       ( 
         records delimited by newline 
         FIELDS TERMINATED BY '~' 
         LRTRIM
         missing field values are null 
         ( 
           HRCHY_HDR_NAME,
	   HRCHY_DTL_LEVEL,
	   HRCHY_DTL_PREV_LVL_VAL,
	   HRCHY_DTL_CURR_LVL_VAL,
	   HRCHY_DTL_NEXT_LVL_VAL,
	   HRCHY_DTL_EFF_DATE DATE 'YYYYMMDD',
	   HRCHY_DTL_EXP_DATE DATE 'YYYYMMDD',
	   HRCHY_DTL_DESC,
           UPPER_LVL_VER_VALUE
         ) 
       ) 
       LOCATION ('admin_to_sales_division.txt') 
     ) 
     PARALLEL 
     REJECT LIMIT UNLIMITED; 

-- create the external table for Hierarchy loading
CREATE TABLE ADMIN_SALES_DIV_EXT_DETAIL
                   ( HRCHY_HDR_NAME         VARCHAR2(100),
    		     HRCHY_DTL_LEVEL        VARCHAR2(2),
    		     HRCHY_DTL_PREV_LVL_VAL VARCHAR2(1000),
    	             HRCHY_DTL_CURR_LVL_VAL VARCHAR2(1000),
    		     HRCHY_DTL_NEXT_LVL_VAL VARCHAR2(1000),
    		     HRCHY_DTL_EFF_DATE     DATE,
    		     HRCHY_DTL_EXP_DATE     DATE,
    		     HRCHY_DTL_DESC         VARCHAR2(100),
                     UPPER_LVL_VER_VALUE    VARCHAR2(1000)
                   ) 
     ORGANIZATION EXTERNAL 
     ( 
       TYPE ORACLE_LOADER 
       DEFAULT DIRECTORY ccn_datafiles
       ACCESS PARAMETERS 
       ( 
         records delimited by newline 
         FIELDS TERMINATED BY '~' 
         LRTRIM
         missing field values are null 
         ( 
           HRCHY_HDR_NAME,
	   HRCHY_DTL_LEVEL,
	   HRCHY_DTL_PREV_LVL_VAL,
	   HRCHY_DTL_CURR_LVL_VAL,
	   HRCHY_DTL_NEXT_LVL_VAL,
	   HRCHY_DTL_EFF_DATE DATE 'YYYYMMDD',
	   HRCHY_DTL_EXP_DATE DATE 'YYYYMMDD',
	   HRCHY_DTL_DESC,
           UPPER_LVL_VER_VALUE
         ) 
       ) 
       LOCATION ('admin_to_sales_division.txt') 
     ) 
     PARALLEL 
     REJECT LIMIT UNLIMITED; 

-- create the external table for Hierarchy loading
CREATE TABLE ALTERNATE_DAD_EXT_DETAIL
                   ( HRCHY_HDR_NAME         VARCHAR2(100),
    		     HRCHY_DTL_LEVEL        VARCHAR2(2),
    		     HRCHY_DTL_PREV_LVL_VAL VARCHAR2(1000),
    	             HRCHY_DTL_CURR_LVL_VAL VARCHAR2(1000),
    		     HRCHY_DTL_NEXT_LVL_VAL VARCHAR2(1000),
    		     HRCHY_DTL_EFF_DATE     DATE,
    		     HRCHY_DTL_EXP_DATE     DATE,
    		     HRCHY_DTL_DESC         varchar2(100),
                     UPPER_LVL_VER_VALUE    VARCHAR2(1000)
                   ) 
     ORGANIZATION EXTERNAL 
     ( 
       TYPE ORACLE_LOADER 
       DEFAULT DIRECTORY ccn_datafiles
       ACCESS PARAMETERS 
       ( 
         records delimited by newline 
         FIELDS TERMINATED BY '~' 
         LRTRIM
         missing field values are null 
         ( 
           HRCHY_HDR_NAME,
	   HRCHY_DTL_LEVEL,
	   HRCHY_DTL_PREV_LVL_VAL,
	   HRCHY_DTL_CURR_LVL_VAL,
	   HRCHY_DTL_NEXT_LVL_VAL,
	   HRCHY_DTL_EFF_DATE DATE 'YYYYMMDD',
	   HRCHY_DTL_EXP_DATE DATE 'YYYYMMDD',
	   HRCHY_DTL_DESC,
           UPPER_LVL_VER_VALUE
         ) 
       ) 
       LOCATION ('alternate_dad.txt') 
     ) 
     PARALLEL 
     REJECT LIMIT UNLIMITED;

-- create the external table for Hierarchy loading
CREATE TABLE CITY_MANAGER_DAD_EXT_DETAIL
                   ( HRCHY_HDR_NAME         VARCHAR2(100),
    		     HRCHY_DTL_LEVEL        VARCHAR2(2),
    		     HRCHY_DTL_PREV_LVL_VAL VARCHAR2(1000),
    	             HRCHY_DTL_CURR_LVL_VAL VARCHAR2(1000),
    		     HRCHY_DTL_NEXT_LVL_VAL VARCHAR2(1000),
    		     HRCHY_DTL_EFF_DATE     DATE,
    		     HRCHY_DTL_EXP_DATE     DATE,
    		     HRCHY_DTL_DESC         varchar2(100),
                     UPPER_LVL_VER_VALUE    VARCHAR2(1000)
                   ) 
     ORGANIZATION EXTERNAL 
     ( 
       TYPE ORACLE_LOADER 
       DEFAULT DIRECTORY ccn_datafiles
       ACCESS PARAMETERS 
       ( 
         records delimited by newline 
         FIELDS TERMINATED BY '~' 
         LRTRIM
         missing field values are null 
         ( 
           HRCHY_HDR_NAME,
	   HRCHY_DTL_LEVEL,
	   HRCHY_DTL_PREV_LVL_VAL,
	   HRCHY_DTL_CURR_LVL_VAL,
	   HRCHY_DTL_NEXT_LVL_VAL,
	   HRCHY_DTL_EFF_DATE DATE 'YYYYMMDD',
	   HRCHY_DTL_EXP_DATE DATE 'YYYYMMDD',
	   HRCHY_DTL_DESC,
           UPPER_LVL_VER_VALUE
         ) 
       ) 
       LOCATION ('city_manager_dad.txt') 
     ) 
     PARALLEL 
     REJECT LIMIT UNLIMITED; 

-- create the external table for Hierarchy loading
CREATE TABLE FACTS_DIVISION_EXT_DETAIL
                   ( HRCHY_HDR_NAME         VARCHAR2(20),
    		     HRCHY_DTL_LEVEL        VARCHAR2(2),
    		     HRCHY_DTL_PREV_LVL_VAL VARCHAR2(1000),
    	             HRCHY_DTL_CURR_LVL_VAL VARCHAR2(1000),
    		     HRCHY_DTL_NEXT_LVL_VAL VARCHAR2(1000),
    		     HRCHY_DTL_EFF_DATE     DATE,
    		     HRCHY_DTL_EXP_DATE     DATE,
    		     HRCHY_DTL_DESC         VARCHAR2(100),
    		     UPPER_LVL_VER_VALUE    VARCHAR2(1000)
                   ) 
     ORGANIZATION EXTERNAL 
     ( 
       TYPE ORACLE_LOADER 
       DEFAULT DIRECTORY ccn_datafiles
       ACCESS PARAMETERS 
       ( 
         records delimited by newline 
         FIELDS TERMINATED BY '~' 
         LRTRIM
         missing field values are null 
         ( 
           HRCHY_HDR_NAME,
	   HRCHY_DTL_LEVEL,
	   HRCHY_DTL_PREV_LVL_VAL,
	   HRCHY_DTL_CURR_LVL_VAL,
	   HRCHY_DTL_NEXT_LVL_VAL,
	   HRCHY_DTL_EFF_DATE DATE 'YYYYMMDD',
	   HRCHY_DTL_EXP_DATE DATE 'YYYYMMDD',
	   HRCHY_DTL_DESC,
	   UPPER_LVL_VER_VALUE 
         ) 
       ) 
       LOCATION ('facts_division.txt') 
     ) 
     PARALLEL 
     REJECT LIMIT UNLIMITED; 

-- create the external table for Hierarchy loading
CREATE TABLE GLOBAL_HIERARCHY_EXT_DETAIL
                   ( HRCHY_HDR_NAME         VARCHAR2(100),
    		     HRCHY_DTL_LEVEL        VARCHAR2(2),
    		     HRCHY_DTL_PREV_LVL_VAL VARCHAR2(1000),
    	             HRCHY_DTL_CURR_LVL_VAL VARCHAR2(1000),
    		     HRCHY_DTL_NEXT_LVL_VAL VARCHAR2(1000),
    		     HRCHY_DTL_EFF_DATE     DATE,
    		     HRCHY_DTL_EXP_DATE     DATE,
    		     HRCHY_DTL_DESC         varchar2(100),
                     UPPER_LVL_VER_VALUE    VARCHAR2(1000)
                   ) 
     ORGANIZATION EXTERNAL 
     ( 
       TYPE ORACLE_LOADER 
       DEFAULT DIRECTORY ccn_datafiles
       ACCESS PARAMETERS 
       ( 
         records delimited by newline 
         FIELDS TERMINATED BY '~' 
         LRTRIM
         missing field values are null 
         ( 
           HRCHY_HDR_NAME,
	   HRCHY_DTL_LEVEL,
	   HRCHY_DTL_PREV_LVL_VAL,
	   HRCHY_DTL_CURR_LVL_VAL,
	   HRCHY_DTL_NEXT_LVL_VAL,
	   HRCHY_DTL_EFF_DATE DATE 'YYYYMMDD',
	   HRCHY_DTL_EXP_DATE DATE 'YYYYMMDD',
	   HRCHY_DTL_DESC,
           UPPER_LVL_VER_VALUE
         ) 
       ) 
       LOCATION ('global_hierarchy.txt') 
     ) 
     PARALLEL 
     REJECT LIMIT UNLIMITED; 

-- create the external table for Hierarchy loading
CREATE TABLE LEGACY_GL_DIVISION_EXT_DETAIL
                   ( HRCHY_HDR_NAME         VARCHAR2(20),
    		     HRCHY_DTL_LEVEL        VARCHAR2(2),
    		     HRCHY_DTL_PREV_LVL_VAL VARCHAR2(1000),
    	             HRCHY_DTL_CURR_LVL_VAL VARCHAR2(1000),
    		     HRCHY_DTL_NEXT_LVL_VAL VARCHAR2(1000),
    		     HRCHY_DTL_EFF_DATE     DATE,
    		     HRCHY_DTL_EXP_DATE     DATE,
    		     HRCHY_DTL_DESC         VARCHAR2(100),
    		     UPPER_LVL_VER_VALUE    VARCHAR2(1000)
                   ) 
     ORGANIZATION EXTERNAL 
     ( 
       TYPE ORACLE_LOADER 
       DEFAULT DIRECTORY ccn_datafiles
       ACCESS PARAMETERS 
       ( 
         records delimited by newline 
         FIELDS TERMINATED BY '~' 
         LRTRIM
         missing field values are null 
         ( 
           HRCHY_HDR_NAME,
	   HRCHY_DTL_LEVEL,
	   HRCHY_DTL_PREV_LVL_VAL,
	   HRCHY_DTL_CURR_LVL_VAL,
	   HRCHY_DTL_NEXT_LVL_VAL,
	   HRCHY_DTL_EFF_DATE DATE 'YYYYMMDD',
	   HRCHY_DTL_EXP_DATE DATE 'YYYYMMDD',
	   HRCHY_DTL_DESC,
	   UPPER_LVL_VER_VALUE 
         ) 
       ) 
       LOCATION ('legacy_gl_division.txt') 
     ) 
     PARALLEL 
     REJECT LIMIT UNLIMITED; 



  CREATE TABLE "COSTCNTR"."GLOBAL_HIERARCHY_EXT_DETAIL_T" 
   (	"HRCHY_HDR_NAME" VARCHAR2(100 BYTE), 
	"HRCHY_DTL_LEVEL" VARCHAR2(2 BYTE), 
	"HRCHY_DTL_PREV_LVL_VAL" VARCHAR2(1000 BYTE), 
	"HRCHY_DTL_CURR_LVL_VAL" VARCHAR2(1000 BYTE), 
	"HRCHY_DTL_NEXT_LVL_VAL" VARCHAR2(1000 BYTE), 
	"HRCHY_DTL_EFF_DATE" DATE, 
	"HRCHY_DTL_EXP_DATE" DATE, 
	"HRCHY_DTL_DESC" VARCHAR2(100 BYTE), 
	"UPPER_LVL_VER_VALUE" VARCHAR2(1000 BYTE)
   );
  CREATE INDEX "COSTCNTR"."INDEX1_TEMP1" ON "COSTCNTR"."GLOBAL_HIERARCHY_EXT_DETAIL_T" ("HRCHY_HDR_NAME", "HRCHY_DTL_LEVEL", "HRCHY_DTL_CURR_LVL_VAL") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "COSTCNTR_DATA" ;

  CREATE TABLE "COSTCNTR"."ADMIN_SALES_DIV_EXT_DETAIL_T" 
   (	"HRCHY_HDR_NAME" VARCHAR2(100 BYTE), 
	"HRCHY_DTL_LEVEL" VARCHAR2(2 BYTE), 
	"HRCHY_DTL_PREV_LVL_VAL" VARCHAR2(1000 BYTE), 
	"HRCHY_DTL_CURR_LVL_VAL" VARCHAR2(1000 BYTE), 
	"HRCHY_DTL_NEXT_LVL_VAL" VARCHAR2(1000 BYTE), 
	"HRCHY_DTL_EFF_DATE" DATE, 
	"HRCHY_DTL_EXP_DATE" DATE, 
	"HRCHY_DTL_DESC" VARCHAR2(100 BYTE), 
	"UPPER_LVL_VER_VALUE" VARCHAR2(1000 BYTE)
   );
  CREATE INDEX "COSTCNTR"."INDEX1_TEMP2" ON "COSTCNTR"."ADMIN_SALES_DIV_EXT_DETAIL_T" ("HRCHY_HDR_NAME", "HRCHY_DTL_LEVEL", "HRCHY_DTL_CURR_LVL_VAL") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "COSTCNTR_DATA" ;
  
    CREATE TABLE "COSTCNTR"."ADMIN_SALES_AREA_EXT_DETAIL_T" 
     (	"HRCHY_HDR_NAME" VARCHAR2(100 BYTE), 
  	"HRCHY_DTL_LEVEL" VARCHAR2(2 BYTE), 
  	"HRCHY_DTL_PREV_LVL_VAL" VARCHAR2(1000 BYTE), 
  	"HRCHY_DTL_CURR_LVL_VAL" VARCHAR2(1000 BYTE), 
  	"HRCHY_DTL_NEXT_LVL_VAL" VARCHAR2(1000 BYTE), 
  	"HRCHY_DTL_EFF_DATE" DATE, 
  	"HRCHY_DTL_EXP_DATE" DATE, 
  	"HRCHY_DTL_DESC" VARCHAR2(100 BYTE), 
  	"UPPER_LVL_VER_VALUE" VARCHAR2(1000 BYTE)
     );
    CREATE INDEX "COSTCNTR"."INDEX1_TEMP3" ON "COSTCNTR"."ADMIN_SALES_AREA_EXT_DETAIL_T" ("HRCHY_HDR_NAME", "HRCHY_DTL_LEVEL", "HRCHY_DTL_CURR_LVL_VAL") 
    PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "COSTCNTR_DATA" ;
  
    CREATE TABLE "COSTCNTR"."ADMIN_SALES_DIST_EXT_DETAIL_T" 
     (	"HRCHY_HDR_NAME" VARCHAR2(100 BYTE), 
  	"HRCHY_DTL_LEVEL" VARCHAR2(2 BYTE), 
  	"HRCHY_DTL_PREV_LVL_VAL" VARCHAR2(1000 BYTE), 
  	"HRCHY_DTL_CURR_LVL_VAL" VARCHAR2(1000 BYTE), 
  	"HRCHY_DTL_NEXT_LVL_VAL" VARCHAR2(1000 BYTE), 
  	"HRCHY_DTL_EFF_DATE" DATE, 
  	"HRCHY_DTL_EXP_DATE" DATE, 
  	"HRCHY_DTL_DESC" VARCHAR2(100 BYTE), 
  	"UPPER_LVL_VER_VALUE" VARCHAR2(1000 BYTE)
     );
    CREATE INDEX "COSTCNTR"."INDEX1_TEMP4" ON "COSTCNTR"."ADMIN_SALES_DIST_EXT_DETAIL_T" ("HRCHY_HDR_NAME", "HRCHY_DTL_LEVEL", "HRCHY_DTL_CURR_LVL_VAL") 
    PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "COSTCNTR_DATA" ;
  
    CREATE TABLE "COSTCNTR"."LEGACY_GL_DIVISION_EXT_DTL_T" 
     (	"HRCHY_HDR_NAME" VARCHAR2(100 BYTE), 
  	"HRCHY_DTL_LEVEL" VARCHAR2(2 BYTE), 
  	"HRCHY_DTL_PREV_LVL_VAL" VARCHAR2(1000 BYTE), 
  	"HRCHY_DTL_CURR_LVL_VAL" VARCHAR2(1000 BYTE), 
  	"HRCHY_DTL_NEXT_LVL_VAL" VARCHAR2(1000 BYTE), 
  	"HRCHY_DTL_EFF_DATE" DATE, 
  	"HRCHY_DTL_EXP_DATE" DATE, 
  	"HRCHY_DTL_DESC" VARCHAR2(100 BYTE), 
  	"UPPER_LVL_VER_VALUE" VARCHAR2(1000 BYTE)
     );
    CREATE INDEX "COSTCNTR"."INDEX1_TEMP5" ON "COSTCNTR"."LEGACY_GL_DIVISION_EXT_DTL_T" ("HRCHY_HDR_NAME", "HRCHY_DTL_LEVEL", "HRCHY_DTL_CURR_LVL_VAL") 
    PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "COSTCNTR_DATA" ;
  
    CREATE TABLE "COSTCNTR"."ALTERNATE_DAD_EXT_DETAIL_T" 
     (	"HRCHY_HDR_NAME" VARCHAR2(100 BYTE), 
  	"HRCHY_DTL_LEVEL" VARCHAR2(2 BYTE), 
  	"HRCHY_DTL_PREV_LVL_VAL" VARCHAR2(1000 BYTE), 
  	"HRCHY_DTL_CURR_LVL_VAL" VARCHAR2(1000 BYTE), 
  	"HRCHY_DTL_NEXT_LVL_VAL" VARCHAR2(1000 BYTE), 
  	"HRCHY_DTL_EFF_DATE" DATE, 
  	"HRCHY_DTL_EXP_DATE" DATE, 
  	"HRCHY_DTL_DESC" VARCHAR2(100 BYTE), 
  	"UPPER_LVL_VER_VALUE" VARCHAR2(1000 BYTE)
     );
    CREATE INDEX "COSTCNTR"."INDEX1_TEMP6" ON "COSTCNTR"."ALTERNATE_DAD_EXT_DETAIL_T" ("HRCHY_HDR_NAME", "HRCHY_DTL_LEVEL", "HRCHY_DTL_CURR_LVL_VAL") 
    PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "COSTCNTR_DATA" ;
  
    CREATE TABLE "COSTCNTR"."CITY_MANAGER_DAD_EXT_DETAIL_T" 
     (	"HRCHY_HDR_NAME" VARCHAR2(100 BYTE), 
  	"HRCHY_DTL_LEVEL" VARCHAR2(2 BYTE), 
  	"HRCHY_DTL_PREV_LVL_VAL" VARCHAR2(1000 BYTE), 
  	"HRCHY_DTL_CURR_LVL_VAL" VARCHAR2(1000 BYTE), 
  	"HRCHY_DTL_NEXT_LVL_VAL" VARCHAR2(1000 BYTE), 
  	"HRCHY_DTL_EFF_DATE" DATE, 
  	"HRCHY_DTL_EXP_DATE" DATE, 
  	"HRCHY_DTL_DESC" VARCHAR2(100 BYTE), 
  	"UPPER_LVL_VER_VALUE" VARCHAR2(1000 BYTE)
     );
    CREATE INDEX "COSTCNTR"."INDEX1_TEMP7" ON "COSTCNTR"."CITY_MANAGER_DAD_EXT_DETAIL_T" ("HRCHY_HDR_NAME", "HRCHY_DTL_LEVEL", "HRCHY_DTL_CURR_LVL_VAL") 
    PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "COSTCNTR_DATA" ;
  
    CREATE TABLE "COSTCNTR"."FACTS_DIVISION_EXT_DETAIL_T" 
     (	"HRCHY_HDR_NAME" VARCHAR2(100 BYTE), 
  	"HRCHY_DTL_LEVEL" VARCHAR2(2 BYTE), 
  	"HRCHY_DTL_PREV_LVL_VAL" VARCHAR2(1000 BYTE), 
  	"HRCHY_DTL_CURR_LVL_VAL" VARCHAR2(1000 BYTE), 
  	"HRCHY_DTL_NEXT_LVL_VAL" VARCHAR2(1000 BYTE), 
  	"HRCHY_DTL_EFF_DATE" DATE, 
  	"HRCHY_DTL_EXP_DATE" DATE, 
  	"HRCHY_DTL_DESC" VARCHAR2(100 BYTE), 
  	"UPPER_LVL_VER_VALUE" VARCHAR2(1000 BYTE)
     );
    CREATE INDEX "COSTCNTR"."INDEX1_TEMP8" ON "COSTCNTR"."FACTS_DIVISION_EXT_DETAIL_T" ("HRCHY_HDR_NAME", "HRCHY_DTL_LEVEL", "HRCHY_DTL_CURR_LVL_VAL") 
    PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
    STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
    PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "COSTCNTR_DATA" ;
  