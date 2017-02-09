#!/bin/sh
###############################################################################################################################
# Script name   : mv_posfiles_from_dbserver_to_appserver.sh
#
# Description   : This script is to transfer files from db server to app server.
#
# Created  : 01/10/2017 mxk766 CCN Project Team.....
# Modified :
###############################################################################################################################
# shellcheck disable=SC1091
. /app/ccn/host.sh
PROC_NAME=mv_posfiles_from_dbserver_to_appserver.sh
DATADIR="$HOME"/datafiles
ARCHIVEDIR="$HOME/datafiles/polling/archive"
LOGDIR="$HOME/datafiles/log"
DATE=$(date +"%d%m%Y")
TIME=$(date +"%H%M%S")
while(true)
do

#Check for .POLLINGDONE files. If present.
if [ $(ls "$DATADIR/"*".POLLINGDONE" 2>/dev/null | wc -l) -gt 0 ];
then

   cd "$DATADIR" || exit

   for files in *".POLLINGDONE"
   do

      #FTP files from ccn db server to ccn app server
      FILENAME=$(echo "$files" | sed -e 's/POLLINGDONE/XML/g')
      DONEFILENAME=$files

      LOGFILE="$FILENAME"".mvlog"
      touch "$LOGDIR/$LOGFILE"

      #Add a check to make sure that we have the XML File. If it there then only execute the below code.
      echo "FTPing of file $FILENAME and $DONEFILENAME started ">> "$LOGDIR/$LOGFILE"

ftp -inv "${CCNAPPSERVER_HOST}"<<END_SCRIPT
quote USER ${CCNAPPSERVER_USERNAME}
quote PASS ${CCNAPPSERVER_PASSWORD}
cd ${CCNAPPSERVER_DEST}
mput $FILENAME $DONEFILENAME
quit
END_SCRIPT

      status=$?
      if [ $status -gt 0 ]
      then
         echo "processing FAILED while ftping the file $FILENAME at ${TIME} on ${DATE}">> "$LOGDIR/$LOGFILE"
									./send_mail.sh FTPFAILURE "FTPING Failed for $FILENAME. Please check the log file $LOGDIR/$LOGFILE"
         exit 1;
      fi
      echo "FTPing of file $FILENAME and $DONEFILENAME Done">> "$LOGDIR/$LOGFILE"

      TIME=$(date +"%H%M%S")
      echo "File $FILENAME and $DONEFILENAME transferred to the app server $CCNAPPSERVER_HOST at ${TIME} on ${DATE}">> "$LOGDIR/$LOGFILE"
      echo "File $FILENAME and $DONEFILENAME is archived to $ARCHIVEDIR on ${DATE} ">> "$LOGDIR/$LOGFILE"
      mv {"$FILENAME","$DONEFILENAME"} "$ARCHIVEDIR" 

      status=$?
      if [ "$status" -ne 0 ];
      then
         TIME=$(date +"%H:%M:%S")
         echo "processing FAILED for $PROC_NAME while ftping the file $FILENAME and $DONEFILENAME at ${TIME} on ${DATE}">> "$LOGDIR/$LOGFILE"
									./send_mail.sh ARCHIVINGPROCESSFAILURE "Archiving Failed. Please check the log file $LOGDIR/$LOGFILE"
         exit 1;
      fi

   done

fi;

done