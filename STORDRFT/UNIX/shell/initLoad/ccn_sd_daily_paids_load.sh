#!/bin/sh
################################################################################################################################
# Script name   : ccn_sd_daily_paids_load.sh
#
# Description   : This shell program will initiate the script that
#                 Loads all the store drafts tables paid details
#				  
# Created  : 11/05/2014 axk326 CCN Project Team.....
# Modified : 11/06/2014 jxc517/axk326 CCN Project Team.....
#            Added concatenation and archiving process before run
#          : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
#          : 11/18/2015 axk326 CCN Project Team.....
#            Added -e to the script to catch the errors in subsequent shell scripts while running the daily jobs 
#          : 01/12/2016 axk326 CCN Project Team.....
#            Added shell script call to check if the paids_mntnc_check.ok file exists or not before proceeding further
#            Added shell script call to rename the .ok file to .not_ok file in case of failure
#          : 3/18/2016 nxk927 CCN Project Team.....
#            Changed the order of declaring variables after capturing the STATUS to avoid the scenario where
#            the ERROR CODE that needs to be captured, will not be overwritten in the ERROR STATUS CHECK block
#          : 3/24/2016 nxk927 CCN Project Team.....
#            added error message  for error
################################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="ccn_sd_daily_paids_load"
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE}

# below command will invoke the check_file_ok_status shell script to check if the paids_mntnc_check.ok file exists or not
./check_file_ok_status.sh paids_mntnc_check.ok
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
	 echo "paids_mntnc_check failed for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing Started for $proc at $TIME on $DATE"

########################################################################################
# Run the shell script to concatenate the daily files and archiving the individual files
########################################################################################
./dailyLoad_CAT_Archieve_Paids.sh
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
	 echo "Concatenation and Archiving Store Drafts Paids process failed for $proc at ${TIME} on ${DATE}"
	 ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
	 ./rename_file_ok_to_notok.sh paids_mntnc_check
     exit 1;
fi

##############################################################################
# Load the daily paids data from files into stordrft database
##############################################################################
./daily_paids_load.sh
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
	 echo "daily paids load process exiting out for $proc at ${TIME} on ${DATE}"
	  ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
	  ./rename_file_ok_to_notok.sh paids_mntnc_check
     exit 1;
fi

##############################################################################
# Run the shell script to archive individual files for Royal and Suntrust
##############################################################################
./Archive_dailyLoad_Paid_Files.sh

##############################################################################
#                           ERROR STATUS CHECK 
##############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
	 ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
	 ./rename_file_ok_to_notok.sh paids_mntnc_check
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0
############################################################################
