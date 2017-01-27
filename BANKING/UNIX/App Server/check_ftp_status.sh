#!/bin/sh
#####################################################################################
# Script name   : check_ftp_status.sh
#
# Description   : This script can be used to check if the Transfer of the
#                 required file from one server to another is successful or not.
#                 This script accepts the complete path for logfile of FTP process 
#                 and checks if any error code (FTP error code starts with 4 or 5)
#                 is present in it.
#
# Created  : 01/26/2017 gxg192 CCN Project Team.....
# Modified :
#####################################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="check_ftp_status"
DATE=`date +"%m/%d/%Y"`
FTPLOG=$1

TIME=`date +"%H:%M:%S"`
echo "Process started for $proc_name at $TIME on $DATE"

########################################################################################################
#  Checking each line in log file if it is starting with 4 or 5 (as FTP error code starts with 4 or 5)
########################################################################################################

while read -r line
do
   if  [[ $line == 4* ]] || [[ $line == 5* ]] ;
   then
      echo "FTP Failed!! Error code - $line"
      exit 1
   fi
   echo $line
done < "$FTPLOG"

########################################################################################################
#  If above block is successful then check if code 226 is present 
#  to confirm the transfer completed successfully.
########################################################################################################

FTP_SUCCESS_MSG="226 Transfer complete"
if fgrep "$FTP_SUCCESS_MSG" $FTPLOG ;then
   echo "FTP is successful."
else
   echo "FTP process Failed!!"
   exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "Process completed for $proc_name at $TIME on $DATE"
exit 0
