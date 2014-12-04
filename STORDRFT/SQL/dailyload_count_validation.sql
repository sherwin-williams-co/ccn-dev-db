/**********************************************************
This script will validate the counts after the dailyLoad is performed
CREATED : 12/03/2014 AXK326 CCN Project team....
**********************************************************/

-- Validating the dailyLoad counts
select count(*) from CUSTOMER_DETAILS_AXK;

select count(*) from Error_Log where module = 'LOAD_DLY_CUSTOMER_DETAILS_AXK';

Commit;
