#!/bin/sh
#################################################################
# Script name   : deposit_tkt_xml_ftp.sh
#
# Description   : this scripts to check if there are any unprocessed deposit ticket for the cost center 
#                 in the server we are going to ftp the newly created deposit ticket
#
# Created  : 04/04/2016 nxk927 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="deposit_tkt_xml_ftp"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
file_path="$HOME/datafiles"
archieve_path="$HOME/datafiles/archieve"
filename=$1

echo "Processing Started for $proc_name at $TIME on $DATE"
cd $HOME/datafiles
# ftp to ServerName 
ftp -inv ${mainframe_host} <<FTP_MF
quote user ${mainframe_user}
quote pass ${mainframe_pw}
cd hpex/Apps/Bank_Deposit_Tickets/Input
mput $filename 
bye
END_SCRIPT
echo "bye the transfer is complete"
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

echo "copying files from $file_path to $archieve_path"

fname=$(echo $filename | cut -f 1 -d '.')
date=`date +"%m%d%Y%H%M%S"`
# Copy all the deposit ticket files from $HOME/datafiles to $HOME/archieve_path
cp -f $file_path/$filename $archieve_path/$fname"_"$date.xml
     

TIME=`date +"%H:%M:%S"`
echo "removing the files from $file_path at ${TIME} on ${DATE}"
# Rename the file to something else for future running purpose
rm -rf $file_path/$filename
     
TIME=`date +"%H:%M:%S"`	 
echo "bye the transfer is complete at ${TIME} on ${DATE}"
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

exit 0
############################################################################
