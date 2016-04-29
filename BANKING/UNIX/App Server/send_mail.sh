#!/bin/sh
#################################################################
# Script name   : send_mail.sh
# Description   : This shell script will send email  for the passed category as parameter
#
# Created  : 03/04/2016 dxv848/nxk927 CCN Project Team.....
# Modified : 04/27/2016 nxk97 CCN Project Team.....
#            updated the comments and the updated the error handling to exit out if any error found
#            removed variable TIMESTAMP
#################################################################
. /app/banking/dev/banking.config


proc_name=$1;

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

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
MAIL_PKG.send_mail('$1');
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
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for Sending Mail at ${TIME} on ${DATE}"
    exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing Finished for $proc_name at ${TIME} on ${DATE}"
exit 0

############################################################################