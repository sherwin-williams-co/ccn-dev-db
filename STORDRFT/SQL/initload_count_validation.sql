/**********************************************************
This script will validate the counts after the initLoad is performed
CREATED : 12/03/2014 AXK326 CCN Project team....
**********************************************************/

-- Validating the initLoad counts
select count(*) from CUSTOMER_DETAILS_AXK;

select count(*) from Error_Log where module = 'LOAD_CUSTOMER_DETAILS_AXK';

Commit;
