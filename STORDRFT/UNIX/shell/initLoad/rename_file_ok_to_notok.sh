#!/bin/sh -e
#################################################################################################################################
# Script name   : rename_file_ok_to_notok.sh
#
# Description   : purpose of this script will be to rename the file from BATCH_DEPENDENCY_CHECK.OK to BATCH_DEPENDENCY_CHECK.NOT_OK 
#                 due to any kind of error
#
# Created  : 01/14/2016 AXK326 CCN Project Team.....
# Modified : 
#################################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name=rename_file_ok_to_notok
from_file_name=$1
to_file_name=$2
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE} 
echo "Processing Started for $proc_name at $TIME on $DATE"

rm -f $from_file_name
echo "" > $to_file_name
echo "$to_file_name file is created in dailyLoad folder"

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then
     echo "processing FAILED for $proc_name - $err_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name - $err_name at ${TIME} on ${DATE}"  
exit 0