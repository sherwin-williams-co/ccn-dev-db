#!/bin/sh
#################################################################
# Script name   : DLY_DRAFT_CAN_AM.sh
#
# Description   : This script is to run the SD_BANKFILES_PKG.CREATE_CAN_AUTO_FILE
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="DLY_DRAFT_CAN_AM"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

P1=`date --d "1 day ago" "+%m/%d/%Y"`


./EXEC_PROC_1PARAM.sh "SD_BANKFILES_PKG.CREATE_CAN_AUTO_FILE" "$P1"

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
