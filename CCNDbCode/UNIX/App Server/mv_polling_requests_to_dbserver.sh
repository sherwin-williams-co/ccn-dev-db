#!/bin/sh
###############################################################################################################################
# Script name   : mv_polling_requests_to_dbserver.sh
#
# Description   : This script is to transfer files from db server to app server.
#
# Created  : 01/10/2017 mxk766 CCN Project Team.....
# Modified : 03/10/2017 rxv940 CCN Project Team.....
#            changes to ccn.config path, changes to variables that compute the directory paths
###############################################################################################################################
# shellcheck disable=SC1091
#Run below command to make the process run in the background even after shutdown
#nohup sh /app/ccn/mv_polling_requests_to_dbserver.sh > /app/ccn/polling/log/mv_polling_requests_to_dbserver.log 2>&1 &
#ps -eaf | grep mv_polling_requests_to_dbserver.sh

. /app/ccn/ccn.config

DATADIR="$HOME/POSdownloads/POSxmls"
ARCHIVEDIR="$HOME/POSdownloads/archivefiles"
LOGDIR="$HOME/POSdownloads/log"
DATE=$(date +"%d%m%Y")
TIME=$(date +"%H%M%S")


while(true)
do

#Check for .REQUEST files. If present then move them to the DB Server and also archive those files.
#Check for the REQUEST file existence.
if [ $(ls "$DATADIR/"*".REQUEST" 2>/dev/null | wc -l) -gt 0 ];
then

   cd "$DATADIR" || exit
   #Loop through the files and ftp the files to the db server. 
   for files in *".REQUEST"
   do

      #FTP files from ccn db server to ccn app server
      FILENAME="$files"
      TIME=$(date +"%H%M%S")

      #Create a log file and log the operations.
      LOGFILE="$LOGDIR/$FILENAME""_$TIME".ftplog
      touch "$LOGFILE"

      echo "ftp of $FILENAME to dbserver $CCNDBUSERNAME@$CCNDBSERVERHOST started at $DATE " > "$LOGFILE"
      #Add a check to make sure that we have the XML File. If it there then only execute the below code.
ftp -inv "${CCNDBSERVERHOST}" <<END_SCRIPT >> "$LOGFILE"
quote USER ${CCNDBUSERNAME}
quote PASS ${CCNDBPASSWORD}
cd ${CCNDBSERVDEST}
put $FILENAME
quit
END_SCRIPT

      status=$?
      echo "status of ftp process is "$status >>"$LOGFILE"

      if [ $status -gt 0 ];
      then

         echo "FTP failed when ftping the file $FILENAME.">>"$LOGFILE"
         ./send_mail.sh "FTPFAILURE" "FTPING Failed for $FILENAME. Please check the log file $LOGFILE"
         exit 1;

      fi

      mv "$FILENAME" "$ARCHIVEDIR"
      echo "File $FILENAME archived to $ARCHIVEDIR">>"$LOGFILE"

   done
   cd "$HOME" || exit

fi;
done
