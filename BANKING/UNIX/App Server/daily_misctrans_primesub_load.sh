#!/bin/sh
#################################################################
# Script name   : daily_misctrans_primesub_load.sh
#
# Description   : This script will invoke STR_BNK_DPST_DLY_RCNCL_PROCESS.PRIME_SUB_LOAD_PROCESS
#
# Created  : 10/25/2016 jxc517 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="PRIME_SUB_LOAD_PROCESS"
LOGDIR=$HOME/logs
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
EXECUTE STR_BNK_DPST_DLY_RCNCL_PROCESS.PRIME_SUB_LOAD_PROCESS();
exit
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0
############################################################################
