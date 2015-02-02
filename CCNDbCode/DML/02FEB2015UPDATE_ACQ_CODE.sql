--Correcting the Acquisition_code for the cost center 789190

SET DEFINE OFF;

select * from cost_center where cost_center_code = '789190';

Update cost_center
   set Acquisition_Code = 'AU'
 Where cost_center_code = '789190';

Commit;