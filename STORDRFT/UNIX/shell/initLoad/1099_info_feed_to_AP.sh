#!/bin/sh
##############################################################################################################
# Script name   : 1099_consolidated_report.sh
#
# Description   : This shell program will initiate the monthly 1099 information feed to AP
#
# Created  : 07/30/2015 nxk927 CCN Project Team.....
# Modified : 12/03/2015 nxk927 CCN Project Team.....
#            calling the wrapper procedure that will invoke all the procedure to generate all the 1099_consolidated_report
##############################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="1099_consolidated_report"
LOGDIR="$HOME/initLoad/logs"
TIME=`date +"%H:%M:%S"`
DATE=${MNTLY_1099_RUNDATE} 
DATE1=${JV_MNTLY_RUNDATE}
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
execute SD_FILE_BUILD_PKG.SD_1099_CONSOLIDATED_RPT(to_date('$DATE','MM/DD/YYYY'), to_date('$DATE','MM/DD/YYYY'),to_date('$DATE1','MM/DD/YYYY'),to_date('$DATE1','MM/DD/YYYY'));
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

