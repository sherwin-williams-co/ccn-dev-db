#!/bin/sh
#################################################################
# Script name   : daily_misctrans_primesub_load.sh
#
# Description   : This script will invoke STR_BNK_DPST_DLY_RCNCL_PROCESS.PRIME_SUB_LOAD_PROCESS
#
# Created  : 10/25/2016 jxc517 CCN Project Team.....
# Modified : 01/09/2017 gxg192 1. Added exitCode variable for exception handling
#                              2. Changes to fetch time after status for previous process is retrieved
# Modified : 08/18/2017 nxk927 1. Added ftp script to ftp a trigger file for prime sub process
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="PRIME_SUB_LOAD_PROCESS"
LOGDIR=$HOME/logs
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
exec :exitCode := 0;
EXECUTE STR_BNK_DPST_DLY_RCNCL_PROCESS.PRIME_SUB_LOAD_PROCESS();
exit :exitCode;
END

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
     echo "processing FAILED for $proc_name - STR_BNK_DPST_DLY_RCNCL_PROCESS.PRIME_SUB_LOAD_PROCESS at ${TIME} on ${DATE}"
     exit 1;
fi

############################################################################
#                           FTP TRIGGER FILE
############################################################################
echo "Processing Started for ftp Trigger file at $TIME on $DATE"
./ftp_misctran_primesub_trigger.sh
############################################################################
#                           ERROR STATUS CHECK FOR TRIGGER PROC
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
     echo "processing FAILED for ftping Trigger file at ${TIME} on ${DATE}"
     exit 1;
fi
echo "Processing finished for ftp Trigger file at $TIME on $DATE"

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0
############################################################################
