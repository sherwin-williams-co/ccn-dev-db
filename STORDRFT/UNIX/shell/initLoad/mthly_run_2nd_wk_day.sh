#!/bin/sh
#################################################################
# Script name   : MNTHLY_RUN_PROC.sh
#
# Description   : This script is to run the monthly process on the second week day of the month
#                 This process will check if current date matches the second week day of the month in the SECOND_WEEKDAY file
#                 If it matches then the process will start
# Created       : 02/29/2016 nxk927.....
# Modified      : 
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh


PROC_NAME="MNTHLY_RUN_PROC"
LOGDIR=$HOME/Reports/log
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

./generate_2nd_weekday.sh

SECOND_WEEKDAY=`cat $HOME/initLoad/SECOND_WEEKDAY.TXT`

if [ $DATE == $SECOND_WEEKDAY ] 
   then echo "MONTHLY PROCESS STARTED ON $SECOND_WEEKDAY"
   cd $HOME/initLoad
   sh Monthly_Run.sh
   else
   echo "NOT A SECOND WEEK DAY OF THE MONTH TO RUN THE MONTHLY PROCESS"
fi

TIME=`date +"%H:%M:%S"`
echo "END MNTHLY_RUN_PROC : PROCESSING FINISHED AT ${TIME}"  
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then
   exit 1;
fi

echo "PROCESSING FINISHED FOR $PROC_NAME AT ${TIME} ON ${DATE}"  
exit 0
