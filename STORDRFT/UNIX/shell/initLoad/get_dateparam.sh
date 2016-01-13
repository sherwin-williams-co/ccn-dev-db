set -e
#!/bin/sh 
##############################################################################################################
# Script Name : get_dateparam.sh
#
# Description : This shell script will get dates information to date_param.config file 
#               by spooling from storedrft_param table.                  
# 
# Created     : 04/23/2015 axk326 CCN Project Team....
#             : 01/12/2016 axk326 CCN Project Team.....
#               Added shell script call to check if the trigger file exists or not before proceeding further
#               Added call to remove the regular trigger file and recreate the failure trigger file in dailyLoad folder
##############################################################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

# below command will invoke the batch_dependency_check shell script to check if the trigger file exists or not
./batch_dependency_check.sh 
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]; then
     echo "Trigger file do not exists - process exiting out from spooling the file"
     exit 1;
fi

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
END

cd $HOME

mv -f date_param_temp.config date_param.config

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if [ $status -ne 0 ]; then
     echo "processing FAILED for Get Parameter at $TIME on $DATE"
	 cd $HOME/dailyLoad
	 rm -f DAILY_LOADS.TRG;
	 echo "Trigger file is deleted from dailyLoad folder"
	 echo "" > DAILY_LOADS_FAILURE.TRG
	 echo "Failure Trigger file is created in dailyLoad folder"
     exit 1;
fi

echo -e "End Get Parameter: Processing finished for $proc at ${TIME} on ${DATE}\n"
############################################################################