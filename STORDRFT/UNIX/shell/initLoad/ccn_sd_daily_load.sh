#!/bin/sh
#################################################################
# Script name   : ccn_sd_daily_load.sh
#
# Description   : This shell program will initiate the script that 
#                 Loads all the store drafts tables
#                 It also sends the emails regarding starting and ending of the process#
#				  
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 11/05/2014 axk326 CCN Project Team.....
#			 Commented daily_drafts_load.sh and triggered it out in individual cron 
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="ccn_sd_daily_load"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
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
# Call for the daily issue interface files into stordrft database
##############################################################################
./DLY_DRAFT_LOAD.sh

##############################################################################
# Call for the daily reconciliation report
##############################################################################
./DLY_RECONCILIATION.sh

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0
############################################################################
