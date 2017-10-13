#!/bin/sh
#############################################################################
# Script Name   :  prime_gl_accounts_load.sh
#
# Description    :  This shell program will initiate the PRIME_GL_ACCNT_UI_UPSERT_SP 
#
# This shell script does the following 
# # Reads the xml file from directory 
  # Disable Triggers on General_ledger_accounts and GL_PRIME_SUB_ACCOUNT_DTLS
  # Deletes the Data from General_ledger_accounts and GL_PRIME_SUB_ACCOUNT_DTLS
  # Loads the Data into General_ledger_accounts and GL_PRIME_SUB_ACCOUNT_DTLS
  # Enable Triggers on General_ledger_accounts and GL_PRIME_SUB_ACCOUNT_DTLS
#
# Created :  axt754 03/27/2017
############################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 proc="GL_PS_ACCNTS_INIT_LOAD"
 LOGDIR="$HOME/initLoad"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`
 

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
SET SERVEROUTPUT ON;
execute CCN_GL_PS_ACCNTS_INIT_LOAD.PRIME_GL_ACCOUNTS_MAIN_SP();

exit;
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
