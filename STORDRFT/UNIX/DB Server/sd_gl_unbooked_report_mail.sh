#!/bin/sh
#################################################################
# Script name   : sd_gl_unbooked_report_mail.sh
#
# Description   : This script is to run the GAINLOSS_JV_PKG.CREATE_GAINLOSS_UNBOOKED_RPRT to send unbooked report
#
# Created  : 01/12/2016 jxc517 CCN Project Team....
# Modified : 03/18/2016 nxk927 CCN Project Team....
#            Moved the declared TIME variable at the end
#            Added the message with TIME, DATE AND PROC name to see where it failed in case it fails
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="sd_gl_unbooked_report_mail"
LOGDIR=$HOME/Reports/log
TIME=`date +"%H:%M:%S"`
DATE=${GAINLOSS_MNTLY_RUNDATE}
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set serveroutput on;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
GAINLOSS_JV_PKG.CREATE_GAINLOSS_UNBOOKED_RPRT(to_date('$DATE','MM/DD/YYYY'));
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
if [ $status -ne 0 ]; then
     cd $HOME/dailyLoad
     ./send_err_status_email.sh GAIN_LOSS_JV_UNBOOKED_ERROR
      TIME=`date +"%H:%M:%S"`
     echo "Process Failed for $proc_name at $TIME on $DATE"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

exit 0
############################################################################
