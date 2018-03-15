#!/bin/sh
###############################################################################################################################
# Script name   : ccn_insert_into_store_info_tb.sh
#
# Description   : This script is to run the CCN_INFO_TB_INSERT procedure which will insert data into the CCN_COST_CENTER_INFO_TB
#
# Created       : 03/12/2018
# 
###############################################################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="ccn_insert_into_store_info_tb"
LOGDIR="$HOME/batchJobs"
DATE=`date +"%m/%d/%Y"`

TimeStamp=`date '+%Y%m%d%H%M%S'`


TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set serveroutput on;
set heading off;
set verify off;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1

execute CCN_STORE_INFO_TB.CCN_INFO_TB_INSERT;

exit;
END

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
   echo "processing FAILED for $proc at ${TIME} on ${DATE}"
   ./send_mail.sh "CCN_STORE_INFO_REPORT_FAILURE"
   exit 1;
else
   TIME=`date +"%H:%M:%S"`
   echo "calling ccn_generate_store_info_file at ${TIME} on ${DATE}"
fi

$HOME/ccn_generate_store_info_file.sh

exit 0
#######################################################################################################################
