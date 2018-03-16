#!/bin/sh
##############################################################################################################
# Script name   : 90_day_void_pay_report.sh
#
# Description   : This shell program will update STORE DRAFT table and generate 90 day pay report
#
# Created       : 03/12/2018 bxa919 CCN Project Team....
# Modified      : 
##############################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="90_day_void_pay_report"
LOGDIR="$HOME/initLoad/logs"
TIME=`date +"%H:%M:%S"`
DATE=${JV_MNTLY_RUNDATE}
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
SD_FILE_BUILD_PKG.VOID_90_DAY_MARK_BY_CCN(TO_DATE('$DATE','MM/DD/YYYY'));
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
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     $HOME/send_mail.sh "SD_90_DAY_VOID_PAY_RPT_FAILURE"
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  
exit 0
############################################################################