#!/bin/bash
###########################################################################
# Script name   : copy_mainframe_files_from_qa.sh
# Description   : This shell script will get the mainframe files from QA
#                 on this environment to creare the diff report.
#
# Created  : 06/20/2017 gxg192 CCN Project Team....
# Modified : 
###########################################################################
. /app/banking/dev/banking.config

proc_name="copy_mainframe_files_from_qa"
FTPLOG=$HOME/logs/ftp_MF_files_from_qa.log
INITLOADPATH="$HOME/initLoad"
FOLDER=`date +"%m%d%Y"`

qa_host="stap3ccnqwv"
qa_user="banking"
qa_password="tram5555"
qa_path="/app/banking/qa/initLoad/archieve/DEP_TKT_BAG/$FOLDER"

filename_dept_tick="STE03062_DEPST_D170620_T003202.TXT"
filename_interim_dep="STE03064_DEPST_D170620_T003202.TXT"
FF_DPST_TCKT_POS_CNTS="FF_DPST_TCKT_POS_CNTS_STE03062.TXT"
FF_INTERIM_DEPST="FF_INTERIM_DEPST_STE03064.TXT"

DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

echo "Processing Started for $proc_name at $TIME on $DATE"

###################################################################################
#   Copy the STE03062_DEPST_D170620_* and STE03064_DEPST_D170620_ files
#   from QA as FF_DPST_TCKT_POS_CNTS_STE03062.TXT and FF_INTERIM_DEPST_STE03064.TXT 
#   respectively. so the files will be FTP'ed from QA and renamed to required name.
#   These files are source to the external tables and used to create
#   diff report.
###################################################################################
ftp -inv ${qa_host} <<FTP_MF > $FTPLOG
quote user ${qa_user}
quote pass ${qa_password}
cd ${qa_path}
get $filename_dept_tick $INITLOADPATH/$FF_DPST_TCKT_POS_CNTS
get $filename_interim_dep $INITLOADPATH/$FF_INTERIM_DEPST
bye
END_SCRIPT
echo "bye the transfer is complete"
FTP_MF

############################################################################
#                           ERROR STATUS CHECK
############################################################################
if [ ! -e $INITLOADPATH/$FF_DPST_TCKT_POS_CNTS ]
then
   echo "The transfer of $FF_DPST_TCKT_POS_CNTS from qa to this server FAILED at ${TIME} on ${DATE}"
   exit 1;
fi

if [ ! -e $INITLOADPATH/$FF_INTERIM_DEPST ]
then
   echo "The transfer of $FF_INTERIM_DEPST from qa to this server FAILED at ${TIME} on ${DATE}"
   exit 1;
fi
echo "Mainframe files transferred from QA as $FF_INTERIM_DEPST & $FF_DPST_TCKT_POS_CNTS at ${TIME} on ${DATE}"

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"
exit 0
