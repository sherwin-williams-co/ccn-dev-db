#!/bin/sh 
############################################################################################################################
# Script name   : EXEC_PROC_1PARAM.sh
#
# Description   : Wrapper for executing procedures with 1 date parameter,
#                 accepts proc name and week number as parameters 1 and 2
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 11/18/2015 axk326 CCN Project Team.....
#            Added Error handling calls to send email when ever the script errors out due to any of the OSERROR or SQLERROR 
#          : 01/12/2016 axk326 CCN Project Team.....
#            Added shell script call to check if the .OK file exists or not before proceeding further
#            Added call to remove the regular .OK file and recreate the .NOT_OK file in dailyLoad folder
############################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

# below command will invoke the batch_dependency_ok_check shell script to check if the trigger file exists or not
./batch_dependency_ok_check.sh 
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then
     echo "OK file do not exists - process exiting out "
	 ./send_batch_err_status_mail.sh SD_BATCH_PROCESSING_ERROR
     exit 1;
fi

proc_name=$1"(to_date('$2','MM/DD/YYYY'));"
LOGDIR=$HOME/dailyLoad/logs
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$1"_"$TimeStamp.log <<END
set heading off;
set serveroutput on;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
$proc_name
Exception 
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then
     cd $HOME/dailyLoad
     ./send_err_status_email.sh EXEC_PROC1_PARAM_ERROR
	 ./send_batch_err_status_mail.sh SD_BATCH_PROCESSING_ERROR
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
