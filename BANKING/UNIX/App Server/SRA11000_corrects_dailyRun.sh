#!/bin/sh
#################################################################
# Script name   : SRA11000_corrects_dailyRun.sh
#
# Description   : This shell script will perform below tasks
#                 1. rename the files accordingly to be used for the process
#                 2. invoke the procedure that performs the core process
#                 3. archieve the files in it's corresponding folder
#
# Created  : 11/07/2016 jxc517 CCN Project Team.....
# Modified : 11/09/2016 jxc517 CCN Project Team.....
             Moved the FTP portion separately by itself
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA11000_corrects_dailyRun"
DATA_FILES_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/SRA11000"
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
#                                          Rename the input files
#################################################################
echo "Renaming input files started at ${TIME} on ${DATE}"
if ls $DATA_FILES_PATH/UAR.OVERSHRT_*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/UAR.OVERSHRT_*.TXT files exist to rename"
    cat $DATA_FILES_PATH/UAR.OVERSHRT_*.TXT >> $DATA_FILES_PATH/UAR.OVERSHRT.TXT
else
    echo "$DATA_FILES_PATH/UAR.OVERSHRT_*.TXT files does not exist to rename"
fi
echo "Renaming input files finished at ${TIME} on ${DATE}"

#################################################################
#                          archive input files to archive folder
#################################################################
echo "Archiving input files started at ${TIME} on ${DATE}"
if ls $DATA_FILES_PATH/UAR.OVERSHRT_*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/UAR.OVERSHRT_*.TXT files exist "
    mv $DATA_FILES_PATH/UAR.OVERSHRT_*.TXT $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/UAR.OVERSHRT_*.TXT files does not exist"
fi
echo "Archiving input files finished at ${TIME} on ${DATE}"

##########################################################################
#                  STR_BNK_DPST_DLY_RCNCL_PROCESS.EXECUTE_CORRECTS_PROCESS
##########################################################################
echo "Processing started for STR_BNK_DPST_DLY_RCNCL_PROCESS.EXECUTE_CORRECTS_PROCESS at ${TIME} on ${DATE}"
sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set serveroutput on;
set verify off;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
:exitCode := 0;
STR_BNK_DPST_DLY_RCNCL_PROCESS.EXECUTE_CORRECTS_PROCESS(TRUNC(SYSDATE));
Exception
 when others then
 :exitCode := 2;
 END;
 /
exit :exitCode
END

status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for STR_BNK_DPST_DLY_RCNCL_PROCESS.EXECUTE_CORRECTS_PROCESS at ${TIME} on ${DATE}"
    exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for STR_BNK_DPST_DLY_RCNCL_PROCESS.EXECUTE_CORRECTS_PROCESS at ${TIME} on ${DATE}"

#################################################################
#                 Archive the concatenate files to archive folder
#################################################################
echo "Archiving input concatenated files started at ${TIME} on ${DATE}"
if ls $DATA_FILES_PATH/UAR.OVERSHRT.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/UAR.OVERSHRT.TXT files exist"
    mv $DATA_FILES_PATH/UAR.OVERSHRT.TXT $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/UAR.OVERSHRT.TXT files does not exist"
fi
echo "Archiving input concatenated files finished at ${TIME} on ${DATE}"

#################################################################
#         FTP files stores_cashflowadj_*
#################################################################
./SRA11000_corrects_FTP.sh

#################################################################
#         ARCHIVE files stores_cashflowadj_*
#################################################################
echo "Archiving output files started at ${TIME} on ${DATE}"
if ls $DATA_FILES_PATH/stores_cashflowadj_* &> /dev/null; then
    echo "$DATA_FILES_PATH/stores_cashflowadj_* files exist "
    mv $DATA_FILES_PATH/stores_cashflowadj_* $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/stores_cashflowadj_* files does not exist"
fi
echo "Archiving output files finished at ${TIME} on ${DATE}"

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  
exit 0
