#!/bin/sh
###############################################################################################################################
# Script name   : str_mv_rqst_to_db_server.sh
# Description   : This script is to transfer files from db server to app server.
#
# Created  : 07/05/2017 rxv940 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/ccn.config

PROC_NAME="str_mv_rqst_to_db_server.sh"
DATADIR="$HOME/POSdownloads/POSxmls"
ARCHIVEDIR="$HOME/POSdownloads/POSxmls/archivefiles"
ERRORDIR="$HOME/POSdownloads/error"
DATE=$(date +"%d%m%Y")
TIME=$(date +"%H%M%S")

echo " $PROC_NAME --> Processing started at $DATE:$TIME "
cd "$DATADIR" || exit

for files in "StoreUpdate"*".REQUEST"
do

    #FTP files from ccn db server to ccn app server
    FILENAME="$files"
    TIME=$(date +"%H%M%S")
    echo " $PROC_NAME --> FTP of $FILENAME to dbserver $CCNDBUSERNAME@$CCNDBSERVERHOST started at $DATE:$TIME " 
ftp -inv "${CCNDBSERVERHOST}" <<END_SCRIPT 
quote USER ${CCNDBUSERNAME}
quote PASS ${CCNDBPASSWORD}
cd ${CCNDBSERVDEST}
put $FILENAME
quit
END_SCRIPT

    status=$?
    TIME=$(date +"%H%M%S")
    
    if [ $status -gt 0 ];
    then
        echo " $PROC_NAME --> FTP failed when ftping the file $FILENAME at $DATE:$TIME "
        ./send_mail.sh "FTPFAILURE" 
        mv "$FILENAME" "$ERRORDIR"
        echo " $PROC_NAME --> File $FILENAME is moved to $ERRORDIR at $DATE:$TIME "
        exit 1
    fi
    echo " $PROC_NAME --> status of ftp process is $status and the file is placed at $CCNDBSERVDEST at $DATE:$TIME "

################################# END OF ERROR CHECK #################################

    mv "$FILENAME" "$ARCHIVEDIR"
    status=$?
    TIME=$(date +"%H%M%S")
    
    if [ $status -gt 0 ];
    then
        echo " $PROC_NAME --> Process failed while archiving the file $FILENAME at $DATE:$TIME "
        ./send_mail.sh "ARCHIVINGPROCESSFAILURE" 
        mv "$FILENAME" "$ERRORDIR"
        echo " $PROC_NAME --> File $FILENAME is moved to $ERRORDIR at $DATE:$TIME "
        exit 1
    fi
    echo " $PROC_NAME --> File $FILENAME is archived under $ARCHIVEDIR at $DATE:$TIME "

################################# END OF ARCHIVE CHECK #################################

done

exit 0