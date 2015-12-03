/*
Created: AXK326 12/03/2015 CCN Project Team....
         We need to update the first record's AUDIT_REC_FLAG to be 'R' in order for them to be sent into Backfeed file  
*/

select * from AUDIT_LOG where TRANSACTION_ID like '%|0347042|%' order by TRANSACTION_DATE desc;  
select * from AUDIT_LOG where TRANSACTION_ID like '%|0374397|%' order by TRANSACTION_DATE desc;  
select * from AUDIT_LOG where TRANSACTION_ID like '%|0336968|%' order by TRANSACTION_DATE desc;  

UPDATE AUDIT_LOG
   SET AUDIT_REC_FLAG = 'R'
WHERE LOG_ID = '470455';

UPDATE AUDIT_LOG
   SET AUDIT_REC_FLAG = 'R'
WHERE LOG_ID = '470754';

UPDATE AUDIT_LOG
   SET AUDIT_REC_FLAG = 'R'
WHERE LOG_ID = '469674';

COMMIT;

select * from AUDIT_LOG where TRANSACTION_ID like '%|0347042|%' order by TRANSACTION_DATE desc;  
select * from AUDIT_LOG where TRANSACTION_ID like '%|0374397|%' order by TRANSACTION_DATE desc;  
select * from AUDIT_LOG where TRANSACTION_ID like '%|0336968|%' order by TRANSACTION_DATE desc;  