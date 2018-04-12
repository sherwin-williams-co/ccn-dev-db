#!/bin/sh 
###############################################################################################################################
# Script name   : ccn_store_bank_card_file_ftp.sh
# Description   : This script will FTP the Store Bank Card File to SMIS Server.
#
# Created  	: 03/06/2018 sxg151 CCN Project Team.....
# Modified  : 
###############################################################################################################################
. /app/ccn/host.sh

DATE=`date +"%m%d%y"`
PROC_NAME=ccn_store_bank_card_file_ftp.sh
DATADIR="$HOME"/datafiles
FILENAME=$1
FILENAME2=$2
TIME=`date +"%H:%M:%S"`

###############################################################################################
# ftp the STORE_BANK_CARD_SERIAL.dat and merchtb.dat File's to stuar2hq.sw.sherwin.com server 

###############################################################################################
cd $DATADIR
ftp -inv "${uar_host}"<<END_SCRIPT
quote USER ${uar_user}
quote PASS ${uar_pw}
cd ${str_bnk_crd_srl_mrchnt_files_ftp_path}
binary
put $FILENAME
put $FILENAME2
quit
END_SCRIPT

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
   then
     echo "processing FAILED for $PROC_NAME at ${TIME} on ${DATE}"
     exit 1
fi
TIME=`date +"%H:%M:%S"`
echo "Processing finished for $PROC_NAME at ${TIME} on ${DATE}"
exit 0

##################################################################################################################################
#                                                   END of PROGRAM.  
##################################################################################################################################