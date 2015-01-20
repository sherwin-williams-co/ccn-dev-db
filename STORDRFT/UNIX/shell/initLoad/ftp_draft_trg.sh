#######################################################################################
# Description     : Script to FTP DRAFT.TRG file to the STDSSAPHQ server 
#                   once the execution of GainLossJV script is completed. 
# Created by/Date : AXK326 01/15/2015
# Modified on/Date: 
#######################################################################################
#!/bin/sh

. /app/stordrft/host.sh

DATE=`date +"%m/%d/%Y"`

cd $HOME/Reports

echo "" > DRAFT.TRG

echo " Starting FTP Process to STDSSAPHQ "
ftp -n ${STDSSRVR_host} <<END_SCRIPT
quote USER ${USER}
quote PASS ${PASSWD}
cd /Data/Triggers

put DRAFT.TRG

quit
END_SCRIPT

echo " FTP Process Successful "
exit 0