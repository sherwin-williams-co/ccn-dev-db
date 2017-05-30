#!/bin/sh


###############################################################################################################################
# Script name   : ccn_generate_store_data_file.sh
#
# Description   : This script is to run the following:
#                 CCN_BATCH_PROCESS.GENERATE_STORE_DATA_FILE
#
# Created  : 05/25/2017 sxp130 CCN Project Team.....
# Modified : 
###############################################################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="ccn_generate_store_data_file"
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

execute CCN_BATCH_PROCESS.GENERATE_STORE_DATA_FILE;

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
   exit 1;
fi
cd $datafilepath
csv_files=`ls *_BC_$FILEDATE.csv*`
for file in $csv_files
do
   filename=`echo "$file" | cut -d'.' -f1`
   extension=`echo "$file" | cut -d'.' -f2`
   echo renaming $file to $filename"_"$TimeStamp.$extension
   mv $file $filename"_"$TimeStamp.$extension
done

cd $datafilepath
dat_files=`ls *_BC_$FILEDATE.dat*`
for file in $dat_files
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
