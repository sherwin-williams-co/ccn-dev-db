#!/bin/bash
###########################################################################
# Script name   : banking_archive_dailyfiles.sh
# Description   : This shell script will archive the mainframe files for 
#                 Gift Card and Ticket/Bag.
# Created  : 06/22/2017 gxg192 CCN Project Team....
# Modified : 
###########################################################################
. /app/banking/dev/banking.config

proc_name="banking_archive_dailyfiles"

INITLOADPATH="$HOME/initLoad"
TCKT_ARCHIVE_PATH="$INITLOADPATH/archieve/DEP_TKT_BAG"
GC_ARCHIVE_PATH="$HOME/SRA30000"
FOLDER=`date +"%m%d%Y"`
YYMMDD=`date +"%y%m%d"`
filename_dept_tick="STE03062_DEPST.TXT"
filename_interim_dep="STE03064_DEPST.TXT"

DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

echo "Processing Started for $proc_name at $TIME on $DATE"

#################################################################
#          Create archive directory for Ticket/Bag
#################################################################
if [ -d "$TCKT_ARCHIVE_PATH/$FOLDER" ]; then
   echo "Directory $TCKT_ARCHIVE_PATH/$FOLDER exists"
else
  echo "Directory $TCKT_ARCHIVE_PATH/$FOLDER does not exists, creating one. . ."
  mkdir $TCKT_ARCHIVE_PATH/$FOLDER
fi

#################################################################
#         ARCHIVE mainframe output files for Ticket/Bag
#################################################################
if ls $INITLOADPATH/$filename_dept_tick &> /dev/null; then
    echo "$INITLOADPATH/$filename_dept_tick files exist "
    mv $INITLOADPATH/$filename_dept_tick $TCKT_ARCHIVE_PATH/$FOLDER/$filename_dept_tick
else
    echo "$INITLOADPATH/$filename_dept_tick files does not exist"
    exit 1;
fi

if ls $INITLOADPATH/$filename_interim_dep &> /dev/null; then
    echo "$INITLOADPATH/$filename_interim_dep files exist "
    mv $INITLOADPATH/$filename_interim_dep $TCKT_ARCHIVE_PATH/$FOLDER/$filename_interim_dep
else
    echo "$INITLOADPATH/$filename_interim_dep files does not exist"
    exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Archiving finished for Ticket/Bag at ${TIME} on ${DATE}"

#################################################################
#          Create archive directory for Gift Card
#################################################################
if [ -d "$GC_ARCHIVE_PATH/$FOLDER" ]; then
   echo "Directory $GC_ARCHIVE_PATH/$FOLDER exists"
else
  echo "Directory $GC_ARCHIVE_PATH/$FOLDER does not exists, creating one. . ."
  mkdir $GC_ARCHIVE_PATH/$FOLDER
fi

#################################################################
#         Archive Gift Card files
#################################################################
if ls $INITLOADPATH/SRA30000_D$YYMMDD* &> /dev/null; then
    echo "$INITLOADPATH/SRA30000_D$YYMMDD* files exist "
    mv $INITLOADPATH/SRA30000_D$YYMMDD* $GC_ARCHIVE_PATH/$FOLDER
else
    echo "$INITLOADPATH/SRA30000_D$YYMMDD* files does not exist"
    exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Archiving finished for Gift Card at ${TIME} on ${DATE}"


TIME=`date +"%H:%M:%S"`
echo "Processing Finished for $proc_name at $TIME on $DATE"
exit 0;
