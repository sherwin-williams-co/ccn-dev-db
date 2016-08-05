#!/bin/sh
#############################################################################
# Script Name   :  address_future_to_current.sh
#
# Description    :  This shell program will invoke the procedure that
#                   performs the future to current address process
#
# Created           :  jxc517 05/03/2016
############################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="address_future_to_current"
LOGDIR="$HOME/batchJobs"
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;

execute CCN_ADDRESS_FUT_TO_CURR_PKG.PROCESS();

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0
############################################################################
