#!/bin/sh
#################################################################
# Script name   : SRA11000_Rename_file.sh
# Description   : This shell script will Rename the files.
#
# Created  : 03/03/2016 dxv848/nxk927 CCN Project Team.....
# Modified : 
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA11000_Rename_file"
DATA_FILES_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/SRA11000"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
FOLDER=`date +"%m%d%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"
#################################################################
#                                               Rename the files 
#################################################################
if ls $DATA_FILES_PATH/SRA10510_*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/SRA10510_*.TXT files exist to rename"
    cat $DATA_FILES_PATH/SRA10510_*.TXT >> $DATA_FILES_PATH/SRA10510.TXT
else
    echo "$DATA_FILES_PATH/SRA10510_*.TXT files does not exist to rename"
fi

if ls $DATA_FILES_PATH/SRA13510_*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/SRA13510_*.TXT files exist to rename"
    cat $DATA_FILES_PATH/SRA13510_*.TXT >> $DATA_FILES_PATH/SRA13510.TXT
else
    echo "$DATA_FILES_PATH/SRA13510_*.TXT files does not exist to rename"
fi

if ls $DATA_FILES_PATH/SRA11060_*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/SRA11060_*.TXT files exist to rename"
    cat $DATA_FILES_PATH/SRA11060_*.TXT >> $DATA_FILES_PATH/SRA11060.TXT
else
    echo "$DATA_FILES_PATH/SRA11060_*.TXT files does not exist to rename"
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

