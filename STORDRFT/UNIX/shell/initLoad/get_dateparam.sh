#!/bin/sh
########################################################################################
# Script Name : get_dateparam.sh
#
# Description : This shell script will get dates information to date_param.config file 
#               by spooling from storedrft_param table.                  
# 
# Created     : 04/23/2015 axk326 CCN Project Team....
########################################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="get_dateparam"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

echo -e "\nBegin Get Parameter: Processing Started for $proc at $TIME on $DATE"

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
	   'DAILY_PREV_RUNDATE='||TO_char(DAILY_PREV_RUNDATE, 'mm/dd/yyyy')
  FROM STOREDRFT_PARAM;

spool off
exit;

END

cd $HOME

mv -f date_param_temp.config date_param.config

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for Get Parameter at $TIME on $DATE"
     exit 1;
fi

echo -e "End Get Parameter: Processing finished for $proc at ${TIME} on ${DATE}\n"
############################################################################
