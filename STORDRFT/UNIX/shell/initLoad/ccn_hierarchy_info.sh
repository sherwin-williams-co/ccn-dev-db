#!/bin/sh
#################################################################
# Script name   : ccn_hierarchy_info.sh
#
# Description   : Tshi script will invoke SD_REPORT_PKG.CCN_HIERARCHY_INFO
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 04/28/2015 axk326 CCN Project Team.....
#            Added parameter to pick up the date from the config file 
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="ccn_hierarchy_info"
LOGDIR=$HOME/dailyLoad/logs
TIME=`date +"%H:%M:%S"`
DATE=${SD_REPORT_QRY_RUNDATE}
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

echo " START TRUCATING AND LOADING : Process Started at $TIME on $DATE "

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;

EXECUTE SD_REPORT_PKG.CCN_HIERARCHY_INFO();

exit
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
