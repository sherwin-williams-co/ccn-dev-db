#!/bin/sh
###############################################################################################################################
# Script name   : update_posdownloads_request_id.sh
#
# Description   : This script is to update the request_ids in the pos_downloads table.
#
# Created  : 01/10/2017 mxk766 CCN Project Team.....
# Modified :
###############################################################################################################################

. /app/ccn/host.sh

DATADIR="$HOME"/datafiles
DATE=$(date +"%d%m%Y")
TIME=$(date +"%H%M%S")
ARCHIVEDIR="$HOME/datafiles/polling/archive"
LOGDIR="$HOME/datafiles/log"
ERRORDIR="$HOME/datafiles/polling/error"

while(true)
do

#Check for .REQUEST files. If present then move them to the DB Server and also archive those files.
if [ $(ls "$DATADIR/"*".REQUEST" 2>/dev/null | wc -l) -gt 0 ];
then

   for files in "$DATADIR/"*".REQUEST"
   do

   #Read the file.
   FILENAME=$(basename "$files" | sed -e 's/REQUEST/XML/g')
   LOGFILE="$FILENAME"".updlog"
   touch "$LOGDIR/$LOGFILE"
   echo "Processing of Response file $FILENAME started at $DATE and $TIME ">> "$LOGDIR/$LOGFILE"
   #Check whether it has got any errors or not.
   ERRORCHECK=$(cat $files | grep -c "Error")
   echo "Checking for errors in $files is $ERRORCHECK">> "$LOGDIR/$LOGFILE"
   if [ "$ERRORCHECK" -eq 0 ];
   then
      REQUESTID=$(cat "$files")
      #call the update proc.
      echo "The respnose in the response file $FILENAME is $REQUESTID ">> "$LOGDIR/$LOGFILE"
      ./exec_pos_downloads_update.sh "$FILENAME" "$REQUESTID" "$LOGDIR/$LOGFILE"
      status=$?

      if [ "$status" -gt 0 ];
      then
         #send an Error email.
         echo "The procedure POS_DATA_GENERATION.POS_DOWNLOADS_UPD_SP execution failed ">> "$LOGDIR/$LOGFILE"
         echo "Moving the file $files to the error folder $ERRORDIR  ">> "$LOGDIR/$LOGFILE"
         mv "$files" "$ERRORDIR"

         ./send_mail.sh "POLLING_FAILURE_MAIL" "Failure of procedure POS_DATA_GENERATION.RETURN_POS_DOWNLOADS while processing file $FILENAME and file is moved to the error folder $ERRORDIR".

      else
         echo "Successfully processed the file $files and moving the file to the archive folder $ARCHIVEDIR ">> "$LOGDIR/$LOGFILE"
         mv "$files" "$ARCHIVEDIR"

      fi

   else
      #error in the processing of the java class.
      #Moving the file to archive dir
      ERRORMESSAGE=$(cat "$files")
      echo "The response file $files has errors and the message is $ERRORMESSAGE ">> "$LOGDIR/$LOGFILE"
      ./send_mail.sh "POLLING_FAILURE_MAIL" "Polling failed for file $FILENAME and error message is $ERRORMESSAGE".
      echo "The response file $files has errors and the message is $ERRORMESSAGE ">> "$LOGDIR/$LOGFILE"
      mv "$files" "$ARCHIVEDIR"

   fi

   done

fi;

done