#!/bin/sh
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
#          : 03/18/2016 nxk927 CCN Project Team.....
#            Added Error handling calls to each shell script
#          : 03/24/2016 nxk927 CCN Project Team.....
#            Added Error message to  get the time and proc name if it errors out
#          : 03/28/2018 nxk927 CCN Project Team.....
#            created duplicate copy of ccn_hierarchy_info.sh to run it for monthly process
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
./mnthly_ccn_hierarchy_info.sh

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
   TIME=`date +"%H:%M:%S"`
   echo "Processing FAILED for $proc_name at $TIME on $DATE"
   exit 1;
fi

TIME=`date +"%H:%M:%S"`
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

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
     cd $HOME/dailyLoad
     ./send_err_status_email.sh SD_REPORT_QUERY_ERROR
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at $TIME on $DATE"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

exit 0
############################################################################
