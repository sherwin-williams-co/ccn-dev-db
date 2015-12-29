#!/bin/sh -e
##############################################################################################################
# Script name   : sd_1099_excel.sh
#
# Description   : This script is to run the SD_FILE_BUILD_PKG.STORE_DRAFT_INTALLER_1099
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
#          : 11/18/2015 axk326 CCN Project Team.....
#            Added Error handling calls to send email when ever the script errors out due to any of the OSERROR or SQLERROR 
##############################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="sd_1099_excel"
LOGDIR="$HOME/initLoad/logs"
TIME=`date +"%H:%M:%S"`
DATE=${QTLY_1099_RUNDATE}
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set serveroutput on;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
SD_FILE_BUILD_PKG.STORE_DRAFT_INTALLER_1099(to_date('$DATE','MM/DD/YYYY'));
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
     echo "SD_1099_EXCEL_REPORT process blew up." 
     cd $HOME/dailyLoad
	 ./send_err_status_email.sh SD_1099_EXCEL_REPORT_ERROR	
     echo "Successfully sent mail for the errors"
	 echo "processing FAILED at $TIME on $DATE"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
