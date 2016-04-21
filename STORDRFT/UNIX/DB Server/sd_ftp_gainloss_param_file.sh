#!/bin/sh
#############################################################################
# Script Name : sd_ftp_gainloss_param_file.sh
#
# Description : This shell script will generate param_app_server.lst file that gets ftp'd
#               as param.lst to app server
# 
# Created     : 04/22/2015 jxc517 Store Draft Project
# Modified    : 03/18/2016 nxk927 CCN Project Team.....
#               Changed the order of declaring variables after capturing the STATUS to avoid the scenario where
#               the ERROR CODE that needs to be captured, will not be overwritten in the ERROR STATUS CHECK block
#             : 03/24/2016 nxk927 CCN Project Team.....
#               changed the error check to make it uniform. 
#               added proc name in the error message
############################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc=sd_ftp_gainloss_param_file
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

echo -e "\n Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END

set pages 0
set feedback off
set linesize 21

spool $HOME/Reports/param_app_server.lst
SELECT to_char(LAST_DAY(ADD_MONTHS(TRUNC(SYSDATE,'month'),-2)),'yyyy,mm,dd')||'|'||to_char(TRUNC(SYSDATE,'month'),'yyyy,mm,dd') FROM DUAL;
spool off

exit;

END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc at $TIME on $DATE"
     exit 1;
fi

echo " FTP Process Started "
ftp -n ${appserver_host} <<END_SCRIPT
quote USER ${appserver_user}
quote PASS ${appserver_pw}
cd /app/strdrft/sdReport/data

put param_app_server.lst param.lst

quit
END_SCRIPT

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED at FTP process for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

echo " FTP Process Successful "

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}" 

exit 0
