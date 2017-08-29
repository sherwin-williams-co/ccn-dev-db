#!/bin/bash
###################################################################################
# Script name   : copy_mainframe_files.sh
# Description   : This shell script will 
#                    1. get the mainframe files from QA on this environment for ticket/bag 
#                    2. copy the mainframe file for gift card with required filename
#
# Created  : 06/20/2017 gxg192 CCN Project Team....
# Modified : 06/26/2017 Changes to copy all mainframe files from QA.
#          : 08/29/2017 Added code to copy SRA11000 file from QA.
###################################################################################
. /app/banking/dev/banking.config

proc_name="copy_mainframe_files"
INITLOADPATH="$HOME/initLoad"
FOLDER=`date +"%m%d%Y"`
YYMMDD=`date +"%y%m%d"`

qa_host="stap3ccnqwv"
qa_user="banking"
qa_password="tram5555"
qa_tktbag_path="/app/banking/qa/initLoad/archieve/DEP_TKT_BAG/$FOLDER"
qa_sra11000_path="/app/banking/qa/SRA11000/$FOLDER"
qa_initload_path="/app/banking/qa/initLoad"

filename_mainframe_gc="SRA30000_D$YYMMDD*"
filename_flatfile_gc="GIFT_CARD_POS_TRANS_FILE.TXT"

filename_dept_tick="STE03062_DEPST.TXT"
filename_interim_dep="STE03064_DEPST.TXT"
filename_sra11000="SRA10510.TXT"

DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

echo "Processing Started for $proc_name at $TIME on $DATE"

###################################################################################
#   Copy the STE03062_DEPST and STE03064_DEPST files
#   from QA to this sever.
#   These files are source to the external tables and used to create
#   diff report for banking deposit ticket/bag process.
###################################################################################
ftp -inv ${qa_host} <<FTP_MF
quote user ${qa_user}
quote pass ${qa_password}
cd ${qa_tktbag_path}
get $filename_dept_tick $INITLOADPATH/$filename_dept_tick
get $filename_interim_dep $INITLOADPATH/$filename_interim_dep
cd ${qa_initload_path}
lcd ${INITLOADPATH}
mget $filename_mainframe_gc
cd ${qa_sra11000_path}
get $filename_sra11000 $INITLOADPATH/$filename_sra11000
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
   exit 1
fi

if [ ! -e $INITLOADPATH/$filename_interim_dep ]
then
   echo "The transfer of $filename_interim_dep from qa to this server FAILED at ${TIME} on ${DATE}"
   exit 1
fi

if [ ! -e $INITLOADPATH/$filename_mainframe_gc ]
then
   echo "The transfer of $filename_flatfile_gc from qa to this server FAILED at ${TIME} on ${DATE}"
   exit 1
else
   cp $INITLOADPATH/$filename_mainframe_gc $INITLOADPATH/$filename_flatfile_gc
fi

if [ ! -e $INITLOADPATH/$filename_sra11000 ]
then
   echo "The transfer of $filename_sra11000 from qa to this server FAILED at ${TIME} on ${DATE}"
   exit 1
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"
exit 0

