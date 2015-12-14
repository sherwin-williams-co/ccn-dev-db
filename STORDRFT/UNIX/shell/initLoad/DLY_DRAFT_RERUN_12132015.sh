#!/bin/sh
#################################################################
# Script name   : DLY_DRAFT_RERUN_12132015.sh
#
# Description   : This script is to re run the daily maintenance load for AutoMotive and Non AutoMotive for 12/13/2014
#				  
# Created  : 12/14/2015 nxk927 CCN Project Team.....
# Modified : 
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="DLY_DRAFT_RERUN_12132015"
TIME=`date +"%H:%M:%S"`
DATE='12/13/2015'
DATE_PREV='12/12/2015'
echo "Processing Started for $proc at $TIME on $DATE"
echo "Running DLY_DRAFT_LOAD process"
./EXEC_PROC_1PARAM.sh "SD_BANKFILES_PKG.CREATE_CAN_AUTO_FILE" "$DATE"
./EXEC_PROC_1PARAM.sh "SD_BANKFILES_PKG.CREATE_CAN_NONAUTO_FILE" "$DATE"
./EXEC_PROC_1PARAM.sh "SD_BANKFILES_PKG.CREATE_US_NONAUTO_FILE" "$DATE"
./EXEC_PROC_1PARAM.sh "SD_BANKFILES_PKG.CREATE_US_AUTO_BANK_FILE" "$DATE" 


echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi


############################################################################

proc_name1="DLY_RECONCILIATION_rerun"
TIME=`date +"%H:%M:%S"`

echo "Processing Started for $proc_name1 at $TIME on $DATE"
echo "Running DLY_RECONCILIATION_rerun process"

./EXEC_PROC_1PARAM.sh "SD_DAILY_RECS_REPORT.DISPLAY_AMOUNTS" "$DATE_PREV"

echo "Processing finished for $proc_name1 at ${TIME} on ${DATE}"
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name1 at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0
############################################################################
