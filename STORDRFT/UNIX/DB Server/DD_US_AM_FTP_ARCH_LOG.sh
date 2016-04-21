#!/bin/sh
#################################################################
# Script name   : DD_US_AM_FTP_ARCH_LOG.sh
#
# Description   : This script is to run the FTP, Archiving and Logging for daily Automotive US issue files
#
# Created  : 11/12/2014 axk326 CCN Project Team.....
# Modified : 11/14/2014 nxk927 CCN Project Team.....
#            Added logic to check if the file is empty or not before transferring (FTP) file to remote server
#          : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
#          : 03/18/2016 nxk927 CCN Project Team.....
#            Changed the order of declaring variables after capturing the STATUS to avoid the scenario where
#            the ERROR CODE that needs to be captured, will not be overwritten in the ERROR STATUS CHECK block
#            added if condition to check for the file if it is present or not
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="DD_US_AM_FTP_ARCH_LOG"
proc_name1="DD_US_AM_FTP_ARCH"
LOGDIR=$HOME/dailyLoad/logs
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE}
TimeStamp=`date '+%Y%m%d%H%M%S'`
FILE_NAME=DLY_DRAFT_US_AM

echo "Processing Started for $proc_name at $TIME on $DATE"

if [ -f $HOME/initLoad/$FILE_NAME ];
then
   if [[ `ls -l $HOME/initLoad/$FILE_NAME  | awk '{print $5}'` -eq 1 ]]
   then
      echo "$FILE_NAME is empty"
   else
      echo "Processing Started for $proc_name at $TIME on $DATE"
     ./DD_US_AM_FTP_ARCH.sh >> $LOGDIR/$proc_name1"_"$TimeStamp.log
   fi
else
    echo "$FILE_NAME not found"
fi

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

exit 0
############################################################################
