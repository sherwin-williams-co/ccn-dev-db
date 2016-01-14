#!/bin/sh -e
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
#            Added shell script call to check if the PAIDS_MNTNC_CHECK.OK file exists or not before proceeding further
################################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

# below command will invoke the paids_mntnc_ok_check shell script to check if the trigger file exists or not
./paids_mntnc_ok_check.sh
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then
     exit 1;
fi

proc="ccn_sd_daily_paids_load"
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE} 
echo "Processing Started for $proc at $TIME on $DATE"

########################################################################################
# Run the shell script to concatenate the daily files and archiving the individual files
########################################################################################
./dailyLoad_CAT_Archieve_Paids.sh
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then
     echo "Concatenation and Archiving Store Drafts Paids process failed"
	 ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
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
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then
     echo "daily paids load process exiting out"
	  ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
     exit 1;
fi

##############################################################################
# Run the shell script to archive individual files for Royal and Suntrust
##############################################################################
./Archive_dailyLoad_Paid_Files.sh

##############################################################################
#                           ERROR STATUS CHECK 
##############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if [ $status -ne 0 ]; then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
	 ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
     exit 1;
fi

echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0
############################################################################
