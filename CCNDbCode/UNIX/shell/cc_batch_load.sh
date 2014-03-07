#!/bin/sh
#############################################################################
# Script Name   :  AUDIT_INITLOAD
#
# Description    :  This shell program will initiate the AUDIT_INITLOAD_SP 
#
# This shell program will initiate the AUDIT_INITLOAD script that 
#    * Disables all the Triggers 
#    * Deletes all the CCN tables
#    * Loads all the CCN tables
#    * Loads the Audit tables
#    * Re-Enables the Triggers
# from files sent from the Legacy IDMS CCN Database.
#
# It also sends the emails regarding starting and ending of the process
#
# Created           :  SH 09/24/2013
############################################################################
. /app/ccn/ccn.config

 proc="ccn_audit_initload_sp"
 LOGDIR="/app/ccn/initLoad"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

ORACLE_HOME=/swstores/oracle/stcprq/product/11g
export ORACLE_HOME

ORACLE_SID=STCPRQ2
export ORACLE_SID

PATH=$PATH:$ORACLE_HOME/bin 
export PATH

echo "\n Processing Started for $proc at $TIME on $DATE \n"

$ORACLE_HOME/bin/sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;

execute MAIL_PKG.send_mail('CC_BATCH_LOAD_START');
execute  COST_CENTER_UPLOAD.BATCH_LOAD_PROCESS();
execute MAIL_PKG.send_mail('CC_BATCH_LOAD_END');

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     echo "\n processing FAILED for $proc at ${TIME} on ${DATE}\n"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "\n Processing finished for $proc at ${TIME} on ${DATE}\n"  

exit 0

############################################################################

