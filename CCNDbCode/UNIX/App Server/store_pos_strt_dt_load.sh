#!/bin/sh
###############################################################################################################################
# Script name   : store_pos_strt_dt_load.sh
# Description   : 
#
#
# Created  : 04/10/2018 nxk927 CCN Project Team.....
# Modified : 
###############################################################################################################################

. /app/ccn/ccn_app_server.config

PROC_NAME="store_pos_strt_dt_load.sh"
DATE=$(date +"%Y-%m-%d")
LOGDIR="$HOME/CcnJavaCode/log"
LOGFILE="store_pos_strt_dt_load.log"

TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Processing Store start date started at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

TIME=$(date +"%H%M%S")
$SCRIPT_DIR/store_pos_strt_dt_dwnld_qmsgs.sh 
status=$?
if [ $status -ne 0 ]
then
    exit 1
fi
echo " $PROC_NAME --> New Stores downloaded from the Queue at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

TIME=$(date +"%H%M%S")
$SCRIPT_DIR/store_pos_strt_dt_prcss_qmsgs.sh
status=$?
if [ $status -ne 0 ]
then
    exit 1
fi

TIME=$(date +"%H%M%S")
echo " $PROC_NAME --> Processing New Store Downloads completed at $DATE : $TIME "  >> $LOGDIR/$LOGFILE

exit 0