/*
SCRIPT NAME: DDL_CURRENCY_CONVERSION.SQL
PURPOSE    : CREATING THE CURRENCY_CONVERSION TABLE.

CREATED : 08/28/2017 axt754 CCN PROJECT....
CHANGED : 
*/

CREATE TABLE CURRENCY_CONVERSION
   ( COUNTRY_CODE     VARCHAR2(3),
   EFFECTIVE_DATE     DATE,
   EXPIRATION_DATE    DATE,
   CONVERSION_RATE    NUMBER(5,3),
   DISPLAY_VAT_FLAG   VARCHAR2(3),
   CURRENCY_TYPE      VARCHAR2(3),
   TAXID_NUMBER       VARCHAR2(500),
   TAXID_DESCRIPTION  VARCHAR2(500),
   VAT_TAX_ID         VARCHAR2(100),
   CREATED_BY         VARCHAR2(10)
   );

ALTER TABLE  CURRENCY_CONVERSION ADD CONSTRAINT PK_CURRENCY_CONVERSION PRIMARY KEY (COUNTRY_CODE,EFFECTIVE_DATE);

GRANT SELECT ON CURRENCY_CONVERSION TO CCN_UTILITY;
