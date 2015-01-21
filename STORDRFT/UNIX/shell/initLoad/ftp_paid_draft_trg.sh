#!/bin/sh
#######################################################################################
# Description     : Script to FTP PAID_DRAFT.TRG file to the STDSSAPHQ server 
#                   once the execution of JV_monthly_load.sh scripts is completed. 
# Created by/Date : SXT410 01/20/2015
# Modified on/Date: 
#######################################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from.
. /app/stordrft/host.sh

TimeStamp=`date '+%Y%m%d%H%M%S'`
File="FTP_PAID_DRAFT.TRG"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

echo -n "" > PAID_DRAFT.TRG

echo "Processing Started for $File at ${TIME} on ${DATE}"

ftp -n ${STDSSRVR_host} <<END_SCRIPT
quote USER ${USER}
quote PASS ${PASSWD}
cd /Data/Triggers

put PAID_DRAFT.TRG

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
     echo "processing FAILED for $File at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $File at ${TIME} on ${DATE}"  

exit 0