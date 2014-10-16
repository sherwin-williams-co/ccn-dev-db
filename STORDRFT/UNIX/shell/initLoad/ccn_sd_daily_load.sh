#!/bin/sh
#############################################################################
# Script Name   :  ccn_sd_daily_load
#
# Description    : This shell program will initiate the script that 
#
#    * Loads all the store drafts tables
#
# It also sends the emails regarding starting and ending of the process
#
# Created           :  08/19/2014
# Modified          :  
############################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 proc="ccn_sd_daily_load"
 LOGDIR="$HOME/initLoad/STORDRFT"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

##############################################################################
# Run the shell script to concatenate the daily files and archiving the individual files
##############################################################################
./dailyLoad_CAT_Archieve.sh

##############################################################################
# Load the data from cpr into stordrft database
##############################################################################
./cc_employee_tax_load.sh

##############################################################################
# Load the daily drafts data from files into stordrft database
##############################################################################
./daily_drafts_load.sh

##############################################################################
# Load the daily paids data from files into stordrft database
##############################################################################
./daily_paids_load.sh

##############################################################################
# Call for the daily issue interface files into stordrft database
##############################################################################
./DLY_DRAFT_LOAD.sh

##############################################################################
#  Execute employee_details_sync.sh to sync the employee details to TERR and MANAGER
##############################################################################
cd $HOME/batchJobs
./employee_details_sync.sh

#################################################
#    ERROR STATUS CHECK employee_details_sync.sh 
#################################################
status=$?
if test $status -ne 0
   then
     echo "processing FAILED for employee_details_sync at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing Finished for employee_details_sync at ${TIME} on ${DATE}"

exit 0

############################################################################

