--Correcting the year for the close dates of cost centers 75Q061 and 75Q073 from 0014 to 2014.
SET DEFINE OFF;
SELECT * FROM cost_center where cost_center_code in('75Q061', '75Q073');
UPDATE cost_center SET CLOSE_DATE = to_date('01-MAY-2014', 'DD-MON-YYYY') WHERE cost_center_code in('75Q061', '75Q073');
select * from status where cost_center_code in('75Q061','75Q073');
UPDATE STATUS SET EFFECTIVE_DATE = to_date('01-MAY-2014', 'DD-MON-YYYY') WHERE cost_center_code in('75Q061', '75Q073') and status_code ='X';
UPDATE STATUS SET EXPIRATION_DATE = to_date('30-APR-2014', 'DD-MON-YYYY') WHERE cost_center_code in('75Q061', '75Q073') and status_code ='N';
