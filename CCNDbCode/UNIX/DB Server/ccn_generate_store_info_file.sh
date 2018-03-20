#!/bin/sh
###############################################################################################################################
# Script name   : ccn_generate_store_info_file.sh
#
# Description   : This script is to refresh the CCN_ADDRESS_GEO_DETAILS table from ADDRESS_GEO_V view
#
# Created  : 03/15/2018    rxv940 CCN Project Team....
# 
###############################################################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="ccn_generate_store_info_file"
LOGDIR="$HOME/batchJobs"
DATE=`date +"%m/%d/%Y"`

TimeStamp=`date '+%Y%m%d%H%M%S'`


TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc at $TIME on $DATE"   >> $LOGDIR/$proc"_"$TimeStamp.log

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set serveroutput on;
set heading off;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
CCN_BATCH_PROCESS.LOAD_ADDRESS_GEO_DETAILS;
Exception
when others then
:exitCode:=2;
END;
/
exit :exitCode
END


############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
    echo " $proc_name --> processing FAILED while executing $proc at $DATE:$TIME "     >> $LOGDIR/$proc"_"$TimeStamp.log
    ./send_mail.sh "LOAD_CCN_ADDRESS_GEO_DETAILS"
   exit 1
else
   echo "Processing finished for $proc at ${TIME} on ${DATE}"   >> $LOGDIR/$proc"_"$TimeStamp.log
fi

exit 0
#######################################################################################################################
