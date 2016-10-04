#!/bin/sh
#######################################################################################
# Script Name   :  CREDIT_HIERARCHY_LOAD.sh
#
# Description    :  This shell program will initiate the CREDIT_HIERARCHY_LOAD_MAIN_SP
#
# This shell program will perform the following Steps:
# * Disables all the Triggers for HIERARCHY_DETAIL Table
# * Deletes the already existing data for this CREDIT_HIERARCHY before starting the load process
# * Loads the HIERARCHY_HEADER,HIERARCHY_DESCRIPTION, INTERMEDIATE  tables
# * Loads the HIERARCHY_DETAIL table with the Credit Hierarchy data
# * Re-Enables the Triggers
#
# Created :  sxh487 03/02/2016
# Modified:  axk326 10/04/2016
#            Added code for exception handling when ever there is OS/SQL Error
#######################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="CREDIT_HIERARCHY_LOAD"
LOGDIR="$HOME/hier"
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
CREDIT_HIERARCHY_LOAD.CREDIT_HIERARCHY_LOAD_MAIN_SP();
EXCEPTION
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"

exit 0

############################################################################
