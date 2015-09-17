#!/bin/sh
#################################################################
# Script name   : initLoad.sh
#
# Description   : This script will invoke INITLOAD.INITLOAD_SP()
#
# Created  : 07/21/2015 jxc517 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="INITLOAD"
LOGDIR=$HOME/logs
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
EXECUTE INITLOAD.INITLOAD_SP();
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
