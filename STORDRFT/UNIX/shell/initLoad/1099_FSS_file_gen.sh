#!/bin/sh -e
##############################################################################################################
# Script name   : 1099_FSS_file_gen.sh
#
# Description   : This shell program will initiate the 1099 FSS process as and when needed
#
# Created  : 08/28/2015 jxc517 CCN Project Team.....
# Modified : 11/18/2015 axk326 CCN Project Team.....
#            Added Error handling calls to send email when ever the script errors out due to any of the OSERROR or SQLERROR 
##############################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="1099_FSS_monthly_file_gen"
LOGDIR="$HOME/initLoad/logs"
TIME=`date +"%H:%M:%S"`
DATE=${MNTLY_1099_RUNDATE} 
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
SD_FILE_BUILD_PKG.BUILD_1099_FILE_FOR_FSS(to_date('$DATE','MM/DD/YYYY'));
EXCEPTION
 when others then
 :exitCode := 2;
END;
/
exit :exitCode
END

if [ 0 -ne "$?" ]; then
    echo "BUILD_1099_FILE_FOR_FSS process blew up." 
    cd $HOME/dailyLoad
	sh send_err_status_email.sh BUILD_1099_FILE_FOR_FSS_ERROR	
    echo "Successfully sent mail for the errors"
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
