#!/bin/sh
###############################################################################################################################
# Script name   : descartes_address_feed.sh
# Description   : 
#
#
# Created  : 10/16/2017 jxc517 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/ccn_app_server.config

PROC_NAME="descartes_address_feed.sh"
CLASSHOME="$HOME/CcnJavaCode"
DATE=$(date +"%Y-%m-%d")
LOGDIR="$HOME/CcnJavaCode/log"
LOGFILE="descartes_address_feed.log"

echo "*************************************************************************************" >> $LOGDIR/$LOGFILE
TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Call to the JAVA class started at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

cd "$CLASSHOME" || exit
feedLog=$(java com.descartes.httppost.AddressFeedHttpPostXml "$DATE")

TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> The output of the class file is $feedLog at $DATE:$TIME " >> $LOGDIR/$LOGFILE

TIME="$(date +"%H%M%S")"
echo " $PROC_NAME --> processing completed at $DATE : $TIME "  >> $LOGDIR/$LOGFILE
exit 0

