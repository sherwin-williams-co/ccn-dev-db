#!/bin/sh
############################################################################
# Script name : gl_ps_ftp_to_db_server_bg.sh
# Description : This shell script will call gl_ps_mv_rqst_to_db_server.sh
#             : after receving the PrimeSub .REQUEST file
#
# Created  : 07/05/2017 rxv940 CCN Project ....
# Modified : 
#              
############################################################################

#Run below command to make the process run in the background even after shutdown
#nohup sh /app/ccn/scripts/gl_ps_ftp_to_db_server_bg.sh > /app/ccn/POSdownloads/log/gl_ps_ftp_to_db_server_bg.log 2>&1 &

#Below statement will be used to check if the process is running in the background
#ps -eaf | grep gl_ps_ftp_to_db_server_bg.sh

. /app/ccn/ccn.config
DATADIR="$HOME"/POSdownloads/POSxmls

while(true)
do

#Check for .REQUEST file 
if [ $(ls "$DATADIR/$GL_PS_FILE_NAME"*".REQUEST" 2>/dev/null | wc -l) -gt 0 ] 
then
    $SCRIPT_DIR/gl_ps_mv_rqst_to_db_server.sh
fi

done 
exit 1
