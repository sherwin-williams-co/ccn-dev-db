#!/bin/sh -e
#set -e
#################################################################
# Script name   : DLY_DRAFT_LOAD.sh
#
# Description   : This script is to run the daily maintenance load for AutoMotive and Non AutoMotive
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="DLY_DRAFT_LOAD"
proc_name1="DD_US_AM_FTP_ARCH"
proc_name2="DD_US_NAM_FTP_ARCH"
proc_name3="DD_CAN_AM_FTP_ARCH"
proc_name4="DD_CAN_NAM_FTP_ARCH"
LOGDIR=$HOME/dailyLoad/logs
TimeStamp=`date '+%Y%m%d%H%M%S'`
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

./DLY_DRAFT_US_AM.sh
./DLY_DRAFT_US_NAM.sh
./DLY_DRAFT_CAN_AM.sh
./DLY_DRAFT_CAN_NAM.sh
./DD_US_AM_FTP_ARCH.sh >> $LOGDIR/$proc_name1"_"$TimeStamp.log 
./DD_US_NAM_FTP_ARCH.sh >> $LOGDIR/$proc_name2"_"$TimeStamp.log 
./DD_CAN_AM_FTP_ARCH.sh >> $LOGDIR/$proc_name3"_"$TimeStamp.log 
./DD_CAN_NAM_FTP_ARCH.sh >> $LOGDIR/$proc_name4"_"$TimeStamp.log 

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
