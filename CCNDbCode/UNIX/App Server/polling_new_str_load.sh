#!/bin/sh
###############################################################################################################################
# Script name   : polling_new_str_load.sh
# Description   : 
#
#
# Created  : 10/16/2017 jxc517 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/ccn_app_server.config

PROC_NAME="polling_new_str_load.sh"
CLASSHOME="$HOME/CcnJavaCode"
DATE=$(date +"%Y-%m-%d")
LOGDIR="$HOME/CcnJavaCode/log"
LOGFILE="polling_new_str_load.log"

echo "*************************************************************************************" >> $LOGDIR/$LOGFILE
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Call to the JAVA class started at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

cd "$CLASSHOME" || exit
feedLog=$(java com.polling.downloads.InitialLoadProcess "NEW_STR_LD")

TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> The output of the class file is $feedLog at $DATE:$TIME " >> $LOGDIR/$LOGFILE

TIME="$(date +"%H%M%S")"
echo " $PROC_NAME --> processing completed at $DATE : $TIME "  >> $LOGDIR/$LOGFILE
exit 0

