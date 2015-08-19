#!/bin/sh
##############################################################################################################
# Script name   : 1099_FSS_mid_monthly_file_gen.sh
#
# Description   : This shell program will initiate the mid monthly 1099 FSS process
#
# Created  : 07/29/2015 jxc517 CCN Project Team.....
# Modified : 
#
##############################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="1099_FSS_monthly_file_gen"
LOGDIR="$HOME/initLoad/logs"
TIME=`date +"%H:%M:%S"`
DATE=${MNTLY_1099_RUNDATE} 
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
execute SD_FILE_BUILD_PKG.BUILD_1099_FILE_FOR_FSS(to_date('$DATE','MM/DD/YYYY'), 'Y');
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
