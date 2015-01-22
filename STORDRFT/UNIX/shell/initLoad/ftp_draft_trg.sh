#!/bin/sh
#######################################################################################
# Description     : Script to FTP DRAFT.TRG file to the STDSSAPHQ server 
#                   once the execution of GainLossJV script is completed. 
# Created by/Date : AXK326 01/15/2015
# Modified on/Date: 
#######################################################################################

. /app/stordrft/host.sh

proc_name="ftp_draft_trg"

echo "" > DRAFT.TRG

echo " Starting FTP Process to STDSSAPHQ "
ftp -n ${STDSSRVR_host} <<END_SCRIPT
quote USER ${USER}
quote PASS ${PASSWD}
cd /Data/Triggers

put DRAFT.TRG

quit
END_SCRIPT

echo " FTP Process Successful "

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

     echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
