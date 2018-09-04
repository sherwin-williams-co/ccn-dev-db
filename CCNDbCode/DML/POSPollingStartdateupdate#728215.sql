/*******************************************************************************
Script to update polling start date for cost center 728215.

CREATED : 08/31/2018 pxa852 CCN Project...
*******************************************************************************/

UPDATE POLLING SET POLLING_START_DATE  = '29-AUG-18',
                   POLLING_STOP_DATE   = NULL
   WHERE COST_CENTER_CODE   = '708215'
     AND CURRENT_FLAG       = 'Y';

commit
