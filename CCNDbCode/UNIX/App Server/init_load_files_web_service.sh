#!/bin/bash
###############################################################################################################################
# Script name   : init_load_files_web_service.sh
#
#APP Server  --> init_load_files_web_service.sh 
#
#DB Server   --> generate_ws_diff_files_bg.sh  --> stp_ws_diff_init_loads.sh
#
#APP Server  --> stp_call_polling_ws_diff_bg.sh --> stp_call_polling_ws_diff_prcs.sh --> exec_init_load_web_service.sh
#
# Description   : This script is to call java proc which reads the webservice, creates and FTP's a file to DB Server
# Created       : 09/27/2017 rxv940 CCN Project Team.....
# Modified      : 10/04/2017 rxv940 CCN Project Team.....
#               : removed the parameter and hard coded values
###############################################################################################################################

. /app/ccn/ccn_app_server.config

JAVA_DIR=/app/ccn/POSdownloads/java
DATADIR="$HOME/POSdownloads/POSxmls"
DATE=$(date +"%d%m%Y")
FILENAME=CCD_LIST.ws_diff
PROC_NAME=init_load_files_web_service.sh
LOGDIR="$HOME/POSdownloads/log"
LOGFILE=init_load_files_web_service.log

cd $JAVA_DIR || exit
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Generating the .ws_diff file thru' the JAVA Class started at $DATE:$TIME "  >> $LOGDIR/$LOGFILE
#NEW_STR_LST=$(java com.webservice.dwnld_frm_web_srvc "STORE")
echo "$(java com.webservice.dwnld_frm_web_srvc "STORE")"  >> $DATADIR/"STORE_"$FILENAME
echo "$(java com.webservice.dwnld_frm_web_srvc "TERR")"  >> $DATADIR/"TERR_"$FILENAME
echo "$(java com.webservice.dwnld_frm_web_srvc "PARAM")"  >> $DATADIR/"PARAM_"$FILENAME
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Generating the .ws_diff file thru' the JAVA Class completed at $DATE:$TIME "  >> $LOGDIR/$LOGFILE

TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Moving the .ws_diff file to DB Server started at $DATE:$TIME "  >> $LOGDIR/$LOGFILE
$SCRIPT_DIR/polling_dwnld_files_ftp_to_db_server.sh "STORE_$FILENAME"  >> $LOGDIR/$LOGFILE
$SCRIPT_DIR/polling_dwnld_files_ftp_to_db_server.sh "TERR_$FILENAME"  >> $LOGDIR/$LOGFILE
$SCRIPT_DIR/polling_dwnld_files_ftp_to_db_server.sh "PARAM_$FILENAME"  >> $LOGDIR/$LOGFILE
TIME=$(date +"%H%M%S")   
echo " $PROC_NAME --> Moving the .ws_diff file to DB Server completed at $DATE:$TIME "  >> $LOGDIR/$LOGFILE

TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Archiving the .ws_diff file started at $DATE:$TIME "  >> $LOGDIR/$LOGFILE
$SCRIPT_DIR/polling_dwnld_files_archive_process.sh "STORE_$FILENAME"  >> $LOGDIR/$LOGFILE
$SCRIPT_DIR/polling_dwnld_files_archive_process.sh "TERR_$FILENAME"  >> $LOGDIR/$LOGFILE
$SCRIPT_DIR/polling_dwnld_files_archive_process.sh "PARAM_$FILENAME"  >> $LOGDIR/$LOGFILE
TIME=$(date +"%H%M%S") 
echo " $PROC_NAME --> Archiving the .ws_diff file completed at $DATE:$TIME "   >> $LOGDIR/$LOGFILE

exit 0
