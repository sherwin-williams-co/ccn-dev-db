#!/bin/sh
#############################################################################################################################
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
#          : 11/18/2015 axk326 CCN Project Team.....
#            Added Error handling calls to send email when ever the script errors out due to any of the OSERROR or SQLERROR
#          : 3/18/2016 nxk927 CCN Project Team.....
#            Changed the order of declaring variables after capturing the STATUS to avoid the scenario where
#            the ERROR CODE that needs to be captured, will not be overwritten in the ERROR STATUS CHECK block
#############################################################################################################################
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
status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
