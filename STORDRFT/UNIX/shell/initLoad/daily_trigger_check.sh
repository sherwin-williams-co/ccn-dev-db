set -e
#!/bin/sh 
###########################################################################################################
# Script Name    :  daily_trigger_check.sh
#
# Description    :  This shell program will search for the DAILY_LOADS.TRG file in dailyLoad folder
# Created        :  AXK326 01/08/2016 CCN Project Team....
# Modified       :  
###########################################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/stordrft/host.sh

cd $HOME/dailyLoad

proc_name="daily_trigger_check"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

#Check to see if the trigger file DAILY_LOADS.TRG exists or not
if ls DAILY_LOADS.TRG; then
   echo "  DAILY_LOADS Trigger file exists in dailyLoad folder "
else
   echo "  DAILY_LOADS Trigger file do not exist "
   exit 1
fi

echo "  Processing finished for $proc_name at $TIME on $DATE "