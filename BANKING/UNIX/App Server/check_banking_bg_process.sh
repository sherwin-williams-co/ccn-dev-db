#!/bin/sh
#################################################################
# Script name   : check_banking_bg_process.sh
#
# Description   : This script is used to check whether the background process is running for 
#                 the banking job. If it is not executing then send an email.
#
# Created  : 09/30/2016 mxk766 CCN Project Team.....
# Modified :
#################################################################

. /app/banking/dev/banking.config

#Read Variables
LOGDIR=$HOME/logs
THISSCRIPT="check_banking_bg_process"
DATE=`date +"%m%d%Y"`
TIME=`date +"%H%M%S"`
LOG_NAME=${THISSCRIPT}_${DATE}_${TIME}.log
BG_PROCESSES_EXECUTING=TRUE

#Background process names.
SRA1100_BP=SRA1100_bp.sh
DEPOSITS_ORDER_BP=deposits_order_bp.sh
HOST_UNIX_COMMAND_BP=host_unix_command.sh


touch $LOGDIR/$LOG_NAME

echo "Processing Started for "$THISSCRIPT " at "$TIME "on "$DATE >> $LOGDIR/${LOG_NAME}

#Email function which is used to send emails.
SendEmail () {
sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw << END >> $LOGDIR/${LOG_NAME}
set heading off;
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
}

##############################################
#  ERROR STATUS CHECK
##############################################
StatusCheck()
{
if test $1 -ne 0
   then
     TIME=`date +"%H:%M:%S"`
     echo "processing of "$THISSCRIPT " failed at ${TIME} on ${DATE}">> $LOGDIR/${LOG_NAME}
     exit 1;
else
   echo $2 >> $LOGDIR/${LOG_NAME}
fi
}
#######################################
#  Start of background process check  #
#######################################

FIND=`ps -elf | grep $SRA1100_BP | grep -v grep`
if [ "$FIND" == "" ]
then
BG_PROCESSES_EXECUTING=FALSE
SendEmail SRA1100_BP_ERROR
fi
status=$?
StatusCheck $status "Status code to check the background process SRA1100_bp.sh is "$status
#check for the process deposits_order_bp in banking.
FIND=`ps -elf | grep $DEPOSITS_ORDER_BP | grep -v grep`
if [ "$FIND" == "" ]
then
BG_PROCESSES_EXECUTING=FALSE
SendEmail DEPOSITS_ORDER_BP_ERROR
fi
status=$?
StatusCheck $status "Status code to check the background process deposits_order_bp.sh is "$status
#check for the process host_unix_command in banking.
FIND=`ps -elf | grep $HOST_UNIX_COMMAND_BP | grep -v grep`
if [ "$FIND" == "" ]
then
BG_PROCESSES_EXECUTING=FALSE
SendEmail HOST_UNIX_COMMAND_BP_ERROR
fi
status=$?
StatusCheck $status "Status code to check the background process host_unix_command.sh is "$status

if [ "$BG_PROCESSES_EXECUTING" == "TRUE" ]
then
SendEmail ALL_BG_PROCESSES_EXECUTING
fi
status=$?
StatusCheck $status "Background success send email send status is  "$status" and flag is "$BG_PROCESSES_EXECUTING

echo "ending check_banking_bg_process.sh script" >> $LOGDIR/${LOG_NAME}

##############################
#  end of script             #
##############################