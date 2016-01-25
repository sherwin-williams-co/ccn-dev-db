#!/bin/sh
##############################################################################################################
# Script name   : 1099_FSS_file_mail.sh
#
# Description   : This script is to send email communication about the FSS file to erp team
#
# Created  : 01/12/2016 jxc517 CCN Project Team.....
# Modified :            
##############################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="1099_FSS_file_mail"
LOGDIR="$HOME/initLoad/logs"
TIME=`date +"%H:%M:%S"`
DATE=`date '+%Y%m%d'`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set serveroutput on;
set verify off;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
var exitCode number;
BEGIN
:exitCode := 0;
MAIL_PKG.SEND_MAIL('SD_1099_FSS_FILE_STATUS');
EXCEPTION
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
     ./send_err_status_email.sh SD_1099_FSS_FILE_STATUS_ERROR
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
