--Correcting the Acquisition_code for the cost centers 768930,768904,768851,701487,701707 
SET DEFINE OFF;
select * from cost_center where COST_CENTER_CODE in('768930','768904','768851');

UPDATE cost_center
   SET Acquisition_code ='GC'
 WHERE cost_center_code in('768930','768904','768851')
   and Acquisition_code ='CN';

select * from cost_center where COST_CENTER_CODE ='701487';   
UPDATE cost_center
   SET Acquisition_code ='FP'
 WHERE cost_center_code ='701487'
   and Acquisition_code ='CX';

select * from cost_center where COST_CENTER_CODE ='701707';    
UPDATE cost_center
   SET Acquisition_code ='KP'
 WHERE cost_center_code ='701707'
   and Acquisition_code ='FP';