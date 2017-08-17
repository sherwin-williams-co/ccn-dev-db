#!/bin/sh
#################################################################
# Script name   : check_costcenter_bg_process.sh
#
# Description   : This script is used to check whether the background process is running for
#                 the costcenter job. If it is not executing then send an email.
#
# Created  : 08/17/2017 rxv940 CCN Project Team.....
# Modified : 
#################################################################

. /app/ccn/ccn_app_server.config

LOGDIR=$HOME/POSdownloads/log
PROC_NAME="check_costcenter_bg_process"
DATE=`date +"%m%d%Y"`
TIME=`date +"%H%M%S"`
LOG_NAME=${PROC_NAME}_${DATE}_${TIME}.log
BG_PROCESSES_EXECUTING=TRUE
HOSTNAME=`hostname`

echo " $PROC_NAME --> Processing Started for "$PROC_NAME " at $DATE:$TIME" >> $LOGDIR/${LOG_NAME}
MAIL_MESSAGE=""
bg_process_name=`cat $HOME/background_processname.txt`
for bg_name in $bg_process_name
do
    FIND=`ps -eaf | grep $bg_name | grep -v grep`
    if [ "$FIND" == "" ]
    then
        BG_PROCESSES_EXECUTING=FALSE
        MAIL_MESSAGE+=$bg_name","
    fi
done

if [ "$BG_PROCESSES_EXECUTING" == "TRUE" ]
then
    $SCRIPT_DIR/send_mail.sh ALL_BG_PROCESSES_EXECUTING "All Background Processes are running in ccn"@$HOSTNAME
else
    MESSAGELENGTH=${#MAIL_MESSAGE}
    MESSAGELENGTH=`expr $MESSAGELENGTH - 1`
    MAIL_MESSAGE=`echo $MAIL_MESSAGE | cut -c1-$MESSAGELENGTH`
    MAIL_MESSAGE="Background Processes "$MAIL_MESSAGE" not running in ccn"@$HOSTNAME
    $SCRIPT_DIR/send_mail.sh BG_PROCESSES_FAILURE "$MAIL_MESSAGE"
fi

TIME=`date +"%H:%M:%S"`
status=$? 
if test $status -ne 0
then
    echo " $PROC_NAME --> Processing of "$PROC_NAME " failed at $DATE:$TIME">> $LOGDIR/${LOG_NAME}
    exit 1;
else
    echo " $PROC_NAME --> Mailing process status is "$status >> $LOGDIR/${LOG_NAME}
fi

echo " $PROC_NAME --> Ending check_costcenter_bg_process.sh script at $DATE:$TIME" >> $LOGDIR/${LOG_NAME}

exit 0
