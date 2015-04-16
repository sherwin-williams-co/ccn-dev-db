--SXT410 04/16/2015
-- script to update the following drafts as paid on our system.

update store_drafts
   set paid_date = '26-MAR-2015' , PAY_INDICATOR = 'Y'
 where check_serial_number = '0828011544'
   and cost_center_code = '708280';
commit;

update store_drafts
   set paid_date = '18-MAR-2015' , PAY_INDICATOR = 'Y'
 where check_serial_number = '0820081024'
   and cost_center_code = '708200';
commit;

update store_drafts
   set paid_date = '09-MAR-2015' , PAY_INDICATOR = 'Y'
 where check_serial_number = '0820710051'
   and cost_center_code = '708207';
commit;

update store_drafts
   set paid_date = '16-MAR-2015' , PAY_INDICATOR = 'Y'
 where check_serial_number = '0816917868'
   and cost_center_code = '708169';
commit;

update store_drafts
   set paid_date = '13-FEB-2015' , PAY_INDICATOR = 'Y'
 where check_serial_number = '0730533460'
   and cost_center_code = '707305';
commit;

update store_drafts
   set paid_date = '19-FEB-2015' , PAY_INDICATOR = 'Y'
 where check_serial_number = '0769720509'
   and cost_center_code = '707697';
commit;

update store_drafts
   set paid_date = '26-FEB-2015' , PAY_INDICATOR = 'Y'
 where check_serial_number = '0816614010'
   and cost_center_code = '708166';
commit;