#!/bin/sh
#######################################################################################
# Description     : Script to FTP PAID_DRAFT.TRG file to the STDSSAPHQ server 
#                   once the execution of JV_monthly_load.sh scripts is completed. 
# Created         : 04/22/2015 jxc517 Store Drafts Project....
# Modified        : 04/27/2015 axk326 CCN Project Team.....
#                   Substituted hard coded date value with the date value from date_param.config file
#######################################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from.
. /app/stordrft/host.sh

proc="ftp_1099_monthly_file"
TIME=`date +"%H:%M:%S"`
CURRENT_TIME=`date +"%H%M%S"`
DATE=`date -d ${MNTLY_1099_RUNDATE} +"%m/%d/%Y"`
dbfile1099=1099_MONTHLY_*
appfile1099=`date -d $DATE +"STINSINV01%Y%m%d"$CURRENT_TIME".TXT"`

echo "Processing Started for $proc at ${TIME} on ${DATE}"

ftp -n ${swerp_host} <<END_SCRIPT
quote USER ${swerp_user}
quote PASS ${swerp_pw}

put $dbfile1099 $appfile1099

quit
END_SCRIPT
echo " FTP Process Successful "

if [ -d "$HOME/Monthly/1099" ]; then
   echo " Directory exists "
else
  mkdir $HOME/Monthly/1099
fi

#Archieve the monthly 1099 files
mv $dbfile1099 $HOME/Monthly/1099/
echo "$dbfile1099 has been archieved to $HOME/Monthly/1099/ path"

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
