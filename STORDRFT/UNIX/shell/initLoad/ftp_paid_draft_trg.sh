#!/bin/sh
#######################################################################################
# Description     : Script to FTP PAID_DRAFT.TRG file to the STDSSAPHQ server 
#                   once the execution of JV_monthly_load.sh scripts is completed. 
# Created by/Date : SXT410 01/20/2015
# Modified on/Date: 
#######################################################################################

# below command will get the path for stordrft.config respective to the environment from which it is run from.
. /app/stordrft/host.sh

TimeStamp=`date '+%Y%m%d%H%M%S'`
LOGDIR="$HOME/initLoad/logs"
File="FTP_PAID_DRAFT.TRG"

cd $HOME/initLoad

echo -n "" > PAID_DRAFT.TRG

echo " Starting FTP Process to STDSSAPHQ " >> $LOGDIR/$File"_"$TimeStamp.log 
ftp -n ${STDSSRVR_host} <<END_SCRIPT
quote USER ${USER}
quote PASS ${PASSWD}
cd /Data/Triggers

put PAID_DRAFT.TRG

quit
END_SCRIPT
echo " FTP Process Successful "
exit 0