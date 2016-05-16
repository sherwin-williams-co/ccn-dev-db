#!/bin/sh
##############################################################################################################
# Script name   : load_vendor_info.sh
#
# Description   : This shell program will load the vendor process daily
#
# Created  : 07/29/2015 nxk927 CCN Project Team.....
# Modified : 
#
##############################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc="Load_Vendor_Information"
LOGDIR="$HOME/initLoad/logs"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
execute SD_FILE_BUILD_PKG.LOAD_VENDOR_INFORMATION();
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
