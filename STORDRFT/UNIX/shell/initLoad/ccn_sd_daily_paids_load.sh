#!/bin/sh
#################################################################
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
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="ccn_sd_daily_paids_load"
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE} 
echo "Processing Started for $proc at $TIME on $DATE"

##############################################################################
# Run the shell script to concatenate the daily files and archiving the individual files
##############################################################################
./dailyLoad_CAT_Archieve_Paids.sh

##############################################################################
# Load the daily paids data from files into stordrft database
##############################################################################
./daily_paids_load.sh

##############################################################################
# Run the shell script to archive individual files for Royal and Suntrust
##############################################################################
./Archive_dailyLoad_Paid_Files.sh

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0
############################################################################
