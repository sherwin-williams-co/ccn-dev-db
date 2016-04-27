#!/bin/sh
#################################################################
# Script name   : SRA11000_Arch_Output_file.sh
#
# Description   : This shell script will perform below tasks
#                 1. archieve the files SMIS1.SRA12060_*, SMIS1.SRA10060_* in it's corresponding folder
#
# Created  : 02/26/2016 nxk927/dxv848 CCN Project Team.....
# Modified : 04/27/2016 nxk927 CCN Project Team.....
#            removed the error check
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA11000_Arch_Output_file"
DATA_FILES_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/SRA11000"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
FOLDER=`date +"%m%d%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"
#################################################################
#         Archieve files SMIS1.SRA12060_*, SMIS1.SRA10060_*
#################################################################
if ls $DATA_FILES_PATH/SMIS1.SRA12060_* &> /dev/null; then
    echo "$DATA_FILES_PATH/SMIS1.SRA12060_* files exist "
    mv $DATA_FILES_PATH/SMIS1.SRA12060_* $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/SMIS1.SRA12060_* files does not exist"
fi

if ls $DATA_FILES_PATH/SMIS1.SRA10060_* &> /dev/null; then
    echo "$DATA_FILES_PATH/SMIS1.SRA10060_* files exist "
    mv $DATA_FILES_PATH/SMIS1.SRA10060_* $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/SMIS1.SRA10060_* files does not exist"
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0

