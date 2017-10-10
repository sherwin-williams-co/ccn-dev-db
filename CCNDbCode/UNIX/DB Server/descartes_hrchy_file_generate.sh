#!/bin/sh
###############################################################################################################################
# Script name   : descartes_hrchy_file_generate.sh
#
# Description   : This script is to generate and send an org (hierarchy details) feed every day
#                   as a pipe delimited file as part of the DESCARTES feed
# Created  : 09/28/2017 rxa457 CCN Project Team.....
###############################################################################################################################
# below command will get the path for config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="descartes_hrchy_file_generate"
datafilepath=$HOME/datafiles
LOGDIR="$HOME/batchJobs"
DATE=`date +"%m/%d/%Y"`
RUNDATE=`date --date="yesterday" +%m/%d/%Y`
FILEDATE=`date +"%m%d%y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc at $TIME on $DATE" 

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1

execute CCN_DESCARTES_PROCESS.GENERATE_DESCARTES_HRCHY_FILE;

exit;
END

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if test $status -ne 0
then
   echo "processing FAILED for $proc at ${TIME} on ${DATE}"
   
   logfile=`cat $LOGDIR/$proc"_"$TimeStamp.log`

   #Emailing the Current run's Log File
   cd $HOME/
   sh /app/ccn/dev/send_mail.sh DESCARTES_HRCHY_FILE_ERROR "$logfile"
   
   exit 1;
fi
#######################################################################################################################

echo "Process to generate org (hierarchy details) feed file for DESCARTES executed successfully $RUNDATE at ${TIME} on ${DATE}"

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"

exit 0
#######################################################################################################################
