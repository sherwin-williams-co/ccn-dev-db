#!/bin/sh
################################################################################
# Shell script to call to concatenate the dailyLoad files created 
# and Archive the dailyLoad files created for CUSTOMER_LABOR & STORE_DRAFT Files
# axk326 / sxt410 08/19/2014
################################################################################


cd /app/ccn/dev/initLoad/STORDRFT

# below command will call the script to concatenate CUSTOMER_LABOR & STORE_DRAFT Files.
./dailyLoad_CAT.sh

# below command will call the script to Archive CUSTOMER_LABOR & STORE_DRAFT Files.
./Archive_dailyLoad.sh

exit 0
