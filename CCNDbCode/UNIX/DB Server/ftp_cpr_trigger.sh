#!/bin/sh
##########################################################
# Script Name   : ftp_cpr_trigger.sh
# Description   : This shell script is called to send a trigger file to CPR
#                 cprdbscriptqa in QA
#                 cprdbscript1 in PROD
# Created       : sxh487 03/27/2017
# Modified      : 
##########################################################
# below command will get the path for ccn.config respective to the environment from which it is run from

. /app/ccn/host.sh

proc_name=ftp_cpr_trigger.sh
DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`

cd $HOME/datafiles
echo "" > CCN_HIER_UPDATE.TRG

echo " Starting FTP Process to ${cpr_servername} at $TIME on $DATE"    
# ftp to CPR server
ftp -n ${cpr_servername} <<END_SCRIPT
quote USER ${cpr_username}
quote PASS ${cpr_password}
cd /app/cpr/data_load
put CCN_HIER_UPDATE.TRG
quit
END_SCRIPT

status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at $TIME on $DATE"
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at $TIME on $DATE"

echo " Removing the trigger file $HOME/datafiles/CCN_HIER_UPDATE.TRG"

rm -f $HOME/datafiles/CCN_HIER_UPDATE.TRG

exit 0