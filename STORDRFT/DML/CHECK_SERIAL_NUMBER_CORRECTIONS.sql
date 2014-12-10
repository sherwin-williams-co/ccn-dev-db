/**********************************************************
THIS DML will take care of the check_serial_number corrections 
CREATED : axk326 CCN Project team....
MODIFIED: 
**********************************************************/
-- redundant check_serial_numbers and their counts
select COST_CENTER_CODE, CHECK_SERIAL_NUMBER, count(*) 
  from store_drafts
  group by COST_CENTER_CODE, CHECK_SERIAL_NUMBER
  having count(*)>1;

-- Complete record set for a check_serial_number from store_drafts table 
select * from STORE_DRAFTS where CHECK_SERIAL_NUMBER in 
(select CHECK_SERIAL_NUMBER 
   from store_drafts
  group by CHECK_SERIAL_NUMBER
  having count(*)>1)
order by 2 desc;

-- Complete record set for a check_serial_number from store_drafts_detail table 
select * from STORE_DRAFTS_DETAIL where CHECK_SERIAL_NUMBER in 
(select CHECK_SERIAL_NUMBER 
   from store_drafts
  group by CHECK_SERIAL_NUMBER
  having count(*)>1)
order by 3 desc;

-- To get the max of transaction_date from the redundant check_serial_number records
select CHECK_SERIAL_NUMBER, max(STORE_DRAFTS.TRANSACTION_DATE) from store_drafts group by CHECK_SERIAL_NUMBER having count(*)>1;


-- To get the min of transaction_date from the redundant check_serial_number records
select CHECK_SERIAL_NUMBER, MIN(TRANSACTION_DATE) 
                          from store_drafts 
                          group by CHECK_SERIAL_NUMBER 
                          having count(*)>1 
                          order by 1 desc;

-- Delete records from store_drafts_detail table
DELETE FROM STORE_DRAFTS_DETAIL 
where CHECK_SERIAL_NUMBER in (select CHECK_SERIAL_NUMBER 
                                from store_drafts
                                group by CHECK_SERIAL_NUMBER
                                having count(*)>1);

-- Delete records from Store_drafts table
DECLARE
  CURSOR TEMP_CUR IS 
  select CHECK_SERIAL_NUMBER, 
         MIN(TRANSACTION_DATE) 
                          from store_drafts 
                          group by CHECK_SERIAL_NUMBER 
                          having count(*)>1;
BEGIN
  FOR REC IN TEMP_CUR LOOP
    DELETE FROM STORE_DRAFTS
     WHERE check_serial_number  = rec.check_serial_number
       and transaction_date     = rec.transaction_date;
   END LOOP;
END;
                     
                          
