/*******************************************************************************
Script to update polling start date for cost center 728215.

CREATED : 08/31/2018 pxa852 CCN Project...
*******************************************************************************/
SELECT * FROM POLLING WHERE COST_CENTER_CODE='728215' AND CURRENT_FLAG = 'Y';

UPDATE POLLING SET POLLING_START_DATE  = '29-AUG-2018',
                   POLLING_STOP_DATE   = NULL
   WHERE COST_CENTER_CODE   = '728215'
     AND CURRENT_FLAG       = 'Y';

commit;

SELECT * FROM POLLING WHERE COST_CENTER_CODE='728215' AND CURRENT_FLAG = 'Y';
