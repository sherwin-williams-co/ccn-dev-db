#!/bin/sh
#############################################################################################################################
# Script name   : DLY_RECONCILIATION.sh
#
# Description   : This script is to run the daily reconciliation report
#
# Created  : 11/05/2014 jxc517 CCN Project Team.....
# Modified : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
##############################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="DLY_RECONCILIATION"
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE}
DATE_PREV=${DAILY_PREV_RUNDATE}
echo "Processing Started for $proc_name at $TIME on $DATE"

./EXEC_PROC_1PARAM.sh "SD_DAILY_RECS_REPORT.DISPLAY_AMOUNTS" "$DATE_PREV"

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

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
