#!/bin/sh

#################################################################
# Script name   : check_sra11000_process.sh
#
# Description   : This script is used to check whether the sra11000 data check process is still running
#                 If it is still running then send an email.
#
# Created  : 07/21/2017 nxk927 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

#Read Variables.
LOGDIR=$HOME/logs
PROC="check_sra11000_process"
DATE=`date +"%m%d%Y"`
TIME=`date +"%H%M%S"`
LOG_NAME="$PROC"_$DATE_$TIME.log

echo "Processing Started for "$PROC" at "$TIME "on "$DATE >> $LOGDIR/${LOG_NAME}


#######################################
#  Start of background process check  #
#######################################
process_name=pos_data_check.sh
FIND=`ps -elf | grep $process_name | grep -v grep`
if [ "$FIND" != "" ]
then
./send_mail.sh SRA11000_PROCESS_FAIL
kill -9 $(ps -ef | grep -v grep | grep $process_name | awk '{print $2}')
fi

exit 0
##############################
#  end of script             #
##############################