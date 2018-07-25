#!/bin/sh
#################################################################
# Script name   : kill_costcenter_audit_bg_process.sh
#
# Description   : This script is used to kill the audit file for background process.
#
# Created  : 07/25/2016 kxm302 CCN Project Team.....
#################################################################

#Read Variables
LOGDIR=$HOME/logs
THISSCRIPT="kill_costcenter_audit_bg_process"
DATE=`date +"%m%d%Y"`
TIME=`date +"%H%M%S"`
LOG_NAME=${THISSCRIPT}_${DATE}_${TIME}.log


# Get process id of audit_files_check
process_id=ps -ef | grep audit_files_check.sh | grep -v grep | awk {'print $2'}

# Kill the audit_files_check in background process 
kill -9 $process_id


status=$?
if test $status -ne 0
   then
     TIME=`date +"%H:%M:%S"`
     echo "processing of "$THISSCRIPT " failed at ${TIME} on ${DATE}">> $LOGDIR/${LOG_NAME}
     exit 1;
else
   echo "processing of "$THISSCRIPT " completed successfully at ${TIME} on ${DATE} >> $LOGDIR/${LOG_NAME}
fi

echo "ending kill_costcenter_audit_bg_process script" >> $LOGDIR/${LOG_NAME}

exit 0
##############################
#  end of script             #
##############################


