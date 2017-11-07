#!/bin/sh
###############################################################################################################################
# Script name   : ccn_value_link_sra31000_ftp.sh
# Description   : This script will FTP VALUELINK FILE from db server to app server. This runs on DB Server
#
# Created  		: 11/06/2017 BXA919 CCN Project Team.....
# Modified : 
###############################################################################################################################
. /app/ccn/host.sh

DATE=`date +"%m%d%y"`
PROC_NAME=ccn_value_link_sra31000_ftp.sh
DATADIR="$HOME"/datafiles
FILENAME=SRA31000_${DATE}.TXT

ftp -inv "${CCNAPPSERVER_HOST}"<<END_SCRIPT
quote USER ${CCNAPPSERVER_USERNAME}
quote PASS ${CCNAPPSERVER_PASSWORD}
put $DATADIR/$FILENAME ${SRA31000_APP_SRVR_PATH}/VALUE_LINK
quit
END_SCRIPT

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
TIME=`date +"%H:%M:%S"`
if [ $status -ne 0 ]
then
    echo " $proc_name --> processing FAILED while executing ccn_value_link_sra31000_ftp.sh at $DATE:$TIME "
    ./send_mail.sh "VALUELINK_FILE_FAILURE"
     exit 1
fi
echo " $PROC_NAME -->  Files $FILENAME  are transferred to the app server on $DATE:$TIME "
exit 0

###############################################################################################################################
							END OF THE SCRIPT
###############################################################################################################################