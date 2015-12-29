#!/bin/sh -e
###################################################################################################
# Script name   : 1099_mid_monthly_file_gen.sh
#
# Description   : This shell program will initiate the mid-monthly 1099 process
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 11/24/2014 jxc517 CCN Project Team.....
#            Added date parameter to run for previous month
#          : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
#          : 11/18/2015 axk326 CCN Project Team.....
#            Added Error handling calls to send email when ever the script errors out due to any of the OSERROR or SQLERROR 
###################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="1099_mid_monthly_file_gen"
LOGDIR="$HOME/initLoad/logs"
TIME=`date +"%H:%M:%S"`
DATE=${MID_MNTLY_1099_RUNDATE}
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
SD_FILE_BUILD_PKG.BUILD_1099_FILE(to_date('$DATE','MM/DD/YYYY'),'Y');
EXCEPTION
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
     echo "BUILD_1099_MID_MNTLY_FILE process blew up." 
     cd $HOME/dailyLoad
	 ./send_err_status_email.sh BUILD_1099_MID_MNTLY_FILE_ERROR	
     echo "Successfully sent mail for the errors"
	 echo "processing FAILED at $TIME on $DATE"
     exit 1;
fi

echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0
############################################################################
