#!/bin/sh
#################################################################
# Script name   : archive_pos_file.sh
#
# Description   : This shell program will Archive the POS file
#
# Created  : 09/04/2015 axk326 CCN Project Team.....
# Modified : 
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/ccn/host.sh

proc_name="archive_pos_file"
CUR_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/initLoad/POS_FILES"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
file_date=`date +"%d%b%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

# Control will output if $DIRECTORY exists.
if [ -d "$CUR_PATH/"POS_FILES"" ]; then
   echo " Directory exists "
else
  mkdir $CUR_PATH/"POS_FILES"
fi

cd $CUR_PATH
#Archive file for suntrust.
if 
    ls MQ_CONVERT_FILE &> /dev/null; then
    echo " POS file exist "
    find -maxdepth 1 -name MQ_CONVERT_FILE -exec mv {} $ARCHIVE_PATH/"MQ_CONVERT_FILE"_$file_date \; > /dev/null 2>&1
else
    echo " POS file does not exist "
fi

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
