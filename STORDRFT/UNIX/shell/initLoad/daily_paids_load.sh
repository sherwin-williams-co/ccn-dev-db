#!/bin/sh -e
###############################################################################################################################
# Script name   : daily_paids_load.sh
#
# Description   : This shell program will initiate the script that
#                 Loads all the store drafts tables paid details
#                 It also sends the emails regarding starting and ending of the process
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
#          : 11/18/2015 axk326 CCN Project Team.....
#            Added Error handling calls to send email when ever the script errors out due to any of the OSERROR or SQLERROR
################################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="daily_paids_load"
LOGDIR=$HOME/dailyLoad/logs
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE} 
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;

MAIL_PKG.send_mail('SD_DAILY_PAIDS_LOAD_START');
SD_PAID_DETAILS_LOAD.CCN_SD_PAID_LOAD_SP();
 Exception 
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode
END
if [ 0 -ne "$?" ]; then
sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
MAIL_PKG.send_mail('SD_DAILY_PAIDS_LOAD_ERROR');
 Exception 
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode
END
else
TimeStamp=`date '+%Y%m%d%H%M%S'`
sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
MAIL_PKG.send_mail('SD_DAILY_PAIDS_LOAD_END');
 Exception 
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode
END
echo "Successfully sent mail for the errors"
fi
exit 1
fi

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0
############################################################################
