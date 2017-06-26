#!/bin/sh
#################################################################
# Script name   : SRA30000_Arch_Output_file.sh
#
# Description   : This shell script will archive the data files
#                 For the time being, this file is generated by Mainframe and CCN is just FTPing it.
#
# Created  : 10/31/2016 vxv336 CCN Project Team
# Modified : 06/23/2017 gxg192 Changes to archive correct file.
#
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config 

proc_name="SRA30000_Arch_Output_file"
DATA_FILES_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/SRA30000"
FOLDER=`date +"%m%d%Y"`
gc_filename="SMIS1.UAR.POSGFTCD_"
DDMONYYYY=`date '+%d%^b%Y'`

DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

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
if ls $DATA_FILES_PATH/$gc_filename$DDMONYYYY* &> /dev/null; then
    echo "$DATA_FILES_PATH/$gc_filename$DDMONYYYY* files exist "
    mv $DATA_FILES_PATH/$gc_filename$DDMONYYYY* $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/$gc_filename$DDMONYYYY* files does not exist"
    exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0
