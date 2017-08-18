#!/bin/sh
#################################################################
# Script name   : ftp_misctran_primsub_trigger.sh
#
# Description   : This shell script will perform below tasks
#                 1. FTP the trigger file to get the GL60 job started
#
# Created  : 08/18/2017 nxk927 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="ftp_misctran_primsub_trigger"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"
#################################################################
#         FTP trigger file for GL60
#################################################################
if [ $FTP_INDICATOR == Y ] 
   then
   TIME=`date +"%H:%M:%S"`
   echo "Creating the trigger file at $TIME on $DATE"
   echo "misctrans_primesub ready" > misctrans_primesub.ok
   echo "Starting the FTP Process"    
ftp -n ${gl60_host} <<END_SCRIPT
quote USER ${gl60_user}
quote PASS ${gl60_pw}
cd ${gl60_path}
put misctrans_primesub.ok
quit
END_SCRIPT

status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at $TIME"
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Removing the trigger file as $TIME"

rm -f misctrans_primesub.ok

else

echo "FTP Not allowed in this environment. FTP Indicator must be set to Y to FTP the file"
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at $TIME"

exit 0