#!/bin/sh -e
#################################################################################################################################
# Script name   : send_batch_err_status_mail.sh
#
# Description   : purpose of this script will be to send error status mail when a batch fails due to any kind of error
#
# Created  : 01/13/2016 AXK326 CCN Project Team.....
# Modified : 
#################################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

err_name=$1
proc_name=send_batch_err_status_mail
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE} 
echo "Processing Started for $proc_name - $err_name at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END
set heading off;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
 MAIL_PKG.send_mail('$err_name');
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
     echo "processing FAILED for $proc_name - $err_name at ${TIME} on ${DATE}"
	 rm -f BATCH_DEPENDENCY.OK;
	 echo "" > BATCH_DEPENDENCY.NOT_OK
	 echo "NOT OK file is created in dailyLoad folder"
     exit 1;
fi

rm -f BATCH_DEPENDENCY.OK;
echo "" > BATCH_DEPENDENCY.NOT_OK
echo "NOT OK file is created in dailyLoad folder"
echo "Processing finished for $proc_name - $err_name at ${TIME} on ${DATE}"  
exit 0
############################################################################
