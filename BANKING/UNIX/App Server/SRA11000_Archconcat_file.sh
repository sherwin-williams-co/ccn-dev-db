#!/bin/sh
#################################################################
# Script name   : SRA11000_Archconcat_file.sh
# Description   : This shell script will perform below tasks
#                  archive the concatenated files in it's corresponding folder
#
# Created  : 03/03/2016 nxk927/dxv848 CCN Project Team.....
# Modified : 04/27/2016 nxk927 CCN Project Team.....
#            removed the error status check
#          : 08/23/2016 nxk927 CCN Project Team.....
#            changed the files that we consider for this process
#           : 09/21/2017 rxa457 CCN Project Team...
#            Removed renaming and archive process for Mainframe input files
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA11000_Archconcat_file"
DATA_FILES_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/SRA11000"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
FOLDER=`date +"%m%d%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"
#################################################################
#                                       Archive files to folder
#################################################################
if ls $DATA_FILES_PATH/stores_ach.txt &> /dev/null; then
    echo "$DATA_FILES_PATH/stores_ach.txt files exist "
    mv $DATA_FILES_PATH/stores_ach.txt $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/stores_ach.txt files does not exist"
fi

if ls $DATA_FILES_PATH/UAR.MISCTRAN.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/UAR.MISCTRAN.TXT files exist"
    mv $DATA_FILES_PATH/UAR.MISCTRAN.TXT $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/UAR.MISCTRAN.TXT files does not exist"
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0

