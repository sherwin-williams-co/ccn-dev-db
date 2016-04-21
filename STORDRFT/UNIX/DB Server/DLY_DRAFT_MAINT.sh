#!/bin/sh
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
#            Added shell script call to check if the mntnc_dpndncy_check.ok and paids_mntnc_check.ok files exists or not before proceeding further
#            Added shell script call to rename the .ok trigger files to .not_ok trigger files in case of failure
#          : 3/18/2016 nxk927 CCN Project Team.....
#            Changed the order of declaring variables after capturing the STATUS to avoid the scenario where
#            the ERROR CODE that needs to be captured, will not be overwritten in the ERROR STATUS CHECK block
#          : 3/24/2016 nxk927 CCN Project Team.....
#            Removed all the Un necessary declared time variable and added error messages for check_file_ok status
#            changed the error check to make it uniform
#############################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="DLY_DRAFT_MAINT"
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE}

# below command will invoke the check_file_ok_status shell script to check if the mntnc_dpndncy_check.ok file exists or not
./check_file_ok_status.sh mntnc_dpndncy_check.ok
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
	 echo "Processing failed for DLY_DRAFT_MAINT-mntnc_dpndncy_check at $TIME on $DATE"
	 exit 1;
fi

# below command will invoke the check_file_ok_status shell script to check if the paids_mntnc_check.ok file exists or not
./check_file_ok_status.sh paids_mntnc_check.ok
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
	 echo "Processing failed for DLY_DRAFT_MAINT-paids_mntnc_check at $TIME on $DATE"
     exit 1;
fi

echo "Processing Started for $proc_name at $TIME on $DATE"

./DLY_MAINT_DRAFT_US_AM.sh
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
	 ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
	 ./rename_file_ok_to_notok.sh paids_mntnc_check
	 ./rename_file_ok_to_notok.sh mntnc_dpndncy_check
     exit 1;
fi

./DLY_MAINT_DRAFT_US_NAM.sh

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
	 ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
	 ./rename_file_ok_to_notok.sh paids_mntnc_check
	 ./rename_file_ok_to_notok.sh mntnc_dpndncy_check
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
