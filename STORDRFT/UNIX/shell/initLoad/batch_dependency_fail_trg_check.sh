set -e
#!/bin/sh 
###########################################################################################################
# Script Name    :  batch_dependency_fail_trg_check.sh
#
# Description    :  This shell program will search for the DAILY_LOADS_FAILURE.TRG file in dailyLoad folder
# Created        :  AXK326 01/12/2016 CCN Project Team....
# Modified       :  
###########################################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/stordrft/host.sh

cd $HOME/dailyLoad

proc_name="batch_dependency_fail_trg_check"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

#Check to see if the trigger file DAILY_LOADS_FAILURE.TRG exists or not
if ls DAILY_LOADS_FAILURE.TRG; then
   echo "  DAILY_LOADS_FAILURE Trigger file exists in dailyLoad folder " 
   echo "  Processing finished for $proc_name at $TIME on $DATE "   
   exit 1
else
   echo "  DAILY_LOADS_FAILURE Trigger file do not exist "   
   echo "  Processing finished for $proc_name at $TIME on $DATE "
fi
exit 0