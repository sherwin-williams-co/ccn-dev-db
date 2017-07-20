#!/bin/sh
#################################################################
# Script name   : SRA11000_Archinput_file.sh
# Description   : This shell script will perform below tasks
#                 concatenate the input files and move only input files to  corresponding folder
#
# Created  : 03/03/2016 dxv848/nxk927 CCN Project Team.....
# Modified : 04/27/2016 nxk927 CCN Project Team.....
#            removed the error status check
#          : 08/23/2016 nxk927 CCN Project Team.....
#            changed the files that we consider for this process
#          : 04/20/2017 nxk927 CCN Project Team.....
#            source file changed. Using the source file provided by marcy Lee.
#          : 07/20/2017 nxk927 CCN Project Team.....
#            source file changed. archiving the new file provided by treasury
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA11000_Archinput_file"
DATA_FILES_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/SRA11000"
MSCTRAN_PATH="$HOME/datafiles/ccn_users"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
FOLDER=`date +"%m%d%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"
#################################################################
#                                        Archive files to folder
#################################################################

if ls $DATA_FILES_PATH/stores_ach_*.txt &> /dev/null; then
    echo "$DATA_FILES_PATH/stores_ach.txt files exist "
    mv $DATA_FILES_PATH/stores_ach_*.txt $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/stores_ach.txt files does not exist"
fi

if ls $MSCTRAN_PATH/misctran*.txt &> /dev/null; then
    echo "$DATA_FILES_PATH/UAR.MISCTRAN_*.TXT files exist "
    mv $MSCTRAN_PATH/misctran*.txt $ARCHIVE_PATH/$FOLDER
else
    echo "$MSCTRAN_PATH/misctran*.txt files does not exist"
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0

