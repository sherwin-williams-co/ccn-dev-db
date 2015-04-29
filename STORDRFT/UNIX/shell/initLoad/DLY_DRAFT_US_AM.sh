#!/bin/sh
#################################################################
# Script name   : DLY_DRAFT_US_AM.sh
#
# Description   : This script is to run the SD_BANKFILES_PKG.CREATE_US_AUTO_BANK_FILE
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 11/12/2014 nxk927 CCN Project Team.....
#            Date logic modified to run on every day. 
#          : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value to pick the date value from config file
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="DLY_DRAFT_US_AM"
TIME=`date +"%H:%M:%S"`
P1=${DAILY_LOAD_RUNDATE}

echo "Processing Started for $proc_name at $TIME for the date $P1"

./EXEC_PROC_1PARAM.sh "SD_BANKFILES_PKG.CREATE_US_AUTO_BANK_FILE" "$P1" 

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
