#!/bin/bash
###############################################################################################################################
# Script name   : init_load_files_web_service.sh
#
# Description   : This script is to call java proc which reads the webservice, creates and FTP's a file to DB Server
#               : APPL can have values of "STORE"/ "TERR"/ "PARAM"
# Created       : 09/27/2017 rxv940 CCN Project Team.....
# Modified      : 
###############################################################################################################################

. /app/ccn/ccn_app_server.config

APPL=$1
# APPL can have values of "STORE"/ "TERR"/ "PARAM"
JAVA_DIR=/app/ccn/POSdownloads/java
PROC_NAME=".sh"
DATADIR="$HOME/POSdownloads/POSxmls"
DATE=$(date +"%d%m%Y")
FILENAME=CCD_LIST.queue


cd $JAVA_DIR || exit
NEW_STR_LST=$(java com.webservice.dwnld_frm_web_srvc "$APPL")
echo "$NEW_STR_LST"  >> $DATADIR/$FILENAME
chmod 777 $FILENAME


TIME=$(date +"%H%M%S")
echo "Moving the .queue file to DB Server started at $DATE:$TIME "
$SCRIPT_DIR/polling_dwnld_files_ftp_to_db_server.sh "$FILENAME"
TIME=$(date +"%H%M%S") 
echo "Moving the .queue file to DB Server completed at $DATE:$TIME "
