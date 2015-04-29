#!/bin/sh
#################################################################
# Script name   : DMD_US_NAM_FTP_ARCH_LOG.sh
#
# Description   : This script is to run the FTP, Archiving and Logging for daily Non Automotive US Maintenance files
#
# Created  : 11/12/2014 axk326 CCN Project Team.....
# Modified : 11/14/2014 axk326 CCN Project Team.....
#            Added logic to check if the file is empty or not before transferring (FTP) file to remote server
#          : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value to pick the date value from config file
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="DMD_US_NAM_FTP_ARCH_LOG"
proc_name1="DMD_US_NAM_FTP_ARCH"
LOGDIR=$HOME/dailyLoad/logs
TIME=`date +"%H:%M:%S"`
CURRENT_TIME=`date +"%H%M%S"`
P1=${DAILY_LOAD_RUNDATE}
TimeStamp=`date -d $P1 +"%Y%m%d"`$CURRENT_TIME
FILE_NAME=DLY_MAINT_DRAFT_US_NAM

echo "Processing Started for $proc_name at $TIME for the date $P1"

if [[ `ls -l $HOME/initLoad/$FILE_NAME  | awk '{print $5}'` -eq 1 ]]
then
	echo "$FILE_NAME is empty"
else
	echo "Processing Started for $proc_name1 at $TIME for the date $P1"
	./DMD_US_NAM_FTP_ARCH.sh >> $LOGDIR/$proc_name1"_"$TimeStamp.log 
fi

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
P1=${DAILY_LOAD_RUNDATE}
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} for the date ${P1}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} for the date ${P1}"  

exit 0
############################################################################
