#!/bin/sh
#################################################################
# Script name   : SRA11000_Archinput_file.sh
# Description   : This shell script will perform below tasks
#                 concatenate the input files and move only input files to  corresponding folder
#
# Created  : 03/03/2016 dxv848/nxk927 CCN Project Team.....
# Modified : 
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA11000_Archinput_file"
DATA_FILES_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/SRA11000"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
FOLDER=`date +"%m%d%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"
#################################################################
#                                        Archive files to folder
#################################################################
if ls $DATA_FILES_PATH/SRA10510_*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/SRA10510_*.TXT files exist"
    mv $DATA_FILES_PATH/SRA10510_*.TXT $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/SRA10510_*.TXT files does not exist"
fi

if ls $DATA_FILES_PATH/SRA13510_*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/SRA13510_*.TXT files exist "
    mv $DATA_FILES_PATH/SRA13510_*.TXT $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/SRA13510_*.TXT files does not exist"
fi

if ls $DATA_FILES_PATH/SRA11060_*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/SRA11060_*.TXT files exist "
    mv $DATA_FILES_PATH/SRA11060_*.TXT $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/SRA11060_*.TXT files does not exist"
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

