#!/bin/sh
########################################################################################################################
# Script name   : Load_lead_store_auto_rcncltn_data.sh
#
# Description   : This shell program will execute a SQL script to load data in LEAD_STORE_AUTO_RCNCLTN_DATA table.
#                 The script will load the data for leads/independent stores that are having auto-reconciliation set to "Y".
#                 
# Created       : 01/23/2017 gxg192 CCN Project Team.....
# Modified      : 
#                  
########################################################################################################################
. /app/banking/dev/banking.config

proc_name="Load_lead_store_auto_rcncltn"
LOGDIR=$HOME/logs
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc_name at $TIME on $DATE"

########################################################################
#               Loading LEAD_STORE_AUTO_RCNCLTN_DATA table
########################################################################
echo "Processing Started to load LEAD_STORE_AUTO_RCNCLTN_DATA table at $TIME on $DATE"

sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw <<END > $LOGDIR/$proc_name"_"$TimeStamp.log
set serveroutput on;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
var exitCode number;
exec :exitCode := 0;
@$HOME/sql/load_lead_store_auto_rcncltn_data.sql
exit :exitCode;
END

status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
   echo "Processing FAILED to load the LEAD_STORE_AUTO_RCNCLTN_DATA table at ${TIME} on ${DATE}"
   exit 1;
fi
echo "Processing completed to load the LEAD_STORE_AUTO_RCNCLTN_DATA table at ${TIME} on ${DATE}"

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at $TIME on $DATE"

exit 0
######################################################################
#                            Process END 
######################################################################
