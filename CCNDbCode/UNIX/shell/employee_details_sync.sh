#!/bin/sh
#############################################################################
# Script Name   :  employee_details_sync.sh
#
# Description    :  This shell program will invoke the procedure from the backend to 
#                   synchronize the data that has been udpated in the source environment via VIEW
#
# Created           :  JXC517 08/27/2014
############################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 proc="SYNC_EMPLOYEE_DETAILS"
 LOGDIR="$HOME/batchJobs"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;

execute CCN_EMPLOYEE_DETAILS_PKG.SYNC_EMPLOYEE_DETAILS();

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  

############################################################################

