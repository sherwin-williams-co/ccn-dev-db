#!/bin/sh
#############################################################################
# Script Name   :  ccn_sd_daily_load
#
# Description    : This shell program will initiate the script that 
#
#    * Loads all the store drafts tables
#
# It also sends the emails regarding starting and ending of the process
#
# Created           :  08/19/2014
# Modified          :  
############################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 proc="CCN_SD_DAILY_LOAD_SP"
 LOGDIR="$HOME/initLoad/STORDRFT"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

#run the shell script to concatenate the daily files and archiving the individual files
./dailyLoad_CAT_Archieve.sh

#load the data from cpr into stordrft database
./cc_employee_tax_load.sh

sqlplus -s -l $strdrft_sqlplus_user/$strdrft_sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;

execute MAIL_PKG.send_mail('SD_DAILY_LOAD_START');
execute SD_DAILY_LOAD.CCN_SD_DAILY_LOAD_SP();
execute SD_PAID_DETAILS_LOAD.CCN_SD_PAID_LOAD_SP();
execute MAIL_PKG.send_mail('SD_DAILY_LOAD_END');

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  

##############################################################################
#  Execute employee_details_sync.sh to sync the employee details to TERR and MANAGER
##############################################################################
echo "Concatenating Started at ${TIME} on ${DATE}"
cd $HOME/batchJobs

./employee_details_sync.sh

echo "Processing Finished for employee_details_sync at ${TIME} on ${DATE}"


#################################################
#    ERROR STATUS CHECK employee_details_sync.sh 
#################################################
status=$?
if test $status -ne 0
   then
     echo "processing FAILED for employee_details_sync at ${TIME} on ${DATE}"
     exit 1;
fi

exit 0

############################################################################

