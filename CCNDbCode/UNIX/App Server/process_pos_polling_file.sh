#!/bin/bash
###############################################################################################################################
# Script name   : process_pos_polling_file.sh
#
# Description   : This script is to process polling files that moved from db server to app server and send it to polling.
#
# Created  : 01/10/2017 mxk766 CCN Project Team.....
# Modified :
###############################################################################################################################
# shellcheck disable=SC1091

#Run below command to make the process run in the background even after shutdown
#nohup sh /app/ccn/process_pos_polling_file.sh > /app/ccn/polling/log/process_pos_polling_file.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep process_pos_polling_file.sh

. /app/ccn/dev/ccn.config

DATADIR="$HOME/polling/datafiles"
ERRORDIR="$HOME/polling/error"
ARCHIVEDIR="$HOME/polling/archivefiles"
LOGDIR="$HOME/polling/log"
DATE=$(date +"%d%m%Y")
TIME=$(date +"%H%M%S")
CLASSHOME="$HOME/polling/java"

while(true)
do

#Check for .POLLINGDONE files. If present then process all the xml and send the file to the java class file.
#Check for the existence of the POLLINGDONE file. If present the loop through the files.
if [ "$(ls "$DATADIR/"*".POLLINGDONE" 2>/dev/null | wc -l)" -gt 0 ];
then

for files in "$DATADIR/"*".POLLINGDONE"
do
   #Identify the XMLFILES, REQUESTFILES from the POLLINGDONE file.
   DONEFILENAME="$files"   
   FILENAME="${DONEFILENAME//POLLINGDONE/XML}"
   REQUESTNAME="$(basename "${FILENAME//XML/REQUEST}")"
   TIME="$(date +"%H%M%S")"
   LOGFILENAME="$(basename "${FILENAME//XML/LOG}")"
   
   #Create a log file.
   touch "$LOGDIR/$LOGFILENAME"

   echo "Processing of sending files to Polling started at $DATE : $TIME " > "$LOGDIR/$LOGFILENAME"
   echo "Processing file $REQUESTNAME " >> "$LOGDIR/$LOGFILENAME"

   #Check for file type and deceide on the environment.
   if [ "$(echo "$REQUESTNAME" | grep -c "StoreUpdate")" -gt 0 ];
   then      
      POLLINGUSERNAME="$STOREUSERNAME"
      POLLINGPASSWORD="$STOREPASSWORD"
      POLLINGENVIRONMENT="$STOREENVIRONMENT"
   elif [ "$(echo "$REQUESTNAME" | grep -c "TerritoryUpdate")" -gt 0 ];
   then
      POLLINGUSERNAME="$TERRUSERNAME"
      POLLINGPASSWORD="$TERRPASSWORD"
      POLLINGENVIRONMENT="$TERRGENVIRONMENT"
   elif [ "$(echo "$REQUESTNAME" | grep -c "ParamUpdate")" -gt 0 ];
   then
      POLLINGUSERNAME="$PARAMUSERNAME"
      POLLINGPASSWORD="$PARAMPASSWORD"
      POLLINGENVIRONMENT="$PARAMENVIRONMENT"
   fi
   
   #Go the class file path and call the java method by passing the required parameters
   cd "$CLASSHOME" || exit
   #Take the file and pass it to the java class.

   REQUESTID=$(java com.webservice.PollingRequest "$POLLINGUSERNAME" "$POLLINGPASSWORD" "$POLLINGENVIRONMENT" "$FILENAME" "$ENVIRON") 

   #After execution of the java class file go to the home directory and check for the polling response.
   cd "$HOME" || exit
   
   #If the response has errors, then log the error and move it to the error folder.
   if [[ "$REQUESTID" == *"Invalid Number of arguments passed."* ]] || 
      [[ "$REQUESTID" == *"Exception in the RestAdapter calling method section."* ]] || 
      [[ "$REQUESTID" == *"Invalid file path provided."* ]] || 
      [[ "$REQUESTID" == *"Error"* ]];
   then

      #Call the email mechansim to report the issue. Pass the file name and the error message that occurs while executing.
      echo "Processing done for $REQUESTNAME and Request Id is :$REQUESTID " >> "$LOGDIR/$LOGFILENAME"

      printf "Polling class PollingRequest failed while processing file: $FILENAME %s\n" "Error returned by class com.webservice.PollingRequest is $REQUESTID " > "$DATADIR/$REQUESTNAME"						
      echo "Polling process failed so moving $FILENAME and $files to error directory $ERRORDIR. ">> "$LOGDIR/$LOGFILENAME"
      
      #Moving the XML and PROSSINGDONE files to the error directory.
      mv {"$files","$FILENAME"} "$ERRORDIR"

   else

      #No issues so generating an requestid file and also archive the processed files.
      echo "Processing done for $REQUESTNAME and Request Id is :REQUESTID" >> "$LOGDIR/$LOGFILENAME"
      echo "$REQUESTID" > "$DATADIR/$REQUESTNAME"
      echo "Created a REQUEST file $DATADIR/$REQUESTNAME" >> "$LOGDIR/$LOGFILENAME"
      echo "Moving files $files and $FILENAME to archive directory $ARCHIVEDIR" >> "$LOGDIR/$LOGFILENAME"
      mv {"$files","$FILENAME"} "$ARCHIVEDIR"
      status=$?

      if [ "$status" -gt 0 ];
      then

         echo "Moving of files to the archive directory failed. Emailing the error log.">> "$LOGDIR/$LOGFILENAME"
         ./send_mail.sh "ARCHIVINGPROCESSFAILURE" "Archiving process failed. Please check the log file $LOGDIR/$LOGFILENAME"
         exit 1;
      else
         echo "Archiving of $files and $FILENAME to $ARCHIVEDIR Done." >> "$LOGDIR/$LOGFILENAME"
      fi

   fi

done

fi;

done
