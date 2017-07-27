#!/bin/sh
#################################################################
# Script name   : SRA11000_dly_uar_data_load.sh
#
# Description   : This shell script will perform below tasks
#                 1. load the data needed for the position_file
# Created       : 07/27/2017 nxk927 CCN Project Team.....
# Modified 
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA11000_dly_uar_data_load"
LOGDIR=$HOME/logs
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
LOAD_DATE=`date +"%d-%^b-%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

#################################################################
#                  STR_BNK_DPST_DLY_RCNCL_PROCESS.LOAD_UAR_DATA
#################################################################
echo "Processing started for STR_BNK_DPST_DLY_RCNCL_PROCESS.LOAD_UAR_DATA at ${TIME} on ${DATE}"
sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set serveroutput on;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
STR_BNK_DPST_DLY_RCNCL_PROCESS.LOAD_UAR_DATA('$LOAD_DATE');
Exception
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode
END

status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for STR_BNK_DPST_DLY_RCNCL_PROCESS.LOAD_UAR_DATA at ${TIME} on ${DATE}"
    exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0
