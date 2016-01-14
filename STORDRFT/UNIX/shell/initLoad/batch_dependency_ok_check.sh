set -e
#!/bin/sh 
###########################################################################################################
# Script Name    :  batch_dependency_ok_check.sh
#
# Description    :  This shell program will search for the BATCH_DEPENDENCY.OK file in dailyLoad folder
# Created        :  AXK326 01/08/2016 CCN Project Team....
# Modified       :  
###########################################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/stordrft/host.sh

cd $HOME/dailyLoad

proc_name="batch_dependency_ok_check"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

#Check to see if the trigger file BATCH_DEPENDENCY.OK exists or not
if ls BATCH_DEPENDENCY.OK; then
   echo "  BATCH_DEPENDENCY.OK file exists in dailyLoad folder "
else
   echo "  BATCH_DEPENDENCY.OK file do not exist "
   ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
   exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "  Processing finished for $proc_name at $TIME on $DATE "
exit 0