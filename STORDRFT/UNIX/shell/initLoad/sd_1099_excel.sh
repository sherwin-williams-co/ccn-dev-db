#!/bin/sh
##############################################################################################################
# Script name   : sd_1099_excel.sh
#
# Description   : This script is to run the SD_FILE_BUILD_PKG.STORE_DRAFT_INTALLER_1099
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 04/23/2015 axk326 CCN Project Team.....
#            Added call for date_host.sh file to pick up date_param.config file and to pull out the run date 
#            Added call for get_dateparam.sh to spool the dates to date_param.config file
##############################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="sd_1099_excel"
LOGDIR="$HOME/initLoad/logs"
TIME=`date +"%H:%M:%S"`
CURRENT_TIME=`date +"%H%M%S"`
P1=${QTLY_1099_RUNDATE}
TimeStamp=`date -d $P1 +"%Y%m%d"`$CURRENT_TIME
echo "Processing Started for $proc at $TIME for the date $P1"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set serveroutput on;
set verify off;

exec SD_FILE_BUILD_PKG.STORE_DRAFT_INTALLER_1099(to_date('$P1','MM/DD/YYYY'));

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
P1=${QTLY_1099_RUNDATE}
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} for the date ${P1}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} for the date ${P1}"  

exit 0
############################################################################
