#!/bin/sh
#######################################################################################
# Description     : Script to FTP INSPAYMENT.TRG file to the STDSSAPHQ server 
#                   once the execution of GainLossJV script is completed. 
# Created by/Date : AXK326 01/15/2015 
# Modified on/Date: AXK326 04/28/2015 
#                   Added date parameter to pick date from the config file
#                 : AXK326 10/12/2015 changed name to INSPAYMENT.TRG 
#######################################################################################

. /app/stordrft/host.sh

TIME=`date +"%H:%M:%S"`
DATE=${GAINLOSS_MNTLY_RUNDATE} 
proc_name="ftp_draft_trg"

echo "Processing Started for $proc_name at ${TIME} on ${DATE}"

echo "" > INSPAYMENT.TRG

echo " Starting FTP Process to STDSSAPHQ "
ftp -n ${STDSSRVR_host} <<END_SCRIPT
quote USER ${USER}
quote PASS ${PASSWD}
cd /Data/Triggers

put INSPAYMENT.TRG

quit
END_SCRIPT

echo " FTP Process Successful "

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

     echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
