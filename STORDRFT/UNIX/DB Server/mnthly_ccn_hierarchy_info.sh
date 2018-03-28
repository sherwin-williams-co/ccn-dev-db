#!/bin/sh
##################################################################################################################################
# Script name   : ccn_hierarchy_info.sh
#
# Description   : This script will invoke SD_REPORT_PKG.CCN_HIERARCHY_INFO
#
# Created       : 10/22/2014 jxc517 CCN Project Team.....
# Modified      : 04/28/2015 axk326 CCN Project Team.....
#                 Added parameter to pick up the date from the config file 
#               : 11/18/2015 axk326 CCN Project Team.....
#                 Added Error handling calls to send email when ever the script errors out due to any of the OSERROR or SQLERROR 
#               : 01/12/2016 axk326 CCN Project Team.....
#                 Added shell script call to send email when the script fails due to some kind of error
#                 Added shell script call to rename the trigger file from .ok to .not_ok in case of error
#               : 03/18/2016 nxk927 CCN Project Team....
#                 Moved the declared TIME vairable at the end
#                 Added the message with TIME, DATE AND PROC name to see where it failed in case it fails
#               : 08/10/2017 gxg192 Changes to rename batch_dependency file to notok if ccn_hierarchy_info load fails.
#################################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="ccn_hierarchy_info"
LOGDIR=$HOME/dailyLoad/logs
TIME=`date +"%H:%M:%S"`
DATE=${SD_REPORT_QRY_RUNDATE}
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

echo " START TRUCATING AND LOADING : Process Started at $TIME on $DATE "

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
SD_REPORT_PKG.CCN_HIERARCHY_INFO();
EXCEPTION
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     cd $HOME/dailyLoad
	 ./send_err_status_email.sh CCN_HIERARCHY_INFO_LOAD_ERROR
	 ./rename_file_ok_to_notok.sh mntnc_dpndncy_check
	 ./rename_file_ok_to_notok.sh batch_dependency
	 TIME=`date +"%H:%M:%S"`
	 echo "Process Failed for $proc_name at $TIME on $DATE"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################

