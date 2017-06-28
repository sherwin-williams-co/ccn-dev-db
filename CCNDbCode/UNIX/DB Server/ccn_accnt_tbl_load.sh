#!/bin/sh
###############################################################################################################################
# Script name   : ccn_accnt_tbl_load.sh
#
# Description   : This script is to run the following on last day of month
#                 CCN_ACCOUNTING_PKG.LOAD_CCN_ACCOUNTING_TABLE
#
# Created  : 06/27/2017 axt754 CCN Project Team.....
# 
###############################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="ccn_accnt_tbl_load"
LOGDIR="$HOME"
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

execute CCN_ACCOUNTING_PKG.LOAD_CCN_ACCOUNTING_TABLE(TRUNC(SYSDATE));

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
   exit 1;
else
   TIME=`date +"%H:%M:%S"`
   echo "Processing finished for $proc at ${TIME} on ${DATE}"
   TIME=`date +"%H:%M:%S"`
   echo "calling ccn_accnt_view_rpt at ${TIME} on ${DATE}"
   ./ccn_accnt_view_rpt.sh
fi

exit 0
#######################################################################################################################
