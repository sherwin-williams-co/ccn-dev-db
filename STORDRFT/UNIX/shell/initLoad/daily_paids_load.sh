#!/bin/sh
#############################################################################
# Script Name   :  daily_paids_load
#
# Description    : This shell program will initiate the script that 
#
#    * Loads all the store drafts tables paid details
#
# It also sends the emails regarding starting and ending of the process
#
# Created           :  10/02/2014
# Modified          :  
############################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 proc="daily_paids_load"
 LOGDIR="$HOME/initLoad/STORDRFT"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $strdrft_sqlplus_user/$strdrft_sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
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
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0
############################################################################

