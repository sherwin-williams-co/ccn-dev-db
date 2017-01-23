/*******************************************************************************   
This table updates PRIME_SUB and BOOKING_COST_CENTER in accordance with loading package changes
Created : 01/23/2017 vxv336 CCN Project Team.... 
Changed : 
*******************************************************************************/

UPDATE MISCTRAN_DETAILS
SET PRIME_SUB           = SUBSTR(PRIME_SUB,1,7),
    BOOKING_COST_CENTER = (SELECT COST_CENTER_CODE FROM COSTCNTR.COST_CENTER WHERE SUBSTR(COST_CENTER_CODE,-4) = SUBSTR(PRIME_SUB,-4));

COMMIT;