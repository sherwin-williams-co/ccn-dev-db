#!/bin/sh
#################################################################
# Script name : Royal_Bank_dailyRun.sh
#
# Description : This shell script will perform below tasks
#               1. ftp the file to Db server
#               2. invoke the shell script Load_royal_bank_data.sh on the DB server
#                  that loads the ROYAL_BANK_RPT_MAIN 
#
# Created     : 11/17/2015 sxh487 CCN Project Team.....
#           
#################################################################
# below command will get the path for storedraft.config respective to the environment from which it is run from
cd /app/strdrft/sdReport/scripts

. /app/strdrft/storedraft.config

proc_name="Royal_Bank_dailyRun"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
DLY_LOAD_PATH="/app/stordrft/dev/dailyLoad"
db_proc_name="Load_royal_bank_data.sh"
LOG_FILE="/app/strdrft/sdReport/logs/Load_royal_bank_data.log"
echo "Processing Started for $proc_name at $TIME on $DATE"

#################################################################
# ftp the input file to DB server
#################################################################
./Royal_Bank_datafile_ftp.sh

status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for Royal_Bank_datafile_ftp script at ${TIME} on ${DATE}"
    exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for Royal_Bank_datafile_ftp script at ${TIME} on ${DATE}"

#################################################################
# executing Royal_Bank_dailyRun.sh on the remote server
#################################################################
TIME=`date +"%H:%M:%S"`
echo "Processing started for Royal Bank data load at ${TIME} on ${DATE}"
/usr/bin/expect >> $LOG_FILE << EOD 
spawn /usr/bin/ssh -o Port=22 -o StrictHostKeyChecking=no $dbserver_user@$dbserver_host
expect "password:"
send "$dbserver_pw\r"
expect "$ "
send "pwd\r"
expect "$ "
send "cd $DLY_LOAD_PATH\r"
expect "$ "
send "sh $db_proc_name\r"
expect "$ "
send -- "exit\r"
send -- "exit\r"
exit 0
EOD

#################################################################
# Checking for errors in Load_royal_bank_data 
#################################################################
TIME=`date +"%H:%M:%S"`
if fgrep "ROYAL_BANK_REPORT_ERROR" $LOG_FILE ;then
   echo "processing FAILED for Load_royal_bank_data at ${TIME} on ${DATE}"
   
   #################################################################
   # Renaming the log file
   #################################################################
   TIME=`date +"%H:%M:%S"`
   printf "Moving Load_royal_bank_data.log to Archive folder at $TIME on $DATE \n"
   mv $LOG_FILE /app/strdrft/sdReport/logs/Load_royal_bank_data"_"$TimeStamp.log
   exit 1
else
   echo "processing completed for Load_royal_bank_data at ${TIME} on ${DATE}"
fi

#################################################################
# Renaming the log file
#################################################################
TIME=`date +"%H:%M:%S"`
printf "Moving Load_royal_bank_data.log to Archive folder at $TIME on $DATE \n"
mv $LOG_FILE /app/strdrft/sdReport/logs/Load_royal_bank_data"_"$TimeStamp.log

#################################################################
# Run the Royal Bank Reports
#################################################################
./royal_bank_report_run.sh

status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for royal_bank_report_run script at ${TIME} on ${DATE}"
    exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for royal_bank_report_run script at ${TIME} on ${DATE}"

echo "Processing finished for $proc_name at ${TIME} on ${DATE}" 
exit 0
