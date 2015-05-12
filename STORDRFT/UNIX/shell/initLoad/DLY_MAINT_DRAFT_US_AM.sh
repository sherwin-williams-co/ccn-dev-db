#!/bin/sh
#################################################################
# Script name   : DLY_MAINT_DRAFT_US_AM.sh
#
# Description   : This script is to run the SD_AUDITFILES_PKG.CREATE_US_AUTO_BANK_FILE
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 11/12/2014 axk326 CCN Project Team.....
#            Date logic modified to run on every day.
#            11/13/2014 axk326 CCN Project Team.....
#            Procedure name modified in the package. 
#          : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="DLY_MAINT_DRAFT_US_AM"
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE}
echo "Processing Started for $proc_name at $TIME on $DATE"

./EXEC_PROC_1PARAM.sh "SD_AUDITFILES_PKG.CREATE_US_AUTO_BANK_FILE" "$DATE"

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
