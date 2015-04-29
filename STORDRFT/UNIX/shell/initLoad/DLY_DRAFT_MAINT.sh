#!/bin/sh
#################################################################
# Script name   : DLY_DRAFT_MAINT.sh
#
# Description   : This script is to run the daily maintenance load for AutoMotive and Non AutoMotive
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 11/12/2014 axk326 CCN Project Team.....
#            Removed ftp code to separate process.
#          : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value to pick the date value from config file
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="DLY_DRAFT_MAINT"
TIME=`date +"%H:%M:%S"`
P1=${DAILY_LOAD_RUNDATE}
echo "Processing Started for $proc_name at $TIME for the date $P1"

./DLY_MAINT_DRAFT_US_AM.sh
./DLY_MAINT_DRAFT_US_NAM.sh

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
P1=${DAILY_LOAD_RUNDATE}
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} for the date ${P1}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} for the date ${P1}"  

exit 0
############################################################################
