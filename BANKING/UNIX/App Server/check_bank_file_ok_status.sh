#!/bin/sh
#################################################################################################################################
# Script name   : check_bank_file_ok_status.sh
#
# Description   : purpose of this script will be to search for a particular file in a folder
#
# Created  : 06/27/2016 mxk766 CCN Project Team...
# Modified :
#################################################################################################################################

. /app/banking/dev/banking.config

proc_name=check_bank_file_ok_status
file_name=$1 
LOGDIR=$HOME/logs
THISSCRIPT="update_banking_param" 
DATE=`date +"%m%d%Y"`
TIME=`date +"%H%M%S"` 
LOG_NAME=${THISSCRIPT}_${DATE}_${TIME}.log

echo "Processing Started for $proc_name at $TIME on $DATE">>$LOGDIR/$LOG_NAME

#Check to see if the trigger file bank_order_tracking.ok exists or not
if [ -e $file_name ]
then
   echo " $file_name file exists in dailyLoad folder ">>$LOGDIR/$LOG_NAME
else
   echo " $file_name file do not exist in dailyLoad folder ">>$LOGDIR/$LOG_NAME
   ./send_mail.sh BANKING_BATCH_PROCESSING_ERROR
   exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "  Processing finished for $proc_name at $TIME on $DATE ">>$LOGDIR/$LOG_NAME

exit 0