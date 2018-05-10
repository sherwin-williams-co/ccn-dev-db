#!/bin/sh
###############################################################################################################################
# Script name   : gl_accnt_rltn_dtls_onetime_run.sh
#
# Description   : This script is to expire the GL_ACCOUNT_NUMBER 0400056
#
# Created       : 05/10/2018 nxk927 CCN Project Team.....
# Modified      :
###############################################################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/ccn_app_server.config

DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

echo "Processing Started for gl_accnt_rltn_dtls_onetime_run at $TIME on $DATE"

sqlplus -s -l "$sqlplus_user"@"$sqlplus_sid"/"$sqlplus_pw" << END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
UPDATE GENERAL_LEDGER_ACCOUNTS
   SET EXPIRATION_DATE = TRUNC(SYSDATE)
 WHERE GL_ACCOUNT_NUMBER = '0400056';

COMMIT;

PRIME_SUB_PROCESS.POS_TRG_EVENT_LOG('0400056', 'GENERAL_LEDGER_ACCOUNTS', 'CHANGE', 'POS_PRIMESUB_UPDATE' );
Exception
 when others then
 :exitCode := 2;
END;
/
END

status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for gl_accnt_rltn_dtls_onetime_run at $TIME on $DATE "
    exit 1
fi

cd /app/ccn/scripts

TIME=`date +"%H:%M:%S"`
echo "Processing Started for polling_maintenance_process at $TIME on $DATE"
./polling_maintenance_process.sh

TIME=`date +"%H:%M:%S"`
echo "Processing Finished for polling_maintenance_process at $TIME on $DATE"
############################################################################
#                           ERROR STATUS CHECK
############################################################################

TIME=`date +"%H:%M:%S"`
echo "Processing finished for gl_accnt_rltn_dtls_onetime_run at ${TIME} on ${DATE}"

exit 0
############################################################################
