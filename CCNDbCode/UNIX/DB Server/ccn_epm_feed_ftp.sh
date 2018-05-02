#!/bin/sh
###############################################################################################################################
# Script name   : ccn_epm_feed_ftp.sh
# Description   : This script will FTP the Store Bank Card File to "" Server.
#
# Created  	: 04/17/2018 sxg151 CCN Project Team.....
# Modified  : 
###############################################################################################################################
. /app/ccn/host.sh

DATE=`date +"%m%d%y"`
PROC_NAME=ccn_epm_feed_ftp.sh.sh
DATADIR="$HOME"/datafiles
FILENAME="SELLING_STORE_HRCHY_FORMAT_$DATE.dat"
TIME=`date +"%H:%M:%S"`

###############################################################################################
# ftp the SELLING_STORE_HRCHY_FORMAT.dat file to " " 

###############################################################################################
cd $DATADIR
ftp -inv "${epm_host}"<<END_SCRIPT
quote USER ${epm_user}
quote PASS ${epm_pw}
cd ${epm_data_ftp_path}
binary
put $FILENAME
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