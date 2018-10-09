  /********************************************************************************** 
This script is used to merge the summary test table data with the actual table. Tested the parallel process for cost center code 1600 in prod. user updated the bank account number and transactions were sent through the parallel process files. These transactions has to be merged to the actual table otherwise they will be sent through the actual file again.

Created : 10/03/2018 pxa852 CCN Project Team....
Modified: 
**********************************************************************************/

--Note: Please run this insert before dropping the test/parallel tables.

INSERT INTO SUMMARY_EXTRCT_CNTRL_FL
SELECT * FROM SUMMAR_EXTRCT_CNTRL_FL_TST
MINUS
SELECT * FROM SUMMARY_EXTRCT_CNTRL_FL;

COMMIT;