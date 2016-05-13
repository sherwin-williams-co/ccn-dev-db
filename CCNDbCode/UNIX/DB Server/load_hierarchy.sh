#!/bin/sh
#############################################################################
# Script Name   :  LOAD_HIERARCHY
#
# Description    :  This shell program will initiate the HIER_LOAD_MAIN_SP 
#
# This shell program will initiate the LOAD_HIERARCHY script that 
#    * Disables all the Hierarchy Triggers 
#    * Deletes all the CCN Hierarchy tables
#    * Loads all the CCN Hierarchy tables
#    * Re-Enables the Triggers
#    * from files sent from the Legacy IDMS CCN Database.
#
# It also sends the emails regarding starting and ending of the process
#
# Created           :  SH 09/24/2013
############################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. `cut -d/ -f1-4 <<<"${PWD}"`/ccn.config

 proc="hier_load_main_sp"
 LOGDIR="$HOME/hier"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;

execute MAIL_PKG.send_mail('HIER_LOAD_START');
execute HIERARCHY_LOADING_PKG.HIER_LOAD_MAIN_SP;
execute MAIL_PKG.send_mail('HIER_LOAD_END');

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

