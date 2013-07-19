#!/bin/sh
#############################################################################
# Script Name   :  AUDIT_INITLOAD
#
# Description    :  This shell program will initiate the AUDIT_INITLOAD.SQL file 
#
# This shell program will initiate the AUDIT_INITLOAD script that 
#    * Disables all the Triggers 
#    * Deletes all the CCN tables
#    * Loads all the CCN tables
#    * Loads the Audit tables
#    * Re-Enables the Triggers
# from files sent from the Legacy IDMS CCN Database.
#
# Created           :  SH 05/13/2013
############################################################################
. /app/ccn/ccn.config

 proc="ccn_audit_initload_sp"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "\n Processing Started for $proc at $TIME on $DATE \n"

sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END
set heading off;
set verify off;

execute INITLOAD.CCN_AUDIT_INITLOAD_SP;

exit;
END

#check return code
rc=$?
if [[ $rc -ne 0 ]]; then
   exit $rc
fi

TIME=`date +"%H:%M:%S"`
echo "\nProcessing finished for $proc at ${TIME}\n"

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

