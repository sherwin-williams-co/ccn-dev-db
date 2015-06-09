-- sxt410 06/09/2015
-- Correcting Terminal: Updating POLLING_STATUS_CODE = 'P' for Terminal 13536 and Cost_center_code 705256.
select * from terminal where cost_center_code = '705256' and terminal_number = '13536';

UPDATE terminal
   SET polling_status_code = 'P'
 WHERE cost_center_code ='705256'
   AND terminal_number = '13536';

COMMIT;