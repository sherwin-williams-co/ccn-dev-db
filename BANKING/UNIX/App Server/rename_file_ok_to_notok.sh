#!/bin/sh
#################################################################################################################################
# Script name   : rename_file_ok_to_notok.sh
#
# Description   : purpose of this script will be to rename the file from #.ok to #.not_ok
#                 due to any kind of error
#
# Created     : 06/27/2016 mxk766 CCN Project Team....
#################################################################################################################################

. /app/banking/dev/banking.config

proc_name=rename_file_ok_to_notok
file_name=$1
LOGDIR=$HOME/logs 
DATE=`date +"%m%d%Y"`
TIME=`date +"%H%M%S"` 
LOG_NAME=${proc_name}_${DATE}_${TIME}.log

touch $LOGDIR/$LOG_NAME

echo "Processing Started for $proc_name at $TIME on $DATE">>$LOGDIR/$LOG_NAME

mv $file_name.ok $file_name.not_ok

echo "Renaming of file completed for $proc_name at $TIME on $DATE">>$LOGDIR/$LOG_NAME

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?

echo "Status of rename is "$status>>$LOGDIR/$LOG_NAME

TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}">>$LOGDIR/$LOG_NAME
     exit 1
fi

echo "$file_name.not_ok file is created in dailyLoad folder">>$LOGDIR/$LOG_NAME
echo "Processing finished for $proc_name at ${TIME} on ${DATE}">>$LOGDIR/$LOG_NAME
exit 0