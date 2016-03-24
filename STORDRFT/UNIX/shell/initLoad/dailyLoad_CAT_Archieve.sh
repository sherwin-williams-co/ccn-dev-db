#!/bin/sh
#################################################################
# Script name   : dailyLoad_CAT_Archieve.sh
#
# Description   : concatenate the dailyLoad files created
#                 accepts proc name and week number as paratmers 1 and 2
#                 Archive the dailyLoad files created for CUSTOMER_LABOR & STORE_DRAFT Files
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
#          : 03/18/2016 nxk927 CCN Project Team.....
#            Changed the order of declaring variables after capturing the STATUS to avoid the scenario where
#            the ERROR CODE that needs to be captured, will not be overwritten in the ERROR STATUS CHECK block
#            ADDED the error each script called and changed the status check to make it uniform
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="dailyLoad_CAT_Archieve"
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE}
echo "Processing Started for $proc_name at $TIME on $DATE"

# below command will call the script to concatenate CUSTOMER_LABOR & STORE_DRAFT Files.
./dailyLoad_CAT.sh

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

# below command will call the script to Archive CUSTOMER_LABOR & STORE_DRAFT Files.
./Archive_dailyLoad.sh

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
