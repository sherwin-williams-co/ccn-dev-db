#!/bin/sh
###############################################################################################################################
# Script name   : ccn_selling_stores_email.sh
#
# Description   : This script is to run the following:
#                 CCN_BATCH_PROCESS.GENERATE_SELLING_STORE_FILE
#
# Created  : 09/29/2016 jxc517 CCN Project Team.....
# Modified : 04/03/3017 gxg192 Added WHENEVER clause to track error
###############################################################################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="ccn_selling_stores_email"
datafilepath=$HOME/datafiles
LOGDIR="$HOME/batchJobs"
DATE=`date +"%m/%d/%Y"`
RUNDATE=`date +"%m%d%y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1

execute CCN_BATCH_PROCESS.GENERATE_SELLING_STORE_FILE(TO_DATE('$DATE', 'MM/DD/YYYY'));

exit;
END

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if test $status -ne 0
then
   TIME=`date +"%H:%M:%S"`
   echo "processing FAILED for $proc at ${TIME} on ${DATE}"
   exit 1;
fi

cd $datafilepath
csv_files=`ls *_SELLING_STORES_$RUNDATE.csv`
for file in $csv_files
do
   filename=`echo "$file" | cut -d'.' -f1`
   extension=`echo "$file" | cut -d'.' -f2`
   echo renaming $file to $filename"_"$TimeStamp.$extension
   mv $file $filename"_"$TimeStamp.$extension
done

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"

exit 0
#######################################################################################################################
