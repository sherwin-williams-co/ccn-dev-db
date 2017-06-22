#!/bin/bash
###################################################################################
# Script name   : copy_mainframe_files.sh
# Description   : This shell script will 
#                    1. get the mainframe files from QA on this environment for ticket/bag 
#                    2. copy the mainframe file for gift card with required filename
#
# Created  : 06/20/2017 gxg192 CCN Project Team....
# Modified : Changes to combine gift card and ticket/bag process
###################################################################################
. /app/banking/dev/banking.config

proc_name="copy_mainframe_files"
FTPLOG=$HOME/logs/ftp_MF_files_from_qa.log
INITLOADPATH="$HOME/initLoad"
FOLDER=`date +"%m%d%Y"`
YYMMDD=`date +"%y%m%d"`

qa_host="stap3ccnqwv"
qa_user="banking"
qa_password="tram5555"
qa_path="/app/banking/qa/initLoad/archieve/DEP_TKT_BAG/$FOLDER"

filename_mainframe_gc="SRA30000_D$YYMMDD*"
filename_flatfile_gc="GIFT_CARD_POS_TRANS_FILE.TXT"

filename_dept_tick="STE03062_DEPST.TXT"
filename_interim_dep="STE03064_DEPST.TXT"

DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

echo "Processing Started for $proc_name at $TIME on $DATE"

###################################################################################
#   Copy the SRA30000 file as GIFT_CARD_POS_TRANS_file which is source for 
#   TEMP_GIFT_CARD_POS_TRANS table which loads data into FF_GIFT_CARD_POS_TRANS
#   table that is used for diff process.
###################################################################################
if ls $INITLOADPATH/$filename_mainframe_gc &> /dev/null;
then
   cp $INITLOADPATH/$filename_mainframe_gc $INITLOADPATH/$filename_flatfile_gc
   echo "Copied $filename_mainframe_gc as $filename_flatfile_gc on $INITLOADPATH successfully."
else
   echo "File $filename_mainframe_gc does not exists on $INITLOADPATH. Processing failed at ${TIME} on ${DATE}"
   exit 1;
fi

###################################################################################
#   Copy the STE03062_DEPST and STE03064_DEPST files
#   from QA to this sever.
#   These files are source to the external tables and used to create
#   diff report for banking deposit ticket/bag process.
###################################################################################
ftp -inv ${qa_host} <<FTP_MF > $FTPLOG
quote user ${qa_user}
quote pass ${qa_password}
cd ${qa_path}
get $filename_dept_tick $INITLOADPATH/$filename_dept_tick
get $filename_interim_dep $INITLOADPATH/$filename_interim_dep
bye
END_SCRIPT
echo "bye the transfer is complete"
FTP_MF

###################################################################################
#                           ERROR STATUS CHECK
###################################################################################
TIME=`date +"%H:%M:%S"`
if [ ! -e $INITLOADPATH/$filename_dept_tick ]
then
   echo "The transfer of $filename_dept_tick from qa to this server FAILED at ${TIME} on ${DATE}"
   exit 1;
fi

if [ ! -e $INITLOADPATH/$filename_interim_dep ]
then
   echo "The transfer of $filename_interim_dep from qa to this server FAILED at ${TIME} on ${DATE}"
   exit 1;
fi
echo "Mainframe files transferred from QA as $filename_interim_dep & $filename_dept_tick at ${TIME} on ${DATE}"

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"
exit 0;

