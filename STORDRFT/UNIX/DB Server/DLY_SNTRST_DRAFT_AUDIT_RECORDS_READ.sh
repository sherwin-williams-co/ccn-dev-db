#!/bin/sh
#############################################################################################################################
# Script name   : DLY_SNTRST_DRAFT_AUDIT_RECORDS_READ.sh
#
# Description   : This script is to run the daily read suntrust draft audit records report
#
# Created  : 02/27/2017 axt754 CCN Project Team.....
##############################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="DLY_SNTRST_DRAFT_AUDIT_RECORDS_READ"
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE}
DATE_PREV=${DAILY_PREV_RUNDATE}
echo "Processing Started for $proc_name at $TIME on $DATE"

./EXEC_PROC_1PARAM.sh "SD_DAILY_RECS_REPORT.SD_AUDIT_REC_READ_AMT_SPLT" "$DATE_PREV"

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
