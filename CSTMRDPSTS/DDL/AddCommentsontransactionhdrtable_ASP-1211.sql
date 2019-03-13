/*******************************************************************************
This script will add comments on terminal_number column in CUSTOMER_DEPOSIT_TRANSACTION_HDR table
CREATED : 03/13/2019 pxa852 CCN Project...
*******************************************************************************/

COMMENT ON COLUMN customer_deposit_transaction_hdr.Terminal_number
     IS 'If a transaction is not found in POS (overdrawn or not redemmed), the user will enter the Terminal and transaction number as 99999';