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
SD_FILE_BUILD_PKG.OUTSTANDING_DRAFT_EXC1(to_date('$DATE','MM/DD/YYYY'), 'C101');
SD_FILE_BUILD_PKG.OUTSTANDING_DRAFT_EXC(to_date('$DATE','MM/DD/YYYY'), 'C400');
EXCEPTION
 when others then
 :exitCode := 2;
END;
/
exit :exitCode
END
if [ 0 -ne "$?" ]; then
     echo "OUTSTANDING DRAFT MONTHLY Process blew up."
sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END
set heading off;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
MAIL_PKG.send_mail('OUTSTANDING_DRAFT_ERROR');	 
 EXCEPTION
 when others then
 :exitCode := 2;
END;
/
exit :exitCode 
END
if [0 -ne "$?" ]; then
echo "OUTSTANDING_DRAFT_ERROR - send mail process blew up."
else
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
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
