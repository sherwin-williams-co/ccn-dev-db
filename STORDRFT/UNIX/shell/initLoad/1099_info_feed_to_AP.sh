#!/bin/sh
##############################################################################################################
# Script name   : 1099_consolidated_report.sh
#
# Description   : This shell program will initiate the monthly 1099 information feed to AP
#
# Created  : 07/30/2015 nxk927 CCN Project Team.....
# Modified : 
#
##############################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="1099_consolidated_report"
LOGDIR="$HOME/initLoad/logs"
TIME=`date +"%H:%M:%S"`
DATE=${MNTLY_1099_RUNDATE} 
#DATE=`date -d "-1 month -$(($(date +%d)-1)) days" "+%d-%b-%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
execute SD_FILE_BUILD_PKG.SD_1099_NO_MTCHD_VENDOR_RPRT(to_date('$DATE','MM/DD/YYYY'));
execute SD_FILE_BUILD_PKG.SD_1099_MTCHD_PRCSNG_RPRT(to_date('$DATE','MM/DD/YYYY'));
execute SD_FILE_BUILD_PKG.SD_1099_NO_VNDR_ON_BNK_TP_RPRT(to_date('$DATE','MM/DD/YYYY'));
execute SD_FILE_BUILD_PKG.SD_1099_TXPYR_ID_AP_TRNS_CRT(to_date('$DATE','MM/DD/YYYY'));
exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi
echo "Processing finished for $proc at ${TIME} on ${DATE}"  
exit 0
############################################################################

