#!/bin/sh
#################################################################
# Script name   : SRA11000_CURR_UAR_LOAD.sh
# Description   : This shell script will load UAR DATA in the respective table from previous and current day. 
#                 For summary we are backdated by 1 day. So we will generate the data for the file from previous day load  
#
# Created  : 04/25/2016 nxk927 CCN Project Team.....
# Modified : 
#################################################################
. /app/banking/dev/banking.config

proc_name="SRA11000_CURR_UAR_LOAD"
DATA_FILES_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/SRA11000"
LOGDIR=$HOME/logs
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

echo "Processing Started for $proc_name at $TIME on $DATE"
#################################################################
#                           Loading load_current_uar table
#################################################################
echo "Processing Started to load uar tables  at $TIME on $DATE"
sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw <<EOF > $LOGDIR/load_current_uar_data.log
set heading off;
set serveroutput on;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
@$HOME/load_current_uar_data.sql

Exception
 when others then
 :exitCode := 2;
END;
 /
exit :exitCode
EOF
status=$?
         if test $status -ne 0
         then
             echo $status
             TIME=`date +"%H:%M:%S"`
             echo "processing FAILED to load the load_current_uar_data tables at ${TIME} on ${DATE}"
             exit 1;
         fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for loading load_current_uar_data tables at  at $TIME on $DATE"

exit 0
#################################################################
#                Process END 
################################################################# 
