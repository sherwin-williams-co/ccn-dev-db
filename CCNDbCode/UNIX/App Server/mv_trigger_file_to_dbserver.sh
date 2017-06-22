#!/bin/sh
###############################################################################################################################
# Script name   : mv_triger_file_to_dbserver.sh
#
# Description   : This script is to transfer .trgfile file from app server to db server.
#
# Created  : 05/30/2017 rxv940 CCN Project Team.....
###############################################################################################################################
# shellcheck disable=SC1091

. /app/ccn/ccn.config

PROC_NAME="mv_triger_file_to_dbserver.sh"
DATADIR="$HOME/POSdownloads/POSxmls"
ARCHIVEDIR="$HOME/POSdownloads/POSxmls/archivefiles"
ERRDIR="$HOME/POSdownloads/error"
TRGFILE="$DATADIR/COST_CENTER_DEQUEUE.TRGFILE"
FILENAME="$DATADIR/COST_CENTER_DEQUEUE.queue"

DATE=$(date +"%d%m%Y")
TIME=$(date +"%H%M%S")


#Check for .queue files. If present then move the trigger file to the DB Server and also archive .queue files.
#Check for the queue file existence.
if [ $FTP_QUEUE == 'Y' ];
then

    cd "$DATADIR" || exit
    echo "This is a Trigger File" > "$TRGFILE" 
    echo " $PROC_NAME --> $TRGFILE created and  ftp of $TRGFILE to dbserver $CCNDBUSERNAME@$CCNDBSERVERHOST started at $DATE $TIME " 
	  
ftp -inv "${CCNDBSERVERHOST}" <<END_SCRIPT
quote USER ${CCNDBUSERNAME}
quote PASS ${CCNDBPASSWORD}
cd ${CCNDBSERVDEST}
put $TRGFILE COST_CENTER_DEQUEUE.TRGFILE
quit
END_SCRIPT
    
	
	status=$?
    echo " $PROC_NAME --> status of ftp process is $status at $DATE $TIME "

    if [ $status -gt 0 ];
    then

        echo " $PROC_NAME --> FTP failed when ftping the file $TRGFILE at $DATE $TIME ."
	    mv "$FILENAME" "$ERRDIR" 
        mv "$TRGFILE" "$ERRDIR"
		echo " $PROC_NAME --> Files $FILENAME and $TRGFILE are moved to $ERRDIR at $DATE $TIME ."
        $SCRIPT_PATH/send_mail.sh "FTPFAILURE" 
        exit 1

    fi

    mv "$FILENAME" "$ARCHIVEDIR"
    mv "$TRGFILE" "$ARCHIVEDIR" 
    echo " $PROC_NAME --> Files $FILENAME and $TRGFILE are archived under $ARCHIVEDIR at $DATE $TIME "

    cd "$HOME" || exit

fi
