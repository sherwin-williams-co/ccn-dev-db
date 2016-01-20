#!/bin/sh 
###########################################################################################################
# Script Name    :  batch_dependency_ok_check.sh
#
# Description    :  This shell program will search for the batch_dependency.ok file in dailyLoad folder
# Created        :  AXK326 01/08/2016 CCN Project Team....
# Modified       :  
###########################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

cd $HOME/dailyLoad

proc_name="batch_dependency_ok_check"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

#Check to see if the trigger file batch_dependency.ok exists or not
if ls batch_dependency.ok; then
   echo "  batch_dependency.ok file exist in dailyLoad folder "
else
   echo "  batch_dependency.ok file do not exist in dailyLoad folder "
   ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
   exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "  Processing finished for $proc_name at $TIME on $DATE "
exit 0