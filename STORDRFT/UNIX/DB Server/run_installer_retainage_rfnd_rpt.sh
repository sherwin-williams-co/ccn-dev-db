#!/bin/sh
#################################################################
# Script name   : run_installer_retainage_rfnd_rpt.sh
#
# Description   : This script is to run the installer_retainage_rfnd_rpt.sh process on the 1st week day of the month
#                 This process will check if current date matches the 1st business day of the month.
#                 If it matches then the process will start
# Created       : 10/26/2016 nxk927.....
# Modified      : 09/05/2017 nxk927.....
#                 changed the logic to get the first week day and use that date instead of using the second weekday parameter
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh


PROC_NAME="RUN_INSTALLER_RETAINAGE_RFND_RPT"
LOGDIR=$HOME/Reports/log
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

echo "RUN_INSTALLER_RETAINAGE_RFND_RPT PROCESS STARTED AT ${TIME} ON ${DATE}"

TIME=`date +"%H:%M:%S"`
FIRST_WEEKDAY=`cat $HOME/initLoad/FIRST_WEEKDAY.TXT`
echo "RUN DATE IS $DATE"
echo "RUN DATE SHOULD BE $FIRST_WEEKDAY"

if [ $DATE == $FIRST_WEEKDAY ]
   then echo "MONTHLY INSTALLER RETAINAGE REFUND REPORT PROCESS STARTED AT ${TIME} ON ${DATE}"
   cd $HOME/initLoad
   sh installer_retainage_rfnd_rpt.sh
   else
   echo "NOT A FIRST WEEK DAY OF THE MONTH TO RUN THE MONTHLY INSTALLER RETAINAGE REFUND REPORT PROCESS "
fi

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
   TIME=`date +"%H:%M:%S"`
   echo "PROCESS EXITED DUE TO ERROR WHILE RUNNING THE $PROC_NAME AT $TIME ON $DATE"
   exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "PROCESSING FINISHED FOR $PROC_NAME AT ${TIME} ON ${DATE}"
exit 0
