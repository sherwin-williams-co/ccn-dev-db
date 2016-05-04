#!/bin/sh
#################################################################
# Script name   : future_to_current.sh
#
# Description   : This script will invoke BANKING_FILE_BUILD_PKG.CREATE_DEPOSIT_TICKET_IP_FILE
#
# Created  : 08/19/2015 nxk927 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="deposit_ticket_ip_file"
LOGDIR=$HOME/logs
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
P1=`date +"%d-%b/%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
EXECUTE BNKNG_DEPST_TKT_INPUT_PKG.CREATE_DEPOSIT_TKT_INPUT_FILE('$P1');
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
