#!/bin/sh
##############################################################################################################
# Script Name : get_dateparam.sh
#
# Description : This shell script will get dates information to date_param.config file
#               by spooling from storedrft_param table.
#
# Created     : 04/23/2015 axk326 CCN Project Team....
#             : 01/12/2016 axk326 CCN Project Team.....
#               Added shell script call to check if the .ok file exists or not before proceeding further
#               Added shell script call to rename the .ok file to .not_ok file in dailyLoad folder
#             : 03/18/2016 nxk927 CCN Project Team.....
#               Changed the order of declaring variables after capturing the STATUS to avoid the scenario where
#               the ERROR CODE that needs to be captured, will not be overwritten in the ERROR STATUS CHECK block
#             : 03/24/2016 nxk927 CCN Project Team.....
#               Added error message for errors
#             : 12/01/2016 gxg192 CCN Project Team.....
#               Added Parameter for ROYAL_BANK_RPT_RUNDATE
##############################################################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="get_dateparam"
DATE=`date +"%m/%d/%Y"`

# below command will invoke the check_file_ok_status shell script to check if the batch_dependency.ok file exists or not
./check_file_ok_status.sh batch_dependency.ok
############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "Processing failed for get_dateparam at $TIME on $DATE"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Begin Get Parameter: Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END

set pages 0
set feedback off
set linesize 500
column "Newline Character" noprint new_value newline_char
select chr(10) "Newline Character" from dual;
set colsep "&newline_char"
undefine newline_char
column "Newline Character" clear
set recsep each

spool $HOME/date_param_temp.config

SELECT 'DAILY_LOAD_RUNDATE='|| To_char(DAILY_LOAD_RUNDATE, 'mm/dd/yyyy'),
       'PL_GAIN_RUNDATE='||To_char(PL_GAIN_RUNDATE, 'mm/dd/yyyy'),
       'GAINLOSS_MNTLY_RUNDATE='||To_char(GAINLOSS_MNTLY_RUNDATE, 'mm/dd/yyyy'),
       'SD_REPORT_QRY_RUNDATE='||To_char(SD_REPORT_QRY_RUNDATE, 'mm/dd/yyyy'),
       'JV_MNTLY_RUNDATE='||To_char(JV_MNTLY_RUNDATE, 'mm/dd/yyyy'),
       'QTLY_1099_RUNDATE='||To_char(QTLY_1099_RUNDATE, 'mm/dd/yyyy'),
       'MNTLY_1099_RUNDATE='||To_char(MNTLY_1099_RUNDATE, 'mm/dd/yyyy'),
       'MID_MNTLY_1099_RUNDATE='||To_char(MID_MNTLY_1099_RUNDATE, 'mm/dd/yyyy'),
       'DAILY_PREV_RUNDATE='||TO_char(DAILY_PREV_RUNDATE, 'mm/dd/yyyy'),
       'ROYAL_BANK_RPT_RUNDATE='||TO_char(ROYAL_BANK_RPT_RUNDATE, 'mm/dd/yyyy')
  FROM STOREDRFT_PARAM;

spool off
exit;

END

cd $HOME

mv -f date_param_temp.config date_param.config

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for Get Parameter at $TIME on $DATE"
     cd $HOME/dailyLoad
     ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
     ./rename_file_ok_to_notok.sh batch_dependency
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "End Get Parameter: Processing finished for $proc at ${TIME} on ${DATE}"
############################################################################

exit 0
