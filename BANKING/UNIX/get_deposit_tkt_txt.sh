#!/bin/sh
#################################################################
# Script name   : get_deposit_tkt_txt.sh
#
# Description   : this scripts to check if there are any unprocessed deposit ticket for the cost center 
#                 in the server we are going to ftp the newly created deposit ticket
#
# Created  : 04/04/2016 nxk927 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="get_deposit_tkt_txt"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"` 
file=$1
filename=$file.txt
echo "Processing Started for $proc_name at $TIME on $DATE"

# Move to issue_file folder from where ever you are in
cd /$HOME/datafiles/issue_file
# get the file from the Server to check if the file is present that needs to be processed first before 
# ftp'ing the newly created deposit ticket
ftp -inv ${mainframe_host} <<FTP_MF
quote user ${mainframe_user}
quote pass ${mainframe_pw}
cd hpex/Apps/Bank_Deposit_Tickets/Input
get $filename
bye
END_SCRIPT
FTP_MF
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "bye the transfer is complete at ${TIME} on ${DATE}"
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

exit 0
############################################################################