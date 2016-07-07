#!/bin/sh
###############################################################################################################################
# Script name   : ccn_sd_posxml_daily_load.sh
#
# Description   : This script is to run the following:
#                 1. POSXML_PNP_TO_STRDRT_LOAD_PKG.PNP_TO_SD_LOAD_SP()
#                 2. NEW_POSXML_SD_DAILY_LOAD_TMP.POSXML_SD_DAILY_LOAD_SP('$DATE')
#
# Created  : 06/03/2016 axk326 CCN Project Team.....
# Modified : 
###############################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="PNP_TO_SD_LOAD_SP"
LOGDIR=$HOME/dailyLoad/logs
DATE=`date +"%d-%^b-%Y"`
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc_name"_"$DATE.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
POSXML_PNP_TO_STRDRT_LOAD_PKG.PNP_TO_SD_LOAD_SP();
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
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"
############################################################################

proc_name="POSXML_SD_DAILY_LOAD_SP"
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc_name"_"$DATE.log <<END
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
NEW_POSXML_SD_DAILY_LOAD_TMP.POSXML_SD_DAILY_LOAD_SP('$DATE');
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
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
