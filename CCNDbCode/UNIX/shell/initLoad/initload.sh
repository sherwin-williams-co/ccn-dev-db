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
# below command will get the path for ccn.config respective to the environment from which it is run from
. `cut -d/ -f1-4 <<<"${PWD}"`/ccn.config
 proc="ccn_audit_initload_sp"
 LOGDIR="$HOME/initLoad"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE "

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;

execute MAIL_PKG.send_mail('INIT_LOAD_START');
execute INITLOAD.CCN_AUDIT_INITLOAD_SP;
execute MAIL_PKG.send_mail('INIT_LOAD_END');

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0

############################################################################

