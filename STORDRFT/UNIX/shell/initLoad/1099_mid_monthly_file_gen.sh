#!/bin/sh
###################################################################################################
# Script name   : 1099_mid_monthly_file_gen.sh
#
# Description   : This shell program will initiate the mid-monthly 1099 process
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 11/24/2014 jxc517 CCN Project Team.....
#            Added date parameter to run for previous month
#          : 04/23/2015 axk326 CCN Project Team.....
#            Added call to pick up date_param.config file and to pull out the run date 
#            Added call for get_dateparam.sh to spool the dates to date_param.config file
###################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="1099_mid_monthly_file_gen"
LOGDIR="$HOME/initLoad/logs"
TIME=`date +"%H:%M:%S"`
CURRENT_TIME=`date +"%H%M%S"`
P1=${MID_MNTLY_1099_RUNDATE}
TimeStamp=`date -d $P1 +"%Y%m%d"`$CURRENT_TIME
echo "Processing Started for $proc at $TIME for the date $P1"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;

execute SD_FILE_BUILD_PKG.BUILD_1099_FILE(to_date('$P1','MM/DD/YYYY'),'Y');

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
P1=${MID_MNTLY_1099_RUNDATE}
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} for the date ${P1}"
     exit 1;
fi

echo "Processing finished for $proc at ${TIME} for the date ${P1}"  

exit 0
############################################################################
