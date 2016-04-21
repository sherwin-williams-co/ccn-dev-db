#!/bin/sh
#################################################################################################################################
# Script name   : check_file_ok_status.sh
#
# Description   : purpose of this script will be to search for a particular file in a folder
#
# Created  : 01/21/2016 AXK326 CCN Project Team.....
#            This script will exist in $HOME/dailyLoad folder and all existing trigger file checks including any new ones coming in future 
#            should be placed in the same folder alone.
# Modified :
#################################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name=check_file_ok_status
file_name=$1
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE}
echo "Processing Started for $proc_name at $TIME on $DATE"

#Check to see if the trigger file paids_mntnc_check.ok exists or not
if ls $file_name; then
   echo " $file_name file exists in dailyLoad folder "
else
   echo " $file_name file do not exist in dailyLoad folder "
   ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
   exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "  Processing finished for $proc_name at $TIME on $DATE "

exit 0