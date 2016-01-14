set -e
#!/bin/sh 
###########################################################################################################
# Script Name    :  batch_dependency_not_ok_check.sh
#
# Description    :  This shell program will search for the BATCH_DEPENDENCY.NOT_OK file in dailyLoad folder
# Created        :  AXK326 01/12/2016 CCN Project Team....
# Modified       :  
###########################################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/stordrft/host.sh

cd $HOME/dailyLoad

proc_name="batch_dependency_not_ok_check"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

#Check to see if the trigger file BATCH_DEPENDENCY.NOT_OK exists or not
if ls BATCH_DEPENDENCY.NOT_OK; then
   echo "  BATCH_DEPENDENCY.NOT_OK file exists in dailyLoad folder "   
   TIME=`date +"%H:%M:%S"`
   echo "  Processing finished for $proc_name at $TIME on $DATE "   
   ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
   exit 1
else
   echo "  BATCH_DEPENDENCY.NOT_OK file do not exist "  
   TIME=`date +"%H:%M:%S"`   
   echo "  Processing finished for $proc_name at $TIME on $DATE "
fi

exit 0