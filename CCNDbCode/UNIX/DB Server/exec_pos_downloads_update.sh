#!/bin/sh
#################################################################
# Script name   : exec_pos_downloads_update.sh
# Description   : This shell script will update the pos_downloads table
#                 with the requestid for the given file name
#                 The first parameter is filename and 2nd parameter is requestid.   
# Created       : 10/03/2016 MXK766 CCN Project ....
# Modified      : 04/03/2017 rxv940 CCN Project....
#               : Adding code to handle the PRIME_SUB_PROCESS loads as well 
#################################################################
. /app/ccn/host.sh


proc_name="exec_pos_downloads_update.sh";
FILENAME=$1
REQUESTID=$2

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

echo " $proc_name --> Processing starting at $DATE $TIME "
echo " $proc_name --> The file name is $FILENAME at $DATE $TIME " 
echo " $proc_name --> The Requestid is $REQUESTID at $DATE $TIME " 


if [[ "$FILENAME" = "PrimeSub"*".XML" ]]
then
    echo " $proc_name --> Calling script pos_downloads_gl_ps_upd.sh at $DATE $TIME " 
    sh ./pos_downloads_gl_ps_upd.sh "$FILENAME" "$REQUESTID" 
else
    echo " $proc_name --> Calling script return_pos_downloads.sh  at $DATE $TIME " 
    sh ./return_pos_downloads.sh "$FILENAME" "$REQUESTID"
fi

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]
then
    TIME=`date +"%H:%M:%S"`
    echo " $proc_name --> processing FAILED while executing $proc_name at $DATE $TIME "
    ./send_mail.sh "POLLING_FAILURE_MAIL" 
     exit 1
fi

TIME=`date +"%H:%M:%S"`
echo " $proc_name --> Processing Finished for $proc_name for file name $FILENAME at $DATE $TIME "
exit 0

############################################################################

