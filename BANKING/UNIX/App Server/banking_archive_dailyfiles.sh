#!/bin/bash
###########################################################################
# Script name   : banking_archive_dailyfiles.sh
# Description   : This shell script will archive the mainframe files for 
#                 Gift Card and Ticket/Bag.
# Created  : 06/22/2017 gxg192 CCN Project Team....
# Modified : 06/26/2017 gxg192 Changes to archive all files on single folder.
# Modifled : 09/21/2017 rxa457 CCN Project Team...
#              Gift card file SRA30000_D$YYMMDD* is no longer downloaded into 
#                lower envs and the archive of this file is done by a spearate archive process in QA
###########################################################################
. /app/banking/dev/banking.config

proc_name="banking_archive_dailyfiles"

INITLOADPATH="$HOME/initLoad"
ARCHIVE_PATH="$INITLOADPATH/archieve/banking_mf_files"
FOLDER=`date +"%m%d%Y"`
YYMMDD=`date +"%y%m%d"`
filename_dept_tick="STE03062_DEPST.TXT"
filename_interim_dep="STE03064_DEPST.TXT"
filename_flatfile_gc="GIFT_CARD_POS_TRANS_FILE.TXT"
filename_sra11000="SRA10510.TXT"
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

echo "Processing Started for $proc_name at $TIME on $DATE"

#################################################################
#          Create archive directory for Banking MF files
#################################################################
if [ -d "$ARCHIVE_PATH/$FOLDER" ]; then
   echo "Directory $ARCHIVE_PATH/$FOLDER exists"
else
  echo "Directory $ARCHIVE_PATH/$FOLDER does not exists, creating one. . ."
  mkdir $ARCHIVE_PATH/$FOLDER
fi

#################################################################
#         ARCHIVE mainframe output files for Ticket/Bag
#################################################################
if ls $INITLOADPATH/$filename_dept_tick &> /dev/null; then
    echo "$INITLOADPATH/$filename_dept_tick files exist "
    mv $INITLOADPATH/$filename_dept_tick $ARCHIVE_PATH/$FOLDER/$filename_dept_tick
else
    echo "$INITLOADPATH/$filename_dept_tick files does not exist"
    exit 1
fi

if ls $INITLOADPATH/$filename_interim_dep &> /dev/null; then
    echo "$INITLOADPATH/$filename_interim_dep files exist "
    mv $INITLOADPATH/$filename_interim_dep $ARCHIVE_PATH/$FOLDER/$filename_interim_dep
else
    echo "$INITLOADPATH/$filename_interim_dep files does not exist"
    exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "Archiving finished for Ticket/Bag at ${TIME} on ${DATE}"

#################################################################
#         Archive Gift Card files
#################################################################
if ls $INITLOADPATH/$filename_flatfile_gc &> /dev/null; then
    echo "$INITLOADPATH/$filename_flatfile_gc files exist "
    mv $INITLOADPATH/$filename_flatfile_gc $ARCHIVE_PATH/$FOLDER
else
    echo "$INITLOADPATH/$filename_flatfile_gc files does not exist"
    exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "Archiving finished for Gift Card at ${TIME} on ${DATE}"


TIME=`date +"%H:%M:%S"`
echo "Processing Finished for $proc_name at $TIME on $DATE"

#################################################################
#         Archive SRA10510 File
#################################################################
if ls $INITLOADPATH/$filename_sra11000 &> /dev/null; then
    echo "$INITLOADPATH/$filename_sra11000 files exist "
    mv $INITLOADPATH/$filename_sra11000 $ARCHIVE_PATH/$FOLDER
else
    echo "$INITLOADPATH/$filename_sra11000 files does not exist"
    exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "Archiving finished for SRA10510 at ${TIME} on ${DATE}"


TIME=`date +"%H:%M:%S"`
echo "Processing Finished for $proc_name at $TIME on $DATE"

exit 0
