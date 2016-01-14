set -e
#!/bin/sh 
###########################################################################################################
# Script Name    :  mntnc_dpndncy_ok_check.sh
#
# Description    :  This shell program will search for the MNTNC_DPNDNCY_CHECK.OK file in dailyLoad folder
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

#Check to see if the trigger file MNTNC_DPNDNCY_CHECK.OK exists or not
if [ -f MNTNC_DPNDNCY_CHECK.OK ] && [ -f PAIDS_MNTNC_CHECK.OK ] ; then
   echo "  MNTNC_DPNDNCY_CHECK.OK and PAIDS_MNTNC_CHECK.OK files exists in dailyLoad folder "
else
   echo "  MNTNC_DPNDNCY_CHECK.OK and PAIDS_MNTNC_CHECK.OK files do not exists in dailyLoad folder  "
   ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
   exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "  Processing finished for $proc_name at $TIME on $DATE "
exit 0

