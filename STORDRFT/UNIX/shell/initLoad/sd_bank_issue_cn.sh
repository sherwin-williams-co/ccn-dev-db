#!/bin/sh
#################################################################
# Script name   : sd_bank_issue_cn.sh
#
# Description   : This script is to run the
#					SD_BANKFILES_PKG.CREATE_CAN_AUTO_FILE
#					SD_BANKFILES_PKG.CREATE_CAN_NONAUTO_FILE
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value to pick the date value from config file
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="sd_bank_issue_cn"
LOGDIR="$HOME/initLoad/logs"
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE} 
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set serveroutput on;
set verify off;

exec SD_BANKFILES_PKG.CREATE_CAN_NONAUTO_FILE(to_date('$DATE','MM/DD/YYYY'));
exec SD_BANKFILES_PKG.CREATE_CAN_AUTO_FILE(to_date('$DATE','MM/DD/YYYY'));

exit;
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
