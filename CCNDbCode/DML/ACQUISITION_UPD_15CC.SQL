--Correcting the Acquisition_code for the cost centers ('80U202','80U661','80U662', '80U664',  '80U665', '80U666',
--                            '80U667', '80U668', '80U669', '80U663', '70K952','70K953',
--                            '80U118', '70V118', '80U320')
SET DEFINE OFF;

UPDATE cost_center
   SET Acquisition_code ='CX'
 WHERE cost_center_code in ('80U202','80U661','80U662', '80U664',  '80U665', 
							'80U666','80U667', '80U668', '80U669', '80U663');


UPDATE cost_center
   SET Acquisition_code ='FP'
 WHERE cost_center_code in ('70K952','70K953');

UPDATE cost_center
   SET Acquisition_code ='PK'
 WHERE cost_center_code in ('80U118', '70V118');
 
UPDATE cost_center
   SET Acquisition_code ='CO'
 WHERE cost_center_code = '80U320';

Commit;
/