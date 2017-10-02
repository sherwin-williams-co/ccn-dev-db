#!/bin/sh
#################################################################
# Script name   : descartes_arch_hrchy_file.sh
#
# Description   : This shell script will perform below tasks
#                 1. archieve the file the generated DESCARTES output HRCHY file 
#
# Created  : 09/29/2017 rxa457 CCN Project Team.....
#################################################################
# below command will get the path for config respective to the environment from which it is run from
. /app/ccn/host.sh

proc_name="descartes_arch_hrchy_file"
DATA_FILES_PATH=$HOME/datafiles
ARCHIVE_PATH="$DATA_FILES_PATH/DESCARTES"
FOLDER=`date +"%m%d%Y"`
DATE=`date +"%m/%d/%Y"`
DT=`date +"%m%d%Y"`
TIME=`date +"%H:%M:%S"`
echo "Processing Started for $proc_name at $TIME on $DATE"
#################################################################
#          Control will output if directory with that date exists
#################################################################
if [ -d "$ARCHIVE_PATH" ]; then
   echo "Directory $ARCHIVE_PATH exists"
else
  echo "Directory $ARCHIVE_PATH does not exists, creating one. . ."
  mkdir $ARCHIVE_PATH
fi

if [ -d "$ARCHIVE_PATH/$FOLDER" ]; then
   echo "Directory $ARCHIVE_PATH/$FOLDER exists"
else
  echo "Directory $ARCHIVE_PATH/$FOLDER does not exists, creating one. . ."
  mkdir $ARCHIVE_PATH/$FOLDER
fi

#################################################################
#         Archieve files DESCARTES_HRCHY_FEED_$DT*
#################################################################
if ls $DATA_FILES_PATH/DESCARTES_HRCHY_FEED_$DT* &> /dev/null; then
    echo "$DATA_FILES_PATH/DESCARTES_HRCHY_FEED_$DT* files exist "
    mv -f $DATA_FILES_PATH/DESCARTES_HRCHY_FEED_$DT* $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/DESCARTES_HRCHY_FEED_$DT* files does not exist"
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0

