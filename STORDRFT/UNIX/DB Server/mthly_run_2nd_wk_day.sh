#!/bin/sh
#################################################################
# Script name   : mthly_run_2nd_wk_day.sh
#
# Description   : This script is to run the monthly process on the second week day of the month
#                 This process will check if current date matches the second week day of the month in the SECOND_WEEKDAY file
#                 If it matches then the process will start
# Created       : 02/29/2016 nxk927.....
# Modified      : 03/18/2016 nxk927 CCN Project Team....
#                 Moved the declared TIME variable at the end
#                 added error check for each call
#               : 04/13/2016 nxk927 CCN Project Team....
#                 renamed the monthly script name.
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh


PROC_NAME="mthly_run_2nd_wk_day"
LOGDIR=$HOME/Reports/log
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

echo "MONTHLY PROCESS STARTED AT ${TIME} ON ${DATE}"

./generate_2nd_weekday.sh

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
   TIME=`date +"%H:%M:%S"`
   echo "Process exited due to error while generating the second week day of the month for $PROC_NAME at $TIME on $DATE"
   exit 1;
fi

TIME=`date +"%H:%M:%S"`
SECOND_WEEKDAY=`cat $HOME/initLoad/SECOND_WEEKDAY.TXT`

if [ $DATE == $SECOND_WEEKDAY ] 
   then echo "MONTHLY PROCESS STARTED ON $SECOND_WEEKDAY AT ${TIME} ON ${DATE}"
   cd $HOME/initLoad
   sh Second_wk_day_mnthly_run.sh
   else
   echo "NOT A SECOND WEEK DAY OF THE MONTH TO RUN THE MONTHLY PROCESS"
fi

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
   TIME=`date +"%H:%M:%S"`
   echo "Process exited due to error while running the monthly process for $PROC_NAME at $TIME on $DATE"
   exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "PROCESSING FINISHED FOR $PROC_NAME AT ${TIME} ON ${DATE}"  
exit 0
