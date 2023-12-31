/********************************************************************************
This script Creates Timezine table to store Country, State, ZIp wise timezone information

Created : 08/28/2017 rxa457 CCN Project Team....

********************************************************************************/
REM CREATING TABLE TIMEZONE
CREATE TABLE TIMEZONE(ZIPCODE VARCHAR2(5) NOT NULL, 
                      CITY VARCHAR2(160), 
                      STATE VARCHAR2(5), 
                      COUNTRY VARCHAR2(3), 
                      TZ_CD_VALUE VARCHAR2(2) NOT NULL, 
                      CONSTRAINT TIMEZONE_PK PRIMARY KEY (COUNTRY, ZIPCODE)
                      );

CREATE INDEX TIMEZONE_NX01 ON TIMEZONE(COUNTRY, STATE);

