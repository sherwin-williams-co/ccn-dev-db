#!/bin/sh

#################################################################
# Script name   : check_banking_bg_process.sh
#
# Description   : This script is used to check whether the background process is running for
#                 the costcenter job. If it is not executing then send an email.
#
# Created  : 09/30/2016 mxk766 CCN Project Team.....
# Modified :
#################################################################

# link to parameter file
. /app/ccn/host.sh

#Read Variables.
LOGDIR=$HOME/datafiles
THISSCRIPT="check_costcenter_bg_process"
DATE=`date +"%m%d%Y"`
TIME=`date +"%H%M%S"`
LOG_NAME=${THISSCRIPT}_${DATE}_${TIME}.log
BG_PROCESSES_EXECUTING=TRUE

#Background process names.
HOST_HIEARARCHY_BP=host_hierarchy.sh
AUDIT_FILES_CHECK_BP=audit_files_check.sh
HOST_UNIX_COMMAND_BP=host_unix_command.sh

touch $LOGDIR/$LOG_NAME
echo "Processing Started for "$THISSCRIPT " at "$TIME "on "$DATE >> $LOGDIR/${LOG_NAME}

#Email function which is used to send emails.
SendEmail () {
$ORACLE_HOME/bin/sqlplus -s -l $sqlplus_user/$sqlplus_pw << END >> $LOGDIR/${LOG_NAME}
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
     echo "processing of $THISSCRIPT failed at ${TIME} on ${DATE}">> $LOGDIR/${LOG_NAME}
     exit 1;
else
   echo $2 >> $LOGDIR/${LOG_NAME}
fi
}
#######################################
#  Start of background process check  #
#######################################
#check for the process host_hierarchy in banking.
FIND=`ps -elf | grep $HOST_HIEARARCHY_BP | grep -v grep`
if [ "$FIND" == "" ]
then
BG_PROCESSES_EXECUTING=FALSE
SendEmail HOST_HIEARARCHY_BP_ERROR
fi
status=$?
StatusCheck $status "Status code to check the background process host_hierarchy.sh is "$status
#check for the process audit_files_check in banking.
FIND=`ps -elf | grep $AUDIT_FILES_CHECK_BP | grep -v grep`
if [ "$FIND" == "" ]
then
BG_PROCESSES_EXECUTING=FALSE
SendEmail AUDIT_FILES_CHECK_BP_ERROR 
fi
status=$?
StatusCheck $status "Status code to check the background process audit_files_check.sh is "$status
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

echo "Ending check_costcenter_bg_process script" >> $LOGDIR/${LOG_NAME}

##############################
#  end of script             #
##############################