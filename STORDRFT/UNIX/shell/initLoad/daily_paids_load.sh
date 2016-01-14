#!/bin/sh 
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
#          : 01/12/2016 axk326 CCN Project Team.....
#            Added shell script call to check if the .OK file exists or not before proceeding further
#            Added call to remove the regular .OK file and recreate the .NOT_OK file in dailyLoad folder
################################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

# below command will invoke the paids_mntnc_ok_check shell script to check if the trigger file exists or not
./paids_mntnc_ok_check.sh
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then
     echo "PAIDS_MNTNC_CHECK.OK file do not exists - process exiting out "
	 ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
     exit 1;
fi

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

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then
     cd $HOME/dailyLoad
	 ./send_err_status_email.sh SD_DAILY_PAIDS_LOAD_ERROR
     exit 1;
fi

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

echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0
############################################################################
