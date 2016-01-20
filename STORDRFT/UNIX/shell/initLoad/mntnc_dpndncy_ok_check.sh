#!/bin/sh 
###########################################################################################################
# Script Name    :  mntnc_dpndncy_ok_check.sh
#
# Description    :  This shell program will search for the mntnc_dpndncy_check.ok file in dailyLoad folder
# Created        :  AXK326 01/14/2016 CCN Project Team....
# Modified       :  
###########################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

cd $HOME/dailyLoad

proc_name="paids_mntnc_ok_check"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

#Check to see if the trigger file mntnc_dpndncy_check.ok and paids_mntnc_check.ok files exists or not
if [ -f mntnc_dpndncy_check.ok ] && [ -f paids_mntnc_check.ok ] ; then
   echo "  mntnc_dpndncy_check.ok and paids_mntnc_check.ok files exists in dailyLoad folder "
else
   echo "  mntnc_dpndncy_check.ok and paids_mntnc_check.ok files do not exists in dailyLoad folder  "
   ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
   exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "  Processing finished for $proc_name at $TIME on $DATE "
exit 0

