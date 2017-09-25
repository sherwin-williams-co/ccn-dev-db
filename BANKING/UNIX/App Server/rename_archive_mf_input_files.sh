#!/bin/bash
###################################################################################
# Script name   : rename_archive_input_files
# Description   : This shell script will rename and archive mainframe input files
#                 SRA10510*, STE03062_DEPST*, STE03064_DEPST_D* received from mainframe 
#                 in QA or higher environments.
#                  This has to be setup in QA or higher environments where files are received only
#                  *Scheduled to run in Cron 
# Created  : 09/21/2017 rxa457 CCN Project Team....
###################################################################################

# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="rename_archive_input_files"
DATA_FILES_PATH="$HOME/initLoad"
DEP_TKT_ARCHIVE_PATH="$HOME/initLoad/archieve/DEP_TKT_BAG"
SRA11000_ARCHIVE_PATH="$HOME/SRA11000"
GC_ARCHIVE_PATH="$HOME/initLoad/archieve/banking_mf_files"
FOLDER=`date +"%m%d%Y"`
YYMMDD=`date +"%y%m%d"`
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

echo "Processing Started for $proc_name at $TIME on $DATE"

#################################################################
#          Control will output if directory with that date exists
#################################################################
if [ -d "$DEP_TKT_ARCHIVE_PATH/$FOLDER" ]; then
   echo "Directory $DEP_TKT_ARCHIVE_PATH/$FOLDER exists"
else
  echo "Directory $DEP_TKT_ARCHIVE_PATH/$FOLDER does not exists, creating one. . ."
  mkdir $DEP_TKT_ARCHIVE_PATH/$FOLDER
fi

if [ -d "$SRA11000_ARCHIVE_PATH/$FOLDER" ]; then
   echo "Directory $SRA11000_ARCHIVE_PATH/$FOLDER exists"
else
  echo "Directory $SRA11000_ARCHIVE_PATH/$FOLDER does not exists, creating one. . ."
  mkdir $SRA11000_ARCHIVE_PATH/$FOLDER
fi

if [ -d "$GC_ARCHIVE_PATH/$FOLDER" ]; then
   echo "Directory $GC_ARCHIVE_PATH/$FOLDER exists"
else
  echo "Directory $GC_ARCHIVE_PATH/$FOLDER does not exists, creating one. . ."
  mkdir $GC_ARCHIVE_PATH/$FOLDER
fi

#################################################################
# Rename the input files
#################################################################

#################################################################
# Rename STE03062_DEPST_D*.TXT
#################################################################
echo "Processing Started for Renaming deposit files at $TIME on $DATE"
if [ -f $DATA_FILES_PATH/STE03062_DEPST_D*.TXT ] 
then
    echo "$DATA_FILES_PATH/STE03062_DEPST_D*.TXT files exist to rename"
    cat $DATA_FILES_PATH/STE03062_DEPST_D*.TXT >> $DATA_FILES_PATH/STE03062_DEPST.TXT
else
    echo "$DATA_FILES_PATH/STE03062_DEPST_D*.TXT files does not exist to rename"
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for Renaming deposit files at ${TIME} on ${DATE}"

#################################################################
# Rename STE03064_DEPST_D*.TXT
#################################################################
echo "Processing Started for Renaming Interim deposit files at $TIME on $DATE"
if [ -f $DATA_FILES_PATH/STE03064_DEPST_D*.TXT ] 
then
    echo "$DATA_FILES_PATH/STE03064_DEPST_D*.TXT files exist to rename"
    cat $DATA_FILES_PATH/STE03064_DEPST_D*.TXT >> $DATA_FILES_PATH/STE03064_DEPST.TXT
else
    echo "$DATA_FILES_PATH/STE03064_DEPST_D*.TXT files does not exist to rename"
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for Renaming Intermim deposit files at ${TIME} on ${DATE}"

#################################################################
# Rename SRA10510_*.TXT
#################################################################
echo "Processing Started for Renaming SRA10510 files at $TIME on $DATE"
if ls $DATA_FILES_PATH/SRA10510_*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/SRA10510_*.TXT files exist to rename"
    cat $DATA_FILES_PATH/SRA10510_*.TXT >> $DATA_FILES_PATH/SRA10510.TXT
else
    echo "$DATA_FILES_PATH/SRA10510_*.TXT files does not exist to rename"
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for Renaming SRA10510 files at ${TIME} on ${DATE}"

#################################################################
# Rename SRA30000_D*.TXT
#################################################################
echo "Processing Started for Renaming Gift Card file at $TIME on $DATE"
if ls $DATA_FILES_PATH/SRA30000_D$YYMMDD*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/SRA30000_D$YYMMDD*.TXT files exist to rename"
    cat $DATA_FILES_PATH/SRA30000_D$YYMMDD*.TXT >> $DATA_FILES_PATH/GIFT_CARD_POS_TRANS_FILE.TXT
else
    echo "$DATA_FILES_PATH/SRA30000_D$YYMMDD*.TXT files does not exist to rename"
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for Renaming SRA10510 files at ${TIME} on ${DATE}"

#################################################################
# Archive mainframe input files to folder
#################################################################

#################################################################
# Archive STE03062_DEPST_D*.TXT
#################################################################
echo "Processing Started for archiving Deposit Ticket Mainframe Input files at $TIME on $DATE"
if ls $DATA_FILES_PATH/STE03062_DEPST_D*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/STE03062_DEPST_D*.TXT files exist"
    mv $DATA_FILES_PATH/STE03062_DEPST_D*.TXT $DEP_TKT_ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/STE03062_DEPST_D*.TXT files does not exist"
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for archiving Interim Deposit Ticket Mainframe Input files at ${TIME} on ${DATE}"

#################################################################
# Archive STE03064_DEPST_D*.TXT
#################################################################
echo "Processing Started for archiving Intermim Deposit Ticket Mainframe Input files at $TIME on $DATE"
if ls $DATA_FILES_PATH/STE03064_DEPST_D*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/STE03064_DEPST_D*.TXT files exist"
    mv $DATA_FILES_PATH/STE03064_DEPST_D*.TXT $DEP_TKT_ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/STE03064_DEPST_D*.TXT files does not exist"
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for archiving Interim Deposit Ticket Mainframe Input files at ${TIME} on ${DATE}"

#################################################################
# Archive SRA10510_*.TXT
#################################################################
echo "Processing Started for archiving SRA10510 Mainframe Input files at $TIME on $DATE"
if ls $DATA_FILES_PATH/SRA10510_*.TXT &> /dev/null; then
    echo "$DATA_FILES_PATH/SRA10510_*.TXT files exist"
    mv $DATA_FILES_PATH/SRA10510_*.TXT $SRA11000_ARCHIVE_PATH/$FOLDER
else
    echo "$DATA_FILES_PATH/SRA10510_*.TXT files does not exist"
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for archiving SRA10510 Mainframe Input files at ${TIME} on ${DATE}"


TIME=`date +"%H:%M:%S"`
echo "Processing Finished for $proc_name at $TIME on $DATE"