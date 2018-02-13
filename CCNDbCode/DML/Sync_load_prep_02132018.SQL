-- created by rxv940 on 02/13/2018
-- Run this in COSTCNTR schema

SELECT *
  FROM COST_CENTER
 WHERE COST_CENTER_CODE IN ('721043',
                            '721270',
                            '721490',
                            '721499',
                            '721540',
                            '721547',
                            '722304',
                            '723084',
                            '725056',
                            '728116');


UPDATE COST_CENTER 
   SET POS_DOWNLOAD_CC_IND = 'Y'
 WHERE COST_CENTER_CODE IN ('721043',
                            '721270',
                            '721490',
                            '721499',
                            '721540',
                            '721547',
                            '722304',
                            '723084',
                            '725056',
                            '728116')
   AND 	NVL(POS_DOWNLOAD_CC_IND, 'N') <> 'Y';
   
COMMIT;


