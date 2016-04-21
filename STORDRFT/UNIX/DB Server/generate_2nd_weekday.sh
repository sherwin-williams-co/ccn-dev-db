#!/bin/sh
##################################################################################################################################
# Script name   : generate_2nd_weekday.sh
#
# Description   : This script will invoke SD_COMMON_TOOLS.GENERATE_SECOND_WEEKDAY
#                 and generate a file with the second weekday of the month
#
# Created       : 03/01/2016 nxk927 CCN Project Team.....
# Modified      : 03/18/2016 nxk927 CCN Project Team.....
#                 Added Error message
#################################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="GENERATE_2ND_WEEKDAY"
LOGDIR=$HOME/Reports/log
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "PROCESSING STARTED FOR $proc_name AT $TIME ON $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
SD_COMMON_TOOLS.GENERATE_SECOND_WEEKDAY();
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
if [ $status -ne 0 ]; then
   TIME=`date +"%H:%M:%S"`
   echo "PROCESSING FAILED FOR $proc_name AT ${TIME} ON ${DATE}"
   exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "PROCESSING FINISHED FOR $proc_name AT ${TIME} ON ${DATE}"

exit 0
############################################################################
