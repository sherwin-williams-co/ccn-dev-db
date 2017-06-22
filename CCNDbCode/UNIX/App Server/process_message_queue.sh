#!/bin/bash
###############################################################################################################################
# Script name   : process_message_queue.sh
#
# Description   : This script is to call java proc which reads the polling Message queue and load the contents of the queue  
#                 into a file and ftp it to the DB Server. This is intended to be a Control M Job
# Created       : 06/05/2017 rxv940 CCN Project Team.....
# Modified      : 
###############################################################################################################################

. /app/ccn/ccn.config

PROC_NAME="process_message_queue.sh"
DATADIR="$HOME/POSdownloads/POSxmls"
DATE=$(date +"%d%m%Y")
TIME=$(date +"%H%M%S")
FILENAME=$DATADIR/COST_CENTER_DEQUEUE.queue
SCRIPT_PATH="$HOME/scripts"


#Go the class file path and call the java method by passing .ccdt file as parameters
PATH=/usr/jdk/jdk1.6.0_31/bin:$PATH
QueueMessage=$(java -classpath .:../PollingQueue/lib/com.ibm.dhbcore.jar:../PollingQueue/lib/com.ibm.mq.jar:../PollingQueue/lib/com.ibm.mqjms.jar:../PollingQueue/lib/connector.jar:../PollingQueue/lib/javax.jms.jar:../PollingQueue com.webservice.ReadMessageQueue /app/ccn/PollingQueue/CCN-v8.ccdt)

#Print the output of java program
if [ ! -z "$QueueMessage" ]; then
    echo "$QueueMessage"  >> $FILENAME


	#If the response has errors, then log the error and move it to the error folder.
	if [[ "$QueueMessage" == *"Invalid Number of arguments passed."* ]] ||  
	   [[ "$QueueMessage" == *"Invalid file path provided."* ]] || 
	   [[ "$QueueMessage" == *"Error"* ]];
	then

	   #Log the Error Message.
	   echo " $PROC_NAME --> Error in Reading Message queue from com.webservice.ReadMessageQueue :$QueueMessage at $DATE $TIME" 
	   $SCRIPT_PATH/send_mail.sh "QueueDownloadFAILURE" 
	   exit 1

	else

	   #No issues so generating a file with message in the queue.
	   echo " $PROC_NAME --> Message Read from queue :$QueueMessage at $DATE $TIME " 
	   echo " $PROC_NAME --> Created a Message file $FILENAME at $DATE $TIME " 
	   echo " $PROC_NAME --> Starting FTP of Trigger file to DB Server at $DATE $TIME " 
	   $SCRIPT_PATH/mv_trigger_file_to_dbserver.sh
       exit 0       
	fi
	
else

    echo " $PROC_NAME --> There is no data in the queue at $DATE $TIME "
    exit 0
fi


