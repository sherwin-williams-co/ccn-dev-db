#!/bin/sh
#################################################################
# Script name   : SRA30000_dailyRun.sh
#
# Description   : This is the main script for SRA30000 process
#
# Created  : 10/31/2016 vxv336 CCN Project Team
# Modified : 
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA30000_dailyRun"
DATA_FILES_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/SRA30000"
LOGDIR=$HOME/logs
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
FOLDER=`date +"%m%d%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

#################################################################
#         FTP output file
#################################################################
./SRA30000_dailyRun_ftp.sh
status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for SRA30000_dailyRun_ftp at ${TIME} on ${DATE}"
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for SRA30000_dailyRun_ftp at ${TIME} on ${DATE}"

#################################################################
#         ARCHIVE output file
#################################################################
./SRA30000_Arch_Output_file.sh
status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for SRA30000_Arch_Output_file script at ${TIME} on ${DATE}"
    exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for SRA30000_Arch_Output_file script at ${TIME} on ${DATE}"

#################################################################
#                                              ERROR STATUS CHECK
#################################################################
status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0
