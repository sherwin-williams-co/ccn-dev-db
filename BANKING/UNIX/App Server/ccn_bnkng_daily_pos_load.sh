#!/bin/sh
###################################################################################
# Script name   : ccn_bnkng_daily_pos_load.sh
#
# Description   : This script is created to Load data from POS to CCN tables for 
#                 Banking gift card and Deposit ticket/bags daily.
#
# Created  : 06/22/2017 gxg192 CCN Project Team
# Modified : 06/26/2017 gxg192 Changes to pass only category while calling send_mail.sh
#                              and removed logic to send success email.
#
###################################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="ccn_bnkng_daily_pos_load"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
RUNDATE=`date +"%d-%b-%Y"`

echo "Processing Started for $proc_name at $TIME on $DATE"

###################################################################################
#                  Load the data from POS to CCN Banking tables.
###################################################################################
./EXEC_PROC_1PARAM.sh "POS_BANKING_DAILY_LOAD.POS_BANKING_DAILY_LOAD_SP" "$RUNDATE"
status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
     echo "Processing FAILED for Loading banking data from POS at ${TIME} on ${DATE}"
     ./send_mail.sh POS_BANK_DATA_LOAD_ERROR
     exit 1
fi

echo "Processing finished for $proc_name at $TIME on $DATE"
exit 0
###################################################################################
#                Process END
###################################################################################
