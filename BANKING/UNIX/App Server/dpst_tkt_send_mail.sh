#!/bin/sh
#################################################################
# Script name   : dpst_tkt_send_mail.sh
#
# Description   : this scripts will send the email to let us know that the deposit ticket
#                 created is missing its corresponding file
#
# Created  : 08/30/2016 nxk927 CCN Project Team.....
# Modified : 08/30/2016 nxk927 CCN Project Team.....
#            passing the path as parameter
#          : 01/16/2017 gxg192 Passing category as parameter
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="deposit_tkt_send_mail"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
category=$1
file=$2
CC=${file:15:6}

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
    echo "processing FAILED for Sending Mail at ${TIME} on ${DATE}"
    exit 1;
fi

############################################################################
echo "DEPOSIT TICKET FILES for cost center $CC is being moved to recovered folder."
date=`date +"%m%d%Y%H%M%S"`
mv $HOME/datafiles/$file.xml $HOME/datafiles/recovered_file/$file"_"$date.xml
mv $HOME/datafiles/$file.txt $HOME/datafiles/recovered_file/$file"_"$date.txt
TIME=`date +"%H:%M:%S"`
echo "DEPOSIT TICKET FILES for cost center $CC has been placed in recovered_file folder at ${TIME} on ${DATE}"

TIME=`date +"%H:%M:%S"`
echo "Processing Finished for $proc_name at $TIME on $DATE"

exit 0
