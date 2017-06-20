#!/bin/bash
###########################################################################
# Script name   : dep_tick_reconcile_diff_rpt.sh
# Description   : This shell script will create deposit ticket reconcile 
#                 diff report and send the emails with attached diff files.
# Created  : 06/16/2017 gxg192 CCN Project Team....
# Modified : 
###########################################################################
. /app/banking/dev/banking.config

proc_name="dep_tick_reconcile_diff_rpt"
LOGDIR=$HOME/logs
INITLOADPATH="$HOME/initLoad"
ARCHIVE_PATH="$INITLOADPATH/archieve/DEP_TKT_BAG"
FOLDER=`date +"%m%d%Y"`
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
filename_dept_tick="STE03062_DEPST"
filename_interim_dep="STE03064_DEPST"
FF_DPST_TCKT_POS_CNTS="FF_DPST_TCKT_POS_CNTS_STE03062.TXT"
FF_INTERIM_DEPST="FF_INTERIM_DEPST_STE03064.TXT"

############################################################################
#   UNIX Function to send the email and track the status of email
############################################################################
SENDEMAIL()
{
CATEGORY="$1"
ERROR_MSG="$2"
echo $ERROR_MSG
TIME=`date +"%H:%M:%S"`
./send_mail.sh $CATEGORY "$ERROR_MSG"
status=$?
if [ $status -ne 0 ];
then
   TIME=`date +"%H:%M:%S"`
   echo "send_mail.sh process FAILED for $CATEGORY at ${TIME} on ${DATE}"
fi
}

############################################################################
# Copy the mainframe files from qa on banking app server to load the data 
# so that data is available in external tables used for creating the diff report.
############################################################################
./copy_mainframe_files_from_qa.sh

./EXEC_PROC_1PARAM.sh "BANKING_RECONCILE_DIFF_REP_PKG.GENERATE_TCKT_BAG_DELTA_FILES" "$1"

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     ERR_MSG="Processing failed for Generating Reconcile Diff Report at $TIME on $DATE"
     SENDEMAIL POS_BANK_DEP_TICK_ERROR "$ERR_MSG"
     exit 1;
fi

###########################################################################
#                     Sending Email with Attachment
###########################################################################
SENDEMAIL POS_BANK_DEP_TICK_CNT
SENDEMAIL POS_INTERIM_DEPST

#################################################################
#          Create archive directory
#################################################################
if [ -d "$ARCHIVE_PATH/$FOLDER" ]; then
   echo "Directory $ARCHIVE_PATH/$FOLDER exists"
else
  echo "Directory $ARCHIVE_PATH/$FOLDER does not exists, creating one. . ."
  mkdir $ARCHIVE_PATH/$FOLDER
fi

#################################################################
#         ARCHIVE mainframe output file
#################################################################
mv $INITLOADPATH/$FF_DPST_TCKT_POS_CNTS $ARCHIVE_PATH/$FOLDER/$FF_DPST_TCKT_POS_CNTS
mv $INITLOADPATH/$FF_INTERIM_DEPST $ARCHIVE_PATH/$FOLDER/$FF_INTERIM_DEPST

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"
exit 0
############################################################################
