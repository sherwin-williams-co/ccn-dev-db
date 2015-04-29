#!/bin/sh
#################################################################
# Script name   : daily_paids_load.sh
#
# Description   : This shell program will initiate the script that
#                 Loads all the store drafts tables paid details
#                 It also sends the emails regarding starting and ending of the process
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="daily_paids_load"
LOGDIR=$HOME/dailyLoad/logs
TIME=`date +"%H:%M:%S"`
CURRENT_TIME=`date +"%H%M%S"`
P1=${DAILY_LOAD_RUNDATE}
TimeStamp=`date -d $P1 +"%Y%m%d"`$CURRENT_TIME
echo "Processing Started for $proc at $TIME for the date $P1"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;

execute MAIL_PKG.send_mail('SD_DAILY_PAIDS_LOAD_START');
execute SD_PAID_DETAILS_LOAD.CCN_SD_PAID_LOAD_SP();
execute MAIL_PKG.send_mail('SD_DAILY_PAIDS_LOAD_END');

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
P1=${DAILY_LOAD_RUNDATE}
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} for the date ${P1}"
     exit 1;
fi

echo "Processing finished for $proc at ${TIME} for the date ${P1}"  

exit 0
############################################################################
