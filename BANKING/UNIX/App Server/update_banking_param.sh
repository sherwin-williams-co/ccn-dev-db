#!/bin/sh
###############################################################################################################################
# Script Name : update_banking_param.sh
#
# Description : 
#
# Created     : 06/27/2016 mxk766 CCN Project Team...
# Modified    : 
##############################################################################################################################

. /app/banking/dev/banking.config

LOGDIR=$HOME/logs
THISSCRIPT="update_banking_param" 
DATE=`date +"%m-%d-%Y"`
TIME=`date +"%H%M%S"` 
LOG_NAME=${THISSCRIPT}_${DATE}_${TIME}.log
proc="update_banking_param"

touch $LOGDIR/$LOG_NAME

echo "Checking file availability of batch_dependency.ok file Started at  $TIME on $DATE ">>$LOGDIR/$LOG_NAME
# below command will invoke the check_bank_file_ok_status shell script to check if the batch_dependency.ok file exists or not
./check_bank_file_ok_status.sh batch_dependency.ok

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?

echo "Status of file check batch_dependency.ok is "$status>>$LOGDIR/$LOG_NAME

if [ $status -ne 0 ]
then
    exit 1
fi

echo "Begin Get Parameter: Processing Started for $proc at $TIME on $DATE">>$LOGDIR/$LOG_NAME

sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw <<EOF
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
UPDATE BANKING_PARAM 
   SET DAILY_LOAD_RUNDATE = TRUNC(SYSDATE),
       TICKET_TRACKING_RUNDATE = TRUNC(SYSDATE), 
       BAG_TRACKING_RUNDATE = TRUNC(SYSDATE);
COMMIT;
Exception
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode
EOF

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?

TIME=`date +"%H:%M:%S"` 
DATE=`date +"%m-%d-%Y"`

echo "Begin Get Parameter: Processing Ended for $proc at $TIME on $DATE">>$LOGDIR/$LOG_NAME


if [ $status -ne 0 ]
then
     cd $HOME/dailyLoad
     ./send_mail.sh UPD_BANKING_PARAM_ERROR
     ./rename_file_ok_to_notok.sh batch_dependency
     exit 1
fi

TIME=`date +"%H:%M:%S"` 
DATE=`date +"%m-%d-%Y"`

echo "End Get Parameter: Processing finished for $proc at ${TIME} on ${DATE}">>$LOGDIR/$LOG_NAME
############################################################################

exit 0