/**********************************************************
THIS DML will take care of the check_serial_number corrections 
CREATED : axk326 CCN Project team....
MODIFIED: 
**********************************************************/
-- redundant check_serial_numbers and their counts from STORE_DRAFTS table
SELECT COST_CENTER_CODE, CHECK_SERIAL_NUMBER, count(*) 
  FROM store_drafts
  GROUP BY COST_CENTER_CODE, CHECK_SERIAL_NUMBER
  HAVING COUNT(*)>1;

-- DISPLAY THE RECORDS IN STORE-DRAFTS
SELECT * FROM STORE_DRAFTS
 WHERE CHECK_SERIAL_NUMBER IN (SELECT CHECK_SERIAL_NUMBER 
                                 FROM store_drafts
                             GROUP BY COST_CENTER_CODE, 
                                      CHECK_SERIAL_NUMBER
                               HAVING COUNT(*)>1)
 ORDER BY 2 DESC;

-- Complete record set for a check_serial_number from STORE_DRAFTS_DETAIL table 
SELECT * FROM STORE_DRAFTS_DETAIL 
 WHERE CHECK_SERIAL_NUMBER IN (SELECT CHECK_SERIAL_NUMBER 
                                 FROM STORE_DRAFTS
                             GROUP BY CHECK_SERIAL_NUMBER
                               HAVING COUNT(*)>1)
ORDER BY 3 DESC;

-- SELECT the records from store_drafts that needs to be deleted
SELECT sd.cost_center_code, sd.check_serial_number, sd.transaction_date
  FROM store_drafts sd, 
       STORE_DRAFTS_DETAIL sdd
  WHERE SD.COST_CENTER_CODE    = SDD.COST_CENTER_CODE
    AND SD.CHECK_SERIAL_NUMBER = SDD.CHECK_SERIAL_NUMBER
    AND SD.TRANSACTION_DATE    <> SDD.TRANSACTION_DATE
    AND SD.CHECK_SERIAL_NUMBER IN (SELECT CHECK_SERIAL_NUMBER
                                     FROM STORE_DRAFTS
                                 GROUP BY COST_CENTER_CODE, 
                                          CHECK_SERIAL_NUMBER
                                   HAVING COUNT(*)>1);

-- DELETE redundant records from STORE_DRAFTS table which are not available in STORE_DRAFTS_DETAIL table
DELETE FROM store_drafts where (cost_center_code, check_serial_number, transaction_date) in 
(select sd.cost_center_code, sd.check_serial_number, sd.transaction_date
  from store_drafts sd, 
       STORE_DRAFTS_DETAIL sdd
  where SD.COST_CENTER_CODE    = SDD.COST_CENTER_CODE
    and SD.CHECK_SERIAL_NUMBER = SDD.CHECK_SERIAL_NUMBER
    and SD.TRANSACTION_DATE    <> SDD.TRANSACTION_DATE
    and SD.CHECK_SERIAL_NUMBER in (select CHECK_SERIAL_NUMBER
                                     from store_drafts
                                 group by COST_CENTER_CODE, 
                                          CHECK_SERIAL_NUMBER
                                   having count(*)>1));