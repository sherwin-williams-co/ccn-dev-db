#!/bin/sh
#################################################################
# Script name   : SRA30000_Arch_Output_file.sh
#
# Description   : This shell script will archive the data files
#
# Created  : 10/31/2016 vxv336 CCN Project Team
# Modified :
#
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config 

proc_name="SRA30000_Arch_Output_file"
DATA_FILES_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/SRA30000"
DATE=`date +"%m/%d/%Y"`
YYMMDD=`date +"%y%m%d"`
TIME=`date +"%H:%M:%S"`
FOLDER=`date +"%m%d%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

#################################################################
#          Create archive directory
#################################################################
if [ -d "$ARCHIVE_PATH/$FOLDER" ]; then
   echo "Directory $ARCHIVE_PATH/$FOLDER exists"
else
  echo "Directory $ARCHIVE_PATH/$FOLDER does not exists, creating one. . ."
  mkdir $ARCHIVE_PATH/$FOLDER
fi

#################################################################
#         Archive files
#################################################################
if ls $DATA_FILES_PATH/SRA30000_D$YYMMDD* &> /dev/null; then
    echo "$DATA_FILES_PATH/SRA30000_* files exist "
    mv $DATA_FILES_PATH/SRA30000_D$YYMMDD* $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/SRA30000_D$YYMMDD* files does not exist"
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0

