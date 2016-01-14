#!/bin/sh -e
##################################################################################################################################
# Script name   : ccn_hierarchy_info.sh
#
# Description   : This script will invoke SD_REPORT_PKG.CCN_HIERARCHY_INFO
#
# Created       : 10/22/2014 jxc517 CCN Project Team.....
# Modified      : 04/28/2015 axk326 CCN Project Team.....
#                 Added parameter to pick up the date from the config file 
#               : 11/18/2015 axk326 CCN Project Team.....
#                 Added Error handling calls to send email when ever the script errors out due to any of the OSERROR or SQLERROR 
#               : 01/12/2016 axk326 CCN Project Team.....
#                 Added shell script call to check if the .OK file exists or not before proceeding further
#                 Added call to remove the regular .OK file and recreate the .NOT_OK file in dailyLoad folder
#################################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

# below command will invoke the batch_dependency_ok_check shell script to check if the trigger file exists or not
 cd $HOME/dailyLoad
./batch_dependency_ok_check.sh 
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then
     echo "OK file do not exists - process exiting out"
	 ./send_batch_err_status_mail.sh SD_BATCH_PROCESSING_ERROR
     exit 1;
fi

proc_name="ccn_hierarchy_info"
LOGDIR=$HOME/dailyLoad/logs
TIME=`date +"%H:%M:%S"`
DATE=${SD_REPORT_QRY_RUNDATE}
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

echo " START TRUCATING AND LOADING : Process Started at $TIME on $DATE "

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQKERROR EXIT 1
BEGIN
:exitCode := 0;
SD_REPORT_PKG.CCN_HIERARCHY_INFO();
EXCEPTION
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then
     cd $HOME/dailyLoad
	 ./send_err_status_email.sh CCN_HIERARCHY_INFO_LOAD_ERROR
	 ./send_batch_err_status_mail.sh SD_BATCH_PROCESSING_ERROR
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
