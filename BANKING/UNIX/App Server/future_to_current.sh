#!/bin/sh
#################################################################
# Script name   : future_to_current.sh
#
# Description   : This script will invoke FUTR_TO_CURR_BATCH_PKG.PROCESS
#
# Created  : 07/10/2015 nxk927 CCN Project Team.....
# Modified : 01/09/2017 gxg192 1. Added exitCode variable for exception handling
#                              2. Changes to fetch time after status for previous process is retrieved
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="FUTURE_TO_CURRENT_PROCESS"
LOGDIR=$HOME/logs
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
exec :exitCode := 0;
EXECUTE BANKING_BATCH_PKG.FUTURE_TO_CURRENT_PROCESS();
exit :exitCode;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
     echo "processing FAILED for $proc_name - BANKING_BATCH_PKG.FUTURE_TO_CURRENT_PROCESS at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0
############################################################################
