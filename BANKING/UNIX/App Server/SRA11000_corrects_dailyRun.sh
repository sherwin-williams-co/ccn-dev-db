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
#            Moved the FTP portion separately by itself
#          : 04/20/2017 nxk927 CCN Project Team.....
#            source file changed. Using the source file provided by marcy Lee.
# Modified : 06/15/2017 nxk927 CCN Project Team.....
#            ftping the cash flow/corrects file to another server on top of the old one
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA11000_corrects_dailyRun"
DATA_FILES_PATH="$HOME/initLoad"
OVRSHRT_PATH="$HOME/datafiles/ccn_users"
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
if ls $OVRSHRT_PATH/overshrt*.txt &> /dev/null; then
    echo "$OVRSHRT_PATH/OVERSHRT*.TXT files exist to rename"
    cat $OVRSHRT_PATH/overshrt*.txt >> $DATA_FILES_PATH/UAR.OVERSHRT.TXT
else
    echo "$OVRSHRT_PATH/OVERSHRT*.TXT files does not exist to rename"
fi
echo "Renaming input files finished at ${TIME} on ${DATE}"

#################################################################
#                          archive input files to archive folder
#################################################################
echo "Archiving input files started at ${TIME} on ${DATE}"
if ls $OVRSHRT_PATH/overshrt*.txt &> /dev/null; then
    echo "$DATA_FILES_PATH/UAR.OVERSHRT_*.TXT files exist "
    mv $OVRSHRT_PATH/overshrt*.txt $ARCHIVE_PATH/$FOLDER
else
    echo "$OVRSHRT_PATH/overshrt*.txt files does not exist"
fi
echo "Archiving input files finished at ${TIME} on ${DATE}"

##########################################################################
#                  STR_BNK_DPST_DLY_RCNCL_PROCESS.LOAD_OVERSHRT
##########################################################################
echo "Processing started for loading OVERSHRT table at ${TIME} on ${DATE}"
./SRA11000_dly_corrects_data_load.sh

status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for loading OVERSHRT table at ${TIME} on ${DATE}"
    exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for loading OVERSHRT table at ${TIME} on ${DATE}"

##########################################################################
#                  STR_BNK_DPST_DLY_RCNCL_PROCESS.LOAD_OVERSHRT
##########################################################################
echo "Processing started for generating bank correction/cashflow file at ${TIME} on ${DATE}"
./SRA11000_dly_gnrte_corrects_file.sh

status=$?
if test $status -ne 0
then
    TIME=`date +"%H:%M:%S"`
    echo "processing FAILED for generating bank correction/cashflow file at ${TIME} on ${DATE}"
    exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for generating bank correction/cashflow file at ${TIME} on ${DATE}"

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
