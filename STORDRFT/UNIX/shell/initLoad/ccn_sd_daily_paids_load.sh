#!/bin/sh
#################################################################
# Script name   : ccn_sd_daily_paids_load.sh
#
# Description   : This shell program will initiate the script that
#                 Loads all the store drafts tables paid details
#				  
# Created  : 11/05/2014 axk326 CCN Project Team.....
# Modified : 
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="ccn_sd_daily_paids_load"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
echo "Processing Started for $proc at $TIME on $DATE"

##############################################################################
# Load the daily drafts data from files into stordrft database
##############################################################################
./daily_paids_load.sh


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
