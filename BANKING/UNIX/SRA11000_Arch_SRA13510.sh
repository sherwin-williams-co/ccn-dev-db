#!/bin/sh
#################################################################
# Script name   : SRA11000_Arch_SRA13510.sh
#
# Description   : This shell script will perform below tasks
#                 1. archieve the SRA13510 file in it's corresponding folder
#
# Created  : 02/26/2016 nxk927/dxv848 CCN Project Team.....
# Modified : 
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA11000_Arch_SRA13510"
DATA_FILES_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/SRA11000"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
FOLDER=`date +"%m%d%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"
#################################################################
#                                    Archieve files SRA13510*.TXT
#################################################################
if ls $DATA_FILES_PATH/SRA13510.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/SRA13510.TXT files exist "
    mv $DATA_FILES_PATH/SRA13510*.TXT $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/SRA13510.TXT files does not exist"
fi
#################################################################
#                                              ERROR STATUS CHECK
#################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0

