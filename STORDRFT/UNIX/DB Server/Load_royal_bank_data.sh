#!/bin/sh
##################################################################################################################################
# Script name   : Load_royal_bank_data.sh
#
# Description   : This shell program will initiate the ROYAL_BANK_REPORT_LOAD_MAIN_SP
#                 This shell program will perform the following Steps:
#                     1. Loads Royal Bank Report data from external table to intermediate table
#                     2. Loads Royal Bank Debit total type data
#                     3. Loads Royal Bank Transit types data
# Created       : 10/25/2016 mxr916 CCN Project Team.....
# Modified      : 11/22/2016 gxg192 1. Added logic to FTP the trigger file on application server (from db server).
#                                   2. Added logic to send email if Load data process fails.
#                  
#################################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="Royal_Bank_Report"
LOGDIR=$HOME/initLoad/logs
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "PROCESSING STARTED FOR $proc_name AT $TIME ON $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
ROYAL_BANK_REPORT_LOAD.ROYAL_BANK_REPORT_LOAD_MAIN_SP();
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
   TIME=`date +"%H:%M:%S"`
   echo "PROCESSING FAILED FOR $proc_name AT ${TIME} ON ${DATE}"
   cd $HOME/dailyLoad
   ./send_err_status_email.sh ROYAL_BANK_REPORT_ERROR
   exit 1;
else
   ./ftp_royal_bank_rpt_trg.sh
fi

TIME=`date +"%H:%M:%S"`
echo "PROCESSING FINISHED FOR $proc_name AT ${TIME} ON ${DATE}"

exit 0
############################################################################
