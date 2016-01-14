set -e
#!/bin/sh 
###########################################################################################################
# Script Name    :  paids_mntnc_ok_check.sh
#
# Description    :  This shell program will search for the PAIDS_MNTNC_CHECK.OK file in dailyLoad folder
# Created        :  AXK326 01/14/2016 CCN Project Team....
# Modified       :  
###########################################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/stordrft/host.sh

cd $HOME/dailyLoad

proc_name="paids_mntnc_ok_check"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

#Check to see if the trigger file PAIDS_MNTNC_CHECK.OK exists or not
if ls PAIDS_MNTNC_CHECK.OK; then
   echo "  PAIDS_MNTNC_CHECK.OK file exists in dailyLoad folder "
else
   echo "  PAIDS_MNTNC_CHECK.OK file do not exist "
   exit 1
fi

echo "  Processing finished for $proc_name at $TIME on $DATE "
exit 0