#!/bin/sh
#################################################################
# Script name   : sd_bank_issue_us.sh
#
# Description   : This script is to run the
#					SD_BANKFILES_PKG.CREATE_US_AUTO_BANK_FILE
#					SD_BANKFILES_PKG.CREATE_US_NONAUTO_FILE
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="sd_bank_issue_us"
LOGDIR="$HOME/initLoad/logs"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

P=`date '+%a'`

if [ $P = 'Mon' ]
 then 
P1=`date --d "3 day ago" "+%m/%d/%Y"`
else 
P1=`date --d "1 day ago" "+%m/%d/%Y"`
fi

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set serveroutput on;
set verify off;

exec SD_BANKFILES_PKG.CREATE_US_AUTO_BANK_FILE(to_date('$P1','MM/DD/YYYY'));
exec SD_BANKFILES_PKG.CREATE_US_NONAUTO_FILE(to_date('$P1','MM/DD/YYYY'));

exit;
END

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
