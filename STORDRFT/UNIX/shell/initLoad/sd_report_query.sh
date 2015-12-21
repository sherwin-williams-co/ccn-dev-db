#!/bin/sh -e
########################################################################################################################
# Script name   : sd_report_query.sh
#
# Description   : This script is to run the SD_REPORT_PKG.STORE_DRAFT_REPORT_QUERY to load the store_draft_report table
#
# Created  : 01/02/2015 nxk927 CCN Project Team.....
# Modified : 04/23/2015 axk326 CCN Project Team.....
#            Added call for date_host.sh file to pick up date_param.config file and to pull out the run date 
#            Added call for get_dateparam.sh to spool the dates to date_param.config file
#          : 11/18/2015 axk326 CCN Project Team.....
#            Added Error handling calls to send email when ever the script errors out due to any of the OSERROR or SQLERROR 
########################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="sd_report_query"
LOGDIR=$HOME/Reports/log
TIME=`date +"%H:%M:%S"`
DATE=${SD_REPORT_QRY_RUNDATE}
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc_name at $TIME on $DATE"

#############################################################
# BELOW PROCESS WILL TRUNCATE CCN_HIERARCHY_INFO TABLE AND PULL
# DATA FROM HIERARCHY_DETAIL_VIEW TO UPDATE ANY CHANGES MADE
# FOR FURTHER PROCESSING
#############################################################
./ccn_hierarchy_info.sh

echo "START SD Report Query : Processing Started at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set serveroutput on;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
SD_REPORT_PKG.sd_report_query(to_date('$DATE','MM/DD/YYYY'));
Exception 
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode
END
if [ 0 -ne "$?" ]; then
    echo "SD_REPORT_QUERY process blew up." 
sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END
set heading off;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
MAIL_PKG.send_mail('SD_REPORT_QUERY_ERROR');
 Exception 
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode
END
if [ 0 -ne "$?" ]; then
echo "SD_REPORT_QUERY_ERROR - send_mail process blew up." 
else
echo "Successfully sent mail for the errors"
fi
exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "END SD Report Query : Processing finished at ${TIME}"  

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
