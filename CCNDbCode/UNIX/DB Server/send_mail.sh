#!/bin/sh
#################################################################
# Script name   : send_mail.sh
# Description   : This shell script will send email  for the passed category as parameter
#
# Created  : 10/03/2016 MXK766 CCN Project ....
# Modified : 08/31/2017 rxv940 CCN Project ....
#          : Call to send_mail now has positional parameters 
#################################################################
. /app/ccn/host.sh


proc_name="send_mail.sh"

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

echo "Processing Started for $proc_name at $TIME on $DATE"

$ORACLE_HOME/bin/sqlplus -s -l $sqlplus_user/$sqlplus_pw << END
set heading off;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
MAIL_PKG.send_mail('$1', NULL, NULL, '$2');
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
    exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "Processing Finished for $proc_name at ${TIME} on ${DATE}"
exit 0

############################################################################
