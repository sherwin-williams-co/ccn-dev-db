#!/bin/sh
###############################################################################################################################
# Script name   : ccn_accnt_view_rpt.sh
#
# Description   : This script is to run the following:
#                 CCN_ACCOUNTING_PKG.GEN_CCN_ACCOUNTING_REPORT
#
# Created  : 06/19/2017 axt754 CCN Project Team.....
# Modified : 06/25/2018 sxg151 CCN Project Team....
#            ASP-1075 Added New Prod SEND_EPM_FILES to Send Accounting and EPM files together.
# 
###############################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="ccn_accnt_view_rpt"
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

execute CCN_ACCOUNTING_PKG.SEND_EPM_FILES();

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
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"

exit 0
#######################################################################################################################
