--Correcting the dates for the cost centers 75Q059, 755786 and 702896.
SET DEFINE OFF;
select * from cost_center where cost_center_code = '75Q059';
UPDATE cost_center SET CLOSE_DATE = to_date('15-SEP-2013', 'DD-MON-YYYY') WHERE cost_center_code = '75Q059';

SELECT * FROM status where cost_center_code = '75Q059';
UPDATE STATUS SET EFFECTIVE_DATE = to_date('15-SEP-2013', 'DD-MON-YYYY') WHERE cost_center_code = '75Q059' and status_code ='X';
UPDATE STATUS SET EXPIRATION_DATE = to_date('14-SEP-2013', 'DD-MON-YYYY') WHERE cost_center_code = '75Q059' and status_code ='N';

select * from cost_center where cost_center_code = '755786';
UPDATE cost_center SET OPEN_DATE = to_date('01-DEC-2013', 'DD-MON-YYYY') WHERE cost_center_code = '755786';
select * from cost_center where cost_center_code = '702896';
UPDATE cost_center SET OPEN_DATE = to_date('13-FEB-2014', 'DD-MON-YYYY') WHERE cost_center_code = '702896';