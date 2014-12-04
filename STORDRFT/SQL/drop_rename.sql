/**********************************************************
This script will drop and rename the table
CREATED : 12/03/2014 AXK326 CCN Project team....
**********************************************************/

ALTER TABLE CUSTOMER_DETAILS RENAME TO CUSTOMER_DETAILS_EXISTING;
COMMIT;

ALTER TABLE CUSTOMER_DETAILS_AXK RENAME TO CUSTOMER_DETAILS;
COMMIT;
