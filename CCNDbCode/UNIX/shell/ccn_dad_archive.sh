#!/bin/sh
###########################################################################################
# Script Name    :  ccn_dad_archive.sh
#
# Description    :  This shell program will archive the dad files once process is finished
#                   
# Created        :  AXK326 05/15/2015
###########################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc="ccn_sd_dad_archive"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
file_date=`date +"%d%b%Y"`
ARCHIVE_PATH="$HOME/initLoad"

echo "Processing Started for $proc at $TIME on $DATE"

# Control will output if $DIRECTORY exists.
if [ -d "$ARCHIVE_PATH/"dad_files ]; then
   echo " Directory exists "
else
  mkdir $ARCHIVE_PATH/"dad_files"
fi

cd $ARCHIVE_PATH
#Archive dad_file.
if 
    ls STFF1002.TXT &> /dev/null; then
    echo " DAD Comparison file exist "
    find -name STFF1002.TXT -exec mv {} $ARCHIVE_PATH/dad_files/"STFF1002"_$file_date.TXT \; > /dev/null 2>&1
else
    echo " DAD Comparison file doesn't exist "
fi

#Moving back to invoking folder as the process has to continue
cd $HOME/batchJobs

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

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  

############################################################################