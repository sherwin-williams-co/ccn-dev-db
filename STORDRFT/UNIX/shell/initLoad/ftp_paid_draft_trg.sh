#!/bin/sh
#######################################################################################
# Description     : Script to FTP PAID_DRAFT.TRG file to the STDSSAPHQ server 
#                   once the execution of JV_monthly_load.sh scripts is completed. 
# Created by/Date : SXT410 01/20/2015
# Modified on/Date: sxt410 02/04/2015 Changed trigger file name from PAID_DRAFT.TRG to DRAFT.TRG
#######################################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from.
. /app/stordrft/host.sh

File="FTP_DRAFT.TRG"
TIME=`date +"%H:%M:%S"`
P1=${JV_MNTLY_RUNDATE}

echo -n "" > DRAFT.TRG

echo "Processing Started for $File at ${TIME} for the date ${P1}"

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
P1=${JV_MNTLY_RUNDATE}
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $File at ${TIME} for the date ${P1}"
     exit 1;
fi

echo "Processing finished for $File at ${TIME} for the date ${P1}"  

exit 0
