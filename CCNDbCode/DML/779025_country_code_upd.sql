/*****************************************************************
Created : nxk927 07/25/2017
          Country code update for cost center 779025
select * from COST_CENTER where COST_CENTER_CODE = '779025';
select * from ADDRESS_CAN where COST_CENTER_CODE = '779025';
select * from ADDRESS_USA where COST_CENTER_CODE = '779025';
****************************************************************/

BEGIN
    CCN_BATCH_PKG.LOCK_DATABASE_SP();
END;
/
SET DEFINE OFF;  

---expiring the address in address_usa table first
UPDATE ADDRESS_USA
   SET EXPIRATION_DATE = TRUNC(SYSDATE)
 WHERE COST_CENTER_CODE = '779025';

---updating the country code in the cost center table
UPDATE COST_CENTER 
   SET COUNTRY_CODE = 'CAN'
 WHERE COST_CENTER_CODE = '779025';


---inserting a new record in the address_can table for cost center 779025
INSERT INTO ADDRESS_CAN
VALUES ('779025', 'M', TRUNC(SYSDATE), NULL, '170 Brock Port Dr #80', NULL, NULL, 'TORONTO', 'ON','M9W5C8', NULL, 'CAN');


COMMIT;

BEGIN
    CCN_BATCH_PKG.UNLOCK_DATABASE_SP();
END;
/