#!/bin/sh
##############################################################################################################
# Script name   : 1099_info_feed_to_AP.sh
#
# Description   : This shell program will initiate the monthly 1099 information feed to AP
#
# Created  : 07/30/2015 nxk927 CCN Project Team.....
# Modified : 12/03/2015 nxk927 CCN Project Team.....
#            calling the wrapper procedure that will invoke all the procedure to generate all the 1099_consolidated_report
#          : 03/18/2016 nxk927 CCN Project Team.....
#            Changed the order of declaring variables after capturing the STATUS to avoid the scenario where
#            the ERROR CODE that needs to be captured, will not be overwritten in the ERROR STATUS CHECK block
#            Added Error handling calls
##############################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="1099_consolidated_report"
LOGDIR="$HOME/initLoad/logs"
TIME=`date +"%H:%M:%S"`
DATE=${JV_MNTLY_RUNDATE}
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
SD_FILE_BUILD_PKG.SD_1099_CONSOLIDATED_RPT(to_date('$DATE','MM/DD/YYYY'), to_date('$DATE','MM/DD/YYYY'));
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
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  
exit 0
############################################################################

