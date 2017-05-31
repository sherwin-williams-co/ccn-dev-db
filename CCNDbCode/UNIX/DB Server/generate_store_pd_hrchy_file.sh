#!/bin/sh
###############################################################################################################################
# Script name   : generate_store_pd_hrchy_file.sh.sh
#
# Description   : This script is to generate a weekly Store Pricing District Hierarchy report, Every monday at 8:00 AM for stores pricing group as per users request around pricing #data and polling information
#
# Created  : 5/30/2017 rxa457 CCN Project Team.....
###############################################################################################################################
# below command will get the path for config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="generate_store_pd_hrchy_file.sh"
datafilepath=$HOME/datafiles
LOGDIR="$HOME/batchJobs"
DATE=`date +"%m/%d/%Y"`
RUNDATE=`date --date="yesterday" +%m/%d/%Y`
FILEDATE=`date +"%m%d%y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc at $TIME on $DATE" >> $LOGDIR/$proc"_"$TimeStamp.log

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1

execute CCN_BATCH_PROCESS.GENERATE_STORE_PD_HRCHY_FILE;

exit;
END

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
   echo "processing FAILED for $proc at ${TIME} on ${DATE}" >> $LOGDIR/$proc"_"$TimeStamp.log
   
   #Identify starting Line number of current run from the log file
   curlineno=`grep -n "Processing Started for generate_store_pd_hrchy_file.sh" $LOGDIR/$proc"_"$TimeStamp.log|cut -f1 -d:|tail -1`
   #Tail the current run log file content
   logfile=`sed -n -e ''''$curlineno''',$p' $LOGDIR/$proc"_"$TimeStamp.log`

   #Emailing the Current run's Log File
   cd $HOME/
   ./send_mail.sh STORE_PDH_HRCHY_ERROR "$logfile"
   
   exit 1;
fi

echo "Process to generate weekly Store Pricing District Hierarchy report file executed successfully for $RUNDATE at ${TIME} on ${DATE}" >> $LOGDIR/$proc"_"$TimeStamp.log

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}" >> $LOGDIR/$proc"_"$TimeStamp.log

exit 0
#######################################################################################################################
