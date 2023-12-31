#!/bin/sh
#######################################################################################
# Description     : Script to FTP dbfile1099 file to the swerp_host server
#                   once the execution of 1099 monthly process is completed.
# Created         : 04/22/2015 jxc517 Store Drafts Project....
# Modified        : 04/27/2015 axk326 CCN Project Team.....
#                   Substituted hard coded date value with the date value from date_param.config file
#                 : 03/18/2016 nxk927 CCN Project Team.....
#                   Changed the order of declaring variables after capturing the STATUS to avoid the scenario where
#                   the ERROR CODE that needs to be captured, will not be overwritten in the ERROR STATUS CHECK block
#                 : 03/24/2016 nxk927 CCN Project Team.....
#                   changed the error check to make it uniform
#######################################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from.
. /app/stordrft/host.sh

proc="ftp_1099_monthly_file"
TIME=`date +"%H:%M:%S"`
CURRENT_TIME=`date +"%H%M%S"`
DATE=`date -d ${MNTLY_1099_RUNDATE} +"%m/%d/%Y"`
dbfile1099=1099_MONTHLY_*
appfile1099=`date -d ${MNTLY_1099_RUNDATE} +"STINSINV01%Y%m%d"$CURRENT_TIME".TXT"`

echo "Processing Started for $proc at ${TIME} on ${DATE}"

ftp -n ${swerp_host} <<END_SCRIPT
quote USER ${swerp_user}
quote PASS ${swerp_pw}

put $dbfile1099 $appfile1099

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

if [ -d "$HOME/Monthly/1099" ]; then
   echo " Directory exists "
else
  mkdir $HOME/Monthly/1099
fi

#Archieve the monthly 1099 files
mv $dbfile1099 $HOME/Monthly/1099/
echo "$dbfile1099 has been archieved to $HOME/Monthly/1099/ path"

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"

exit 0
