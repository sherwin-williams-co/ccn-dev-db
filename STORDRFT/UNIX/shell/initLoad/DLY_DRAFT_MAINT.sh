#!/bin/sh -e
#############################################################################################################################
# Script name   : DLY_DRAFT_MAINT.sh
#
# Description   : This script is to run the daily maintenance load for AutoMotive and Non AutoMotive
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 11/12/2014 axk326 CCN Project Team.....
#            Removed ftp code to separate process.
#          : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
#          : 11/18/2015 axk326 CCN Project Team.....
#            Added Error handling calls to send email when ever the script errors out due to any of the OSERROR or SQLERROR
#          : 01/12/2016 axk326 CCN Project Team.....
#            Added shell script call to check if the PAIDS_MNTNC_CHECK.OK file exists or not before proceeding further
#            Added shell script call to rename the ok trigger files to no_ok in case of failure
#############################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

# below command will invoke the mntnc_dpndncy_ok_check shell script to check if the trigger file exists or not
./mntnc_dpndncy_ok_check.sh
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then
     exit 1;
fi

proc_name="DLY_DRAFT_MAINT"
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE} 
echo "Processing Started for $proc_name at $TIME on $DATE"

./DLY_MAINT_DRAFT_US_AM.sh
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
	 ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
	 ./rename_file_ok_to_notok.sh PAIDS_MNTNC_CHECK.OK PAIDS_MNTNC_CHECK.NOT_OK
	 ./rename_file_ok_to_notok.sh MNTNC_DPNDNCY_CHECK.OK MNTNC_DPNDNCY_CHECK.NOT_OK
     exit 1;
fi

./DLY_MAINT_DRAFT_US_NAM.sh

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
	 ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
	 ./rename_file_ok_to_notok.sh PAIDS_MNTNC_CHECK.OK PAIDS_MNTNC_CHECK.NOT_OK
	 ./rename_file_ok_to_notok.sh MNTNC_DPNDNCY_CHECK.OK MNTNC_DPNDNCY_CHECK.NOT_OK
     exit 1;
fi

rm -f PAIDS_MNTNC_CHECK.OK
echo "PAIDS_MNTNC_CHECK.OK file deleted as all the process have completed successfully"
rm -f MNTNC_DPNDNCY_CHECK.OK
echo "MNTNC_DPNDNCY_CHECK.OK file deleted as all the process have completed successfully"
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
