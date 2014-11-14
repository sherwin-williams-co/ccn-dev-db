#!/bin/sh
#################################################################
# Script name   : DD_US_NAM_FTP_ARCH_LOG.sh
#
# Description   : This script is to run the FTP, Archiving and Logging for daily Non Automotive US issue files
#
# Created  : 11/12/2014 axk326 CCN Project Team.....
# Modified : 11/14/2014 nxk927 CCN Project Team.....
#            Added logic to check if the file is empty or not before transferring (FTP) file to remote server
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="DD_US_NAM_FTP_ARCH_LOG"
proc_name1="DD_US_NAM_FTP_ARCH"
LOGDIR=$HOME/dailyLoad/logs
TimeStamp=`date '+%Y%m%d%H%M%S'`
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
FILE_NAME=DLY_DRAFT_US_NAM

echo "Processing Started for $proc_name at $TIME on $DATE"

if [[ `ls -l $HOME/initLoad/$FILE_NAME  | awk '{print $5}'` -eq 1 ]]
then
	echo "$FILE_NAME is empty"
else
    echo "Processing Started for $proc_name1 at $TIME on $DATE"
	./DD_US_NAM_FTP_ARCH.sh >> $LOGDIR/$proc_name1"_"$TimeStamp.log 
fi

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
