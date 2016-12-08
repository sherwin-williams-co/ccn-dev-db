/*
**************************************************************************** 
This script is created to Add new column on ROYAL_BANK_RPT_MAIN table
created : 12/02/2016 gxg192 CCN Project.... 
changed : 
****************************************************************************
*/

/*ROYAL_BANK_RPT_MAIN*/
ALTER TABLE ROYAL_BANK_RPT_MAIN
ADD DESCRIPTION VARCHAR2(32);

ALTER TABLE ROYAL_BANK_RPT_MAIN
ADD DB_AMOUNT VARCHAR2(15);

ALTER TABLE ROYAL_BANK_RPT_MAIN
ADD LOAD_DATE DATE DEFAULT SYSDATE;

/*COMMENT ON DESCRIPTION*/
COMMENT ON COLUMN ROYAL_BANK_RPT_MAIN.DESCRIPTION
IS 'It holds data for description field.';

/*COMMENT ON DESCRIPTION*/
COMMENT ON COLUMN ROYAL_BANK_RPT_MAIN.DB_AMOUNT
IS 'It holds data for db_amount field.';

/*COMMENT ON DESCRIPTION*/
COMMENT ON COLUMN ROYAL_BANK_RPT_MAIN.LOAD_DATE
IS 'It holds date on which data is inserted in the table.';