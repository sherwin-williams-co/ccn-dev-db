#!/bin/sh
#######################################################################################
# Description     : Script to FTP INSPAYMENT.TRG file to the STDSSAPHQ server 
#                   once the execution of GainLossJV script is completed. 
# Created by/Date : AXK326 01/15/2015 
# Modified on/Date: AXK326 04/28/2015 
#                   Added date parameter to pick date from the config file
#                 : AXK326 10/12/2015 changed name to INSPAYMENT.TRG
#                 : AXK326 02/03/2015 Originally modified Trigger file name from DRAFT.TRG to INSPAYMENT.TRG in Production Environment
#                 : AXK326 10/12/2015 changed name to INSPAYMENT.TRG as a new request
#                 : 03/18/2016 nxk927 CCN Project Team.....
#                   Changed the order of declaring variables after capturing the STATUS to avoid the scenario where
#                   the ERROR CODE that needs to be captured, will not be overwritten in the ERROR STATUS CHECK block
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
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

exit 0
############################################################################
