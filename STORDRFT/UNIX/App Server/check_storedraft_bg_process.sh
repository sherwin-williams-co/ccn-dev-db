#!/bin/sh

#################################################################
# Script name   : check_storedraft_bg_process.sh
#
# Description   : This script is used to check whether the background process is running for
#                 the STOREDrafts job. If it is not executing then send an email.
#
# Created  : 09/30/2016 mxk766 CCN Project Team.....
# Modified :
#################################################################

# link to parameter file
. /app/strdrft/storedraft.config

#Read Variables.

LOGDIR=$HOME/logs
THISSCRIPT="check_storedraft_bg_process"
DATE=`date +"%m%d%Y"`
TIME=`date +"%H%M%S"`
LOG_NAME=${THISSCRIPT}_${DATE}_${TIME}.log
BG_PROCESSES_EXECUTING=TRUE
HOMEPATH=$HOME/scripts

touch $LOGDIR/$LOG_NAME

echo "Processing Started for "$THISSCRIPT " at "$TIME "on "$DATE >> $LOGDIR/${LOG_NAME}

#######################################
#  Start of background process check  #
#######################################
MAIL_MESSAGE=""
bg_process_name=`cat $HOMEPATH/background_processname.txt`
for bg_name in $bg_process_name
do
FIND=`ps -elf | grep $bg_name | grep -v grep`
if [ "$FIND" == "" ]
then
BG_PROCESSES_EXECUTING=FALSE
MAIL_MESSAGE+=$bg_name","
fi
done

if [ "$BG_PROCESSES_EXECUTING" == "TRUE" ]
then
./send_mail.sh ALL_BG_PROCESSES_EXECUTING "All Background Processes are running in "$USER@$HOSTNAME
else
MESSAGELENGTH=${#MAIL_MESSAGE}
MESSAGELENGTH=`expr $MESSAGELENGTH - 1`
MAIL_MESSAGE=`echo $MAIL_MESSAGE | cut -c1-$MESSAGELENGTH`
MAIL_MESSAGE="Background Processes "$MAIL_MESSAGE" not running in "$USER@$HOSTNAME
./send_mail.sh BG_PROCESSES_FAILURE "$MAIL_MESSAGE"
fi

status=$? 
if test $status -ne 0
   then
     TIME=`date +"%H:%M:%S"`
     echo "processing of "$THISSCRIPT " failed at ${TIME} on ${DATE}">> $LOGDIR/${LOG_NAME}
     exit 1;
else
   echo "Mailing process status is "$status >> $LOGDIR/${LOG_NAME}
fi

echo "ending check_storedraft_bg_process.sh script" >> $LOGDIR/${LOG_NAME}

exit 0
##############################
#  end of script             #
##############################