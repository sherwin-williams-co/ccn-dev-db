#!/bin/sh
#################################################################
# Script name   : SRA11000_dailyRun.sh
#
# Description   : This shell script will perform below tasks
#                 1. rename the files accordingly to be used for the process
#                 2. invoke the procedure that performs the core process
#                 3. archieve the files in it's corresponding folder
#
# Created  : 08/04/2015 jxc517 CCN Project Team.....
# Modified : 10/16/2015 jxc517 CCN Project Team.....
#            added the FTP call before archiving
#          : 01/06/2016 nxk927 CCN Project Team.....
#            changed mv to cat command. If we recieve multiple files then 
#            mv command will fail. cat will concatenate the files to one file and 
#            the process won't fail. 
#            Also archiving all the original files in the same folder as well.
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="SRA11000_dailyRun"
DATA_FILES_PATH="$HOME/initLoad"
ARCHIVE_PATH="$HOME/SRA11000"
LOGDIR=$HOME/logs
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
FOLDER=`date +"%m%d%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"
#################################################################
#     Rename files SRA10510_*.TXT, SRA13510_*.TXT, SRA11060_*.TXT
#################################################################
if ls $DATA_FILES_PATH/SRA10510_*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/SRA10510_*.TXT files exist"
    cat $DATA_FILES_PATH/SRA10510_*.TXT >> $DATA_FILES_PATH/SRA10510.TXT
else
    echo "$DATA_FILES_PATH/SRA10510_*.TXT files does not exist"
fi

if ls $DATA_FILES_PATH/SRA13510_*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/SRA13510_*.TXT files exist "
    cat $DATA_FILES_PATH/SRA13510_*.TXT >> $DATA_FILES_PATH/SRA13510.TXT
else
    echo "$DATA_FILES_PATH/SRA13510_*.TXT files does not exist"
fi

if ls $DATA_FILES_PATH/SRA11060_*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/SRA11060_*.TXT files exist "
    cat $DATA_FILES_PATH/SRA11060_*.TXT >> $DATA_FILES_PATH/SRA11060.TXT
else
    echo "$DATA_FILES_PATH/SRA11060_*.TXT files does not exist"
fi
#################################################################
#                  STR_BNK_DPST_DLY_RCNCL_PROCESS.EXECUTE_PROCESS
#################################################################
echo "Processing started for STR_BNK_DPST_DLY_RCNCL_PROCESS.EXECUTE_PROCESS at ${TIME} on ${DATE}"
sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw >> $LOGDIR/$proc_name"_"$TimeStamp.log <<END
set heading off;
set verify off;
set serveroutput on;
EXECUTE STR_BNK_DPST_DLY_RCNCL_PROCESS.EXECUTE_PROCESS(TRUNC(SYSDATE));
exit
END
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for STR_BNK_DPST_DLY_RCNCL_PROCESS.EXECUTE_PROCESS at ${TIME} on ${DATE}"
     exit 1;
fi
echo "Processing finished for STR_BNK_DPST_DLY_RCNCL_PROCESS.EXECUTE_PROCESS at ${TIME} on ${DATE}"
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
#         Archieve files SRA10510*.TXT, SRA13510*.TXT, SRA11060*.TXT
#################################################################
if ls $DATA_FILES_PATH/SRA10510.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/SRA10510.TXT files exist"
    mv $DATA_FILES_PATH/SRA10510*.TXT $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/SRA10510.TXT files does not exist"
fi

if ls $DATA_FILES_PATH/SRA13510.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/SRA13510.TXT files exist "
    mv $DATA_FILES_PATH/SRA13510*.TXT $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/SRA13510.TXT files does not exist"
fi

if ls $DATA_FILES_PATH/SRA11060.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/SRA11060.TXT files exist "
    mv $DATA_FILES_PATH/SRA11060*.TXT $ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/SRA11060.TXT files does not exist"
fi

#################################################################
#         FTP files SMIS1.SRA12060_*, SMIS1.SRA10060_*
#################################################################
./SRA11000_dailyRun_ftp.sh
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for SRA11000_dailyRun_ftp at ${TIME} on ${DATE}"
     exit 1;
fi
echo "Processing finished for SRA11000_dailyRun_ftp at ${TIME} on ${DATE}"

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
