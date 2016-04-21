#!/bin/sh
############################################################################################################################
# Script name   : EXEC_PROC_1PARAM.sh
#
# Description   : Wrapper for executing procedures with 1 date parameter,
#                 accepts proc name and week number as parameters 1 and 2
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 11/18/2015 axk326 CCN Project Team.....
#            Added Error handling calls to send email when ever the script errors out due to any of the OSERROR or SQLERROR
#          : 3/18/2016 nxk927 CCN Project Team.....
#            Changed the order of declaring variables after capturing the STATUS to avoid the scenario where
#            the ERROR CODE that needs to be captured, will not be overwritten in the ERROR STATUS CHECK block and added the error message 
############################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name=$1"(to_date('$2','MM/DD/YYYY'));"
LOGDIR=$HOME/dailyLoad/logs
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$1"_"$TimeStamp.log <<END
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
     cd $HOME/dailyLoad
     ./send_err_status_email.sh SD_BATCH_PROCESSING_ERROR
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

exit 0
############################################################################
