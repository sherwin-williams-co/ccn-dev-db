#!/bin/sh
#################################################################
# Script name   : ftp_param.sh
#
# Description   : 
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="ftp_param"
LOGDIR=$HOME/dailyLoad/logs
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
echo "Processing Started for $proc_name at $TIME on $DATE"

# Move to datafiles from where ever you are in
cd /app/stordrft/dev/Reports
# ftp to app server
ftp -n ${appserver_host} <<END_SCRIPT
quote user ${appserver_user}
quote pass ${appserver_pw}

cd /app/strdrft/sdReport/data
put param1.lst param.lst

quit

END_SCRIPT

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
