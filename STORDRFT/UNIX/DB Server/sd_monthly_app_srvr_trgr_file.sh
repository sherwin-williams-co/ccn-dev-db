#!/bin/sh
#######################################################################################
# Description     : This script will place a trigger file to the application server that
#                   triggers the report run
#
# Created         : 01/15/2016 jxc517 CCN Project Team....
# Modified        : 04/06/2016 nxk927 CCN Project Team....
#                   changed the error check to make it uniform and pushed the echo at the end
#######################################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from.
. /app/stordrft/host.sh

proc="sd_monthly_app_srvr_trgr_file.sh"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

echo "Processing Started for $proc at ${TIME} on ${DATE}"

echo "" > sd_monthly_load.trg

ftp -n ${appserver_host} <<END_SCRIPT
quote USER ${appserver_user}
quote PASS ${appserver_pw}
cd /app/strdrft/sdReport/data

put sd_monthly_load.trg

quit
END_SCRIPT

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
   TIME=`date +"%H:%M:%S"`
   echo "processing FAILED for $proc at ${TIME} on ${DATE}"
   exit 1;
fi

echo " FTP Process Successful "
rm -f sd_monthly_load.trg

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"

exit 0
