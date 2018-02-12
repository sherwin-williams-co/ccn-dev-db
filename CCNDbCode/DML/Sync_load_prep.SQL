-- created by rxv940 on 02/12/2018
-- Run this in COSTCNTR schema

SELECT *
  FROM COST_CENTER
 WHERE COST_CENTER_CODE IN ('722944',
                            '728222',
                            '721292',
                            '723098',
                            '723198',
                            '725214',
                            '725626',
                            '703489',
                            '727616');


UPDATE COST_CENTER 
   SET POS_DOWNLOAD_CC_IND = 'Y'
 WHERE COST_CENTER_CODE IN ('722944',
                            '728222',
                            '721292',
                            '723098',
                            '723198',
                            '725214',
                            '725626',
                            '703489',
                            '727616')
   AND 	POS_DOWNLOAD_CC_IND <> 'Y';
   
COMMIT;