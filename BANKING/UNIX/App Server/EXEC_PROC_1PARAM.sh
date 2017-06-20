#!/bin/sh
############################################################################################################################
# Script name   : EXEC_PROC_1PARAM.sh
#
# Description   : Wrapper for executing procedures with 1 parameter
#
# Created  : 06/16/2017 gxg192 CCN Project Team.....
# Modified : 
############################################################################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name=$1"('$2');"
LOGDIR=$HOME/logs
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw << END
set heading off;
set serveroutput on;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
$proc_name
Exception
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode
END

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
   TIME=`date +"%H:%M:%S"`
   echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
   exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

exit 0
############################################################################

