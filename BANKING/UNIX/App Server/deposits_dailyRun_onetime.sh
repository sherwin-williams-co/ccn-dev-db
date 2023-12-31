#!/bin/sh
#################################################################
# Script name   : deposits_dailyRun_onetime.sh
#
# Description   : This shell script will perform below tasks
#                 1. archieve the files in to data files for future references
#                 2. rename the files as per the external tables
#                 3. load the deposit ticket details on a daily basis from mainfrmae files
#
# Created  : 08/29/2016 nxk927 CCN Project Team.....
#
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="deposits_dailyRun_onetime"
DATA_FILES_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/datafiles/deposits_daily_load"
LOGDIR=$HOME/logs
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
FOLDER=`date +"%m%d%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"
#################################################################
#          Control will output if directory with that date exists
#################################################################
if [ -d "$ARCHIVE_PATH/$FOLDER" ]; then
   echo "Directory $ARCHIVE_PATH/$FOLDER exists"
else
  echo "Directory $ARCHIVE_PATH/$FOLDER does not exists, creating one. . ."
  mkdir $ARCHIVE_PATH/$FOLDER
fi
#################################################################
#     Archieve files CCN08100_TCKORD_*.TXT, CCN08100_DEPTKT_*.TXT
#     Rename files CCN08100_TCKORD_*.TXT, CCN08100_DEPTKT_*.TXT
#################################################################
if ls $DATA_FILES_PATH/CCN08100_TCKORD*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/CCN08100_TCKORD_* files exist "
    cp $DATA_FILES_PATH/CCN08100_TCKORD*.TXT $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/CCN08100_TCKORD_*.TXT files does not exist"
fi

if ls $DATA_FILES_PATH/CCN08100_DEPTKT*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/CCN08100_DEPTKT_*.TXT files exist "
    cp $DATA_FILES_PATH/CCN08100_DEPTKT*.TXT $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/CCN08100_DEPTKT* files does not exist"
fi
#################################################################
#                  DEPOSITS_DAILY_LOAD.DEPOSITS_DAILY_LOAD_SP
#################################################################
echo "Processing started for DEPOSITS_DAILY_LOAD.DEPOSITS_DAILY_LOAD_SP at ${TIME} on ${DATE}"
sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
EXECUTE DEPOSITS_DAILY_LOAD.DEPOSITS_DAILY_LOAD_SP();
exit
END
status=$?
#################################################################
#                                              ERROR STATUS CHECK
#################################################################
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for DEPOSITS_DAILY_LOAD.DEPOSITS_DAILY_LOAD_SP at ${TIME} on ${DATE}"
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"
exit 0
