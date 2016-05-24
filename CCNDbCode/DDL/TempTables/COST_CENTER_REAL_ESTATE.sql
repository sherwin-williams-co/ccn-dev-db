BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE COST_CENTER_REAL_ESTATE';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/


  CREATE TABLE COST_CENTER_REAL_ESTATE
   (	COST_CENTER_CODE VARCHAR2(6), 
	COST_CENTER_NAME VARCHAR2(35), 
	CATEGORY VARCHAR2(1), 
	ENTITY_TYPE VARCHAR2(2), 
	STATEMENT_TYPE VARCHAR2(2), 
	COUNTRY_CODE VARCHAR2(3), 
	TRANSPORT_TYPE VARCHAR2(5), 
	BEGIN_DATE VARCHAR2(8), 
	OPEN_DATE VARCHAR2(8), 
	MOVE_DATE VARCHAR2(8), 
	CLOSE_DATE VARCHAR2(8), 
	FINANCIAL_CLOSE_DATE VARCHAR2(8), 
	POS_PROG_VER_EFF_DATE VARCHAR2(8), 
	UPS_ZONE_CODE VARCHAR2(1), 
	RPS_ZONE_CODE VARCHAR2(1), 
	CURRENCY_CODE VARCHAR2(3), 
	POS_PROG_VER_NBR VARCHAR2(5), 
	LEASE_OWN_CODE VARCHAR2(1), 
	MISSION_TYPE_CODE VARCHAR2(2), 
	DUNS_NUMBER VARCHAR2(9), 
	PRI_LOGO_GROUP_IND VARCHAR2(3), 
	SCD_LOGO_GROUP_IND VARCHAR2(3), 
	BANKING_TYPE VARCHAR2(1), 
	DEPOSIT_BAG_REORDER VARCHAR2(1), 
	DEPOSIT_TICKET_REORDER VARCHAR2(1), 
	POP_KIT_CODE VARCHAR2(1), 
	GLOBAL_HIERARCHY_IND VARCHAR2(1), 
	STATUS_CODE VARCHAR2(1), 
	STATUS_EFFECTIVE_DATE VARCHAR2(8), 
	STATUS_EXPIRATION_DATE VARCHAR2(8), 
	TYPE_CODE VARCHAR2(2), 
	TYPE_EFFECTIVE_DATE VARCHAR2(8), 
	TYPE_EXPIRATION_DATE VARCHAR2(8), 
	REAL_ESTATE_CATEGORY VARCHAR2(1), 
	USA_ADDRESS_TYPE VARCHAR2(2), 
	USA_EFFECTIVE_DATE VARCHAR2(8), 
	USA_EXPIRATION_DATE VARCHAR2(8), 
	USA_ADDRESS_LINE_1 VARCHAR2(35), 
	USA_ADDRESS_LINE_2 VARCHAR2(35), 
	USA_ADDRESS_LINE_3 VARCHAR2(35), 
	USA_CITY VARCHAR2(25), 
	USA_STATE_CODE VARCHAR2(2), 
	USA_ZIP_CODE VARCHAR2(5), 
	USA_ZIP_CODE_4 VARCHAR2(4), 
	USA_COUNTY VARCHAR2(30), 
	USA_FIPS_CODE VARCHAR2(10), 
	USA_DESTINATION_POINT VARCHAR2(2), 
	USA_CHECK_DIGIT VARCHAR2(1), 
	USA_VALID_ADDRESS VARCHAR2(1), 
	USA_COUNTRY_CODE VARCHAR2(3), 
	CAN_ADDRESS_TYPE VARCHAR2(2), 
	CAN_EFFECTIVE_DATE VARCHAR2(8), 
	CAN_EXPIRATION_DATE VARCHAR2(8), 
	CAN_ADDRESS_LINE_1 VARCHAR2(35), 
	CAN_ADDRESS_LINE_2 VARCHAR2(35), 
	CAN_ADDRESS_LINE_3 VARCHAR2(35), 
	CAN_CITY VARCHAR2(25), 
	CAN_PROVINCE_CODE VARCHAR2(2), 
	CAN_POSTAL_CODE VARCHAR2(6), 
	CAN_VALID_ADDRESS VARCHAR2(1), 
	CAN_COUNTRY_CODE VARCHAR2(3), 
	MEX_ADDRESS_TYPE VARCHAR2(2), 
	MEX_EFFECTIVE_DATE VARCHAR2(8), 
	MEX_EXPIRATION_DATE VARCHAR2(8), 
	MEX_ADDRESS_LINE_1 VARCHAR2(35), 
	MEX_ADDRESS_LINE_2 VARCHAR2(35), 
	MEX_ADDRESS_LINE_3 VARCHAR2(35), 
	MEX_CITY VARCHAR2(25), 
	MEX_PROVINCE_CODE VARCHAR2(5), 
	MEX_POSTAL_CODE VARCHAR2(5), 
	MEX_VALID_ADDRESS VARCHAR2(1), 
	MEX_COUNTRY_CODE VARCHAR2(3), 
	OTHER_ADDRESS_TYPE VARCHAR2(2), 
	OTHER_EFFECTIVE_DATE VARCHAR2(8), 
	OTHER_EXPIRATION_DATE VARCHAR2(8), 
	OTHER_ADDRESS_LINE_1 VARCHAR2(35), 
	OTHER_ADDRESS_LINE_2 VARCHAR2(35), 
	OTHER_ADDRESS_LINE_3 VARCHAR2(35), 
	OTHER_CITY VARCHAR2(25), 
	OTHER_PROVINCE_CODE VARCHAR2(25), 
	OTHER_STATE_CODE VARCHAR2(25), 
	OTHER_POSTAL_CODE VARCHAR2(10), 
	OTHER_VALID_ADDRESS VARCHAR2(1), 
	OTHER_COUNTRY_CODE VARCHAR2(3), 
	BRB_ADDRESS_TYPE VARCHAR2(2), 
	BRB_EFFECTIVE_DATE VARCHAR2(8), 
	BRB_EXPIRATION_DATE VARCHAR2(8), 
	BRB_PREMISES VARCHAR2(50), 
	BRB_AVENUE_LANE VARCHAR2(50), 
	BRB_DISTRICT VARCHAR2(50), 
	BRB_PARISH VARCHAR2(25), 
	BRB_POSTAL_CODE VARCHAR2(5), 
	BRB_VALID_ADDRESS VARCHAR2(1), 
	BRB_COUNTRY_CODE VARCHAR2(3), 
	PRI_PHONE_NUMBER_TYPE VARCHAR2(5), 
	PRI_PHONE_AREA_CODE VARCHAR2(4), 
	PRI_PHONE_NUMBER VARCHAR2(7), 
	PRI_PHONE_EXTENSION VARCHAR2(6), 
	SCD_PHONE_NUMBER_TYPE VARCHAR2(5), 
	SCD_PHONE_AREA_CODE VARCHAR2(4), 
	SCD_PHONE_NUMBER VARCHAR2(7), 
	SCD_PHONE_EXTENSION VARCHAR2(6), 
	FAX_PHONE_NUMBER_TYPE VARCHAR2(5), 
	FAX_PHONE_AREA_CODE VARCHAR2(4), 
	FAX_PHONE_NUMBER VARCHAR2(7), 
	FAX_PHONE_EXTENSION VARCHAR2(6), 
	ADMIN_TO_SALES_AREA VARCHAR2(100), 
	ADMIN_TO_SALES_DISTRICT VARCHAR2(100), 
	ADMIN_TO_SALES_DIVISION VARCHAR2(100), 
	ALTERNATE_DAD VARCHAR2(100), 
	FACTS_DIVISION VARCHAR2(100), 
	LEGACY_GL_DIVISION VARCHAR2(100), 
	GLOBAL_HIERARCHY VARCHAR2(100), 
	MANAGER_ID VARCHAR2(100)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_LOADER
      DEFAULT DIRECTORY "CCN_LOAD_FILES"
      ACCESS PARAMETERS
      ( RECORDS DELIMITED BY NEWLINE SKIP 1
          badfile "CCN_LOAD_FILES":'COST_CENTER_REAL_ESTATE.bad'
          logfile "CCN_LOAD_FILES":'COST_CENTER_REAL_ESTATE.log'
          FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' LDRTRIM
          MISSING FIELD VALUES ARE NULL
          REJECT ROWS WITH ALL NULL FIELDS
                                       (COST_CENTER_CODE,
                                        COST_CENTER_NAME,
                                        CATEGORY,
                                        ENTITY_TYPE,
                                        STATEMENT_TYPE,
                                        COUNTRY_CODE,
                                        TRANSPORT_TYPE,
                                        BEGIN_DATE,
                                        OPEN_DATE,
                                        MOVE_DATE,
                                        CLOSE_DATE,
                                        FINANCIAL_CLOSE_DATE,
                                        POS_PROG_VER_EFF_DATE,
                                        UPS_ZONE_CODE,
                                        RPS_ZONE_CODE,
                                        CURRENCY_CODE,
                                        POS_PROG_VER_NBR,
                                        LEASE_OWN_CODE,
                                        MISSION_TYPE_CODE,
                                        DUNS_NUMBER,
                                        PRI_LOGO_GROUP_IND,
                                        SCD_LOGO_GROUP_IND,
                                        BANKING_TYPE,
                                        DEPOSIT_BAG_REORDER,
                                        DEPOSIT_TICKET_REORDER,
                                        POP_KIT_CODE,
                                        GLOBAL_HIERARCHY_IND,
                                        STATUS_CODE,
                                        STATUS_EFFECTIVE_DATE,
                                        STATUS_EXPIRATION_DATE,
                                        TYPE_CODE,
                                        TYPE_EFFECTIVE_DATE,
                                        TYPE_EXPIRATION_DATE,
                                        REAL_ESTATE_CATEGORY,
                                        USA_ADDRESS_TYPE,
                                        USA_EFFECTIVE_DATE,
                                        USA_EXPIRATION_DATE,
                                        USA_ADDRESS_LINE_1,
                                        USA_ADDRESS_LINE_2,
                                        USA_ADDRESS_LINE_3,
                                        USA_CITY,
                                        USA_STATE_CODE,
                                        USA_ZIP_CODE,
                                        USA_ZIP_CODE_4,
                                        USA_COUNTY,
                                        USA_FIPS_CODE,
                                        USA_DESTINATION_POINT,
                                        USA_CHECK_DIGIT,
                                        USA_VALID_ADDRESS,
                                        USA_COUNTRY_CODE,
                                        CAN_ADDRESS_TYPE,
                                        CAN_EFFECTIVE_DATE,
                                        CAN_EXPIRATION_DATE,
                                        CAN_ADDRESS_LINE_1,
                                        CAN_ADDRESS_LINE_2,
                                        CAN_ADDRESS_LINE_3,
                                        CAN_CITY,
                                        CAN_PROVINCE_CODE,
                                        CAN_POSTAL_CODE,
                                        CAN_VALID_ADDRESS,
                                        CAN_COUNTRY_CODE, 
                                        MEX_ADDRESS_TYPE,
                                        MEX_EFFECTIVE_DATE,
                                        MEX_EXPIRATION_DATE,
                                        MEX_ADDRESS_LINE_1,
                                        MEX_ADDRESS_LINE_2,
                                        MEX_ADDRESS_LINE_3,
                                        MEX_CITY,
                                        MEX_PROVINCE_CODE,
                                        MEX_POSTAL_CODE,
                                        MEX_VALID_ADDRESS,
                                        MEX_COUNTRY_CODE,
                                        OTHER_ADDRESS_TYPE,
                                        OTHER_EFFECTIVE_DATE,
                                        OTHER_EXPIRATION_DATE,
                                        OTHER_ADDRESS_LINE_1,
                                        OTHER_ADDRESS_LINE_2,
                                        OTHER_ADDRESS_LINE_3,
                                        OTHER_CITY,
                                        OTHER_PROVINCE_CODE,
                                        OTHER_STATE_CODE,
                                        OTHER_POSTAL_CODE,
                                        OTHER_VALID_ADDRESS,
                                        OTHER_COUNTRY_CODE,
                                        BRB_ADDRESS_TYPE,
                                        BRB_EFFECTIVE_DATE,
                                        BRB_EXPIRATION_DATE,
                                        BRB_PREMISES,
                                        BRB_AVENUE_LANE,
                                        BRB_DISTRICT,
                                        BRB_PARISH,
                                        BRB_POSTAL_CODE,
                                        BRB_VALID_ADDRESS,
                                        BRB_COUNTRY_CODE,
                                        PRI_PHONE_NUMBER_TYPE,
                                        PRI_PHONE_AREA_CODE,
                                        PRI_PHONE_NUMBER,
                                        PRI_PHONE_EXTENSION,
                                        SCD_PHONE_NUMBER_TYPE,
                                        SCD_PHONE_AREA_CODE,
                                        SCD_PHONE_NUMBER,
                                        SCD_PHONE_EXTENSION,
                                        FAX_PHONE_NUMBER_TYPE,
                                        FAX_PHONE_AREA_CODE,
                                        FAX_PHONE_NUMBER,
                                        FAX_PHONE_EXTENSION,
                                        ADMIN_TO_SALES_AREA,
                                        ADMIN_TO_SALES_DISTRICT,
                                        ADMIN_TO_SALES_DIVISION,
                                        ALTERNATE_DAD,
                                        FACTS_DIVISION,
                                        LEGACY_GL_DIVISION,
                                        GLOBAL_HIERARCHY,
                                        MANAGER_ID)
                     )
      LOCATION
       ( 'COST_CENTER_REAL_ESTATE.csv'
       )
    )
   REJECT LIMIT UNLIMITED ;
