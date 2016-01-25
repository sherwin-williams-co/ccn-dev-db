#!/bin/sh
#######################################################################################
# Description     : This script will place a trigger file to the application server that
#                   triggers the report run
#
# Created         : 01/15/2016 jxc517 CCN Project Team....
# Modified        :    
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
echo " FTP Process Successful "

rm -f sd_monthly_load.trg

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0
