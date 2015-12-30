#!/bin/sh -e
##############################################################################################################
# Script name   : Outstanding_draft_monthly.sh
#
# Description   : This script is to run the SD_FILE_BUILD_PKG.OUTSTANDING_DRAFT_EXC that will generate the Outstanding draft excel sheet
#                 and depending on the division code it will be mailed to the right person
#
# Created  : 06/18/2015 nxk927 CCN Project Team.....
# Modified : 09/23/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file           
##############################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="Outstanding_draft_monthly"
LOGDIR="$HOME/initLoad/logs"
TIME=`date +"%H:%M:%S"`
DATE=${PL_GAIN_RUNDATE}
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set serveroutput on;
set verify off;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
var exitCode number;
BEGIN
:exitCode := 0;
SD_FILE_BUILD_PKG.OUTSTANDING_DRAFT_EXC(to_date('$DATE','MM/DD/YYYY'), 'C101');
SD_FILE_BUILD_PKG.OUTSTANDING_DRAFT_EXC(to_date('$DATE','MM/DD/YYYY'), 'C400');
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
     cd $HOME/dailyLoad
	 ./send_err_status_email.sh OUTSTANDING_DRAFT_ERROR
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
