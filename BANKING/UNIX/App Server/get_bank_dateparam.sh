#!/bin/sh
##############################################################################################################
# Script Name : get_bank_dateparam.sh
#
# Description : This shell script will get dates information to get_bank_dateparam.config file
#               by spooling from banking_param table.
#
# Created     : 06/27/2016 mxk766 CCN Project Team....
##############################################################################################################

. /app/banking/dev/banking.config

proc="get_bank_dateparam"
file_name=$1 
LOGDIR=$HOME/logs 
DATE=`date +"%m-%d-%Y"`
TIME=`date +"%H%M%S"` 
LOG_NAME=${proc}_${DATE}_${TIME}.log
# below command will invoke the check_bank_file_ok_status shell script to check if the batch_dependency.ok file exists or not

touch $LOGDIR/$LOG_NAME

echo "Checking file availability of batch_dependency.ok file Started at  $TIME on $DATE ">>$LOGDIR/$LOG_NAME

./check_bank_file_ok_status.sh batch_dependency.ok
############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?

echo "Status of file check batch_dependency.ok is "$status>>$LOGDIR/$LOG_NAME 

if [ $status -ne 0 ]
then
     TIME=`date +"%H:%M:%S"`
     echo "Processing failed for get_dateparam at $TIME on $DATE">>$LOGDIR/$LOG_NAME 
     exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "Begin Get Parameter: Processing Started for $proc at $TIME on $DATE">>$LOGDIR/$LOG_NAME 
sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw <<EOF
set pages 0
set feedback off
set linesize 500
column "Newline Character" noprint new_value newline_char
select chr(10) "Newline Character" from dual;
set colsep "&newline_char"
undefine newline_char
column "Newline Character" clear
set recsep each

spool $HOME/bank_date_param_temp.config

SELECT 'DAILY_LOAD_RUNDATE='|| To_char(DAILY_LOAD_RUNDATE, 'mm/dd/yyyy'),
       'TICKET_TRACKING_RUNDATE='||To_char(TICKET_TRACKING_RUNDATE, 'mm/dd/yyyy'),
       'BAG_TRACKING_RUNDATE='||To_char(BAG_TRACKING_RUNDATE, 'mm/dd/yyyy')
  FROM BANKING_PARAM;

spool off
exit;

EOF

#Move to the home directory and rename the temp file to original file.
cd $HOME

mv -f bank_date_param_temp.config bank_date_param.config

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for Get Parameter at $TIME on $DATE">>$LOGDIR/$LOG_NAME 
     cd $HOME/dailyLoad
     ./send_mail.sh BANKING_BATCH_PROCESSING_ERROR
     ./rename_file_ok_to_notok.sh batch_dependency
     exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "End Get Parameter: Processing finished for $proc at ${TIME} on ${DATE}">>$LOGDIR/$LOG_NAME 
############################################################################

exit 0