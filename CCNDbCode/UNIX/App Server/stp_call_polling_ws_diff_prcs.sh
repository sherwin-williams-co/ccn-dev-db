#!/bin/sh
#####################################################################################
# Script name   : stp_call_polling_ws_diff_prcs.sh
#
# Description   : This script is to call polling process for TERR, STORE and PARAM 
#               : inits on arrival of .queue and .ws_diff files in the APP Server
# Created  : 10/06/2017 rxv940 CCN Project Team.....
# Modified : 
#####################################################################################

. /app/ccn/ccn_app_server.config
LOGDIR=/app/ccn/POSdownloads/log
LOGFILE=stp_call_polling_ws_diff_prcs.log

$SCRIPT_DIR/exec_init_load_web_service.sh "STORE"    >  $LOGDIR/$LOGFILE
$SCRIPT_DIR/exec_init_load_web_service.sh "TERR"     >  $LOGDIR/$LOGFILE
$SCRIPT_DIR/exec_init_load_web_service.sh "PARAM" >  $LOGDIR/$LOGFILE
$SCRIPT_DIR/polling_dwnld_files_archive_process.sh "$CCD.queue"   >  $LOGDIR/$LOGFILE
$SCRIPT_DIR/polling_dwnld_files_archive_process.sh "$CCD.ws_diff" >  $LOGDIR/$LOGFILE
