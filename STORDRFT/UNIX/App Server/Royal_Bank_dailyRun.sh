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
# below command will get the path for banking.config respective to the environment from which it is run from
cd /app/strdrft/sdReport/scripts

. /app/strdrft/storedraft.config

proc_name="Royal_Bank_dailyRun"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
password="st04d1"
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
# executing ROYAL_BANK_REPORT_LOAD.ROYAL_BANK_REPORT_LOAD_MAIN_SP
#################################################################

echo "Processing started for Royal Bank data load at ${TIME} on ${DATE}"
/usr/bin/expect >> /app/strdrft/log_file_ssh.txt << EOD
spawn /usr/bin/ssh -o Port=22 -o StrictHostKeyChecking=no stordrft@extddb01
expect "password:"
send "$password\r"
expect "$ "
send "pwd\r"
expect "$ "
send "cd /app/stordrft/dev/dailyLoad\r"
expect "$ "
send "sh Load_royal_bank_data.sh\r"
expect "$ "
send -- "exit\r"
send -- "exit\r"
exit 0
EOD

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0
