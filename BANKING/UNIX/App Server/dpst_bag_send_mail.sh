#!/bin/sh
#################################################################
# Script name   : dpst_bag_send_mail.sh
#
# Description   : This scripts is created to send the email if
#                 error occurs in depost bag order files ftp process.
#
# Created  : 01/16/2017 gxg192 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="deposit_bag_send_mail"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
category=$1
file=$2
CC=${file:12:6}

echo "Processing Started for $proc_name at $TIME on $DATE"
sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw << END
set heading off;
set serveroutput on;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
  :exitCode := 0;
  MAIL_PKG.send_mail('$category',null,'$CC','$HOME');
EXCEPTION
  WHEN OTHERS THEN
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
    echo "processing FAILED for Sending Mail at ${TIME} on ${DATE}"
    exit 1;
fi
############################################################################

TIME=`date +"%H:%M:%S"`
echo "Processing Finished for $proc_name at $TIME on $DATE"

exit 0
