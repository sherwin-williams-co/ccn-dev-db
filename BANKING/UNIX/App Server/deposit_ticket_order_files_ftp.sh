#!/bin/sh
#################################################################
# Script name   : deposit_ticket_order_files_ftp.sh
#
# Description   : Use to ftp file to STSAPDV (DEV)
#
# Created  : 06/09/2016 jxc517 CCN Project Team.....
# Modified : 
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="deposit_ticket_order_files_ftp"
DATE=`date +"%m/%d/%Y"`
archieve_path="$HOME/datafiles/archieve"
file_path="$HOME/datafiles"

TIME=`date +"%H:%M:%S"`
echo "Process started for $proc_name at $TIME on $DATE"

#move to the datafiles folder
cd $HOME/datafiles

file_name=DEPOSIT_TICKET_*.txt
fname=$(echo $file_name | cut -f 1 -d '.')
TIME=`date +"%H:%M:%S"`

ftp -inv ${mainframe_host} <<FTP_MF
quote user ${mainframe_user}
quote pass ${mainframe_pw}
cd /FTP/PrintServices/Deposits_Tickets
mput $fname.txt
mput $fname.xml
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

TIME=`date +"%H:%M:%S"`
echo "copying files from $file_path to $archieve_path at ${TIME} on ${DATE}"

date=`date +"%m%d%Y%H%M%S"`
# Copy all the deposit ticket files from $HOME/datafiles to $HOME/archieve_path
cp -f $file_path/$fname.txt $archieve_path/$fname"_"$date.txt
cp -f $file_path/$fname.xml $archieve_path/$fname"_"$date.xml
     
TIME=`date +"%H:%M:%S"` 
echo "removing the files from $file_path at ${TIME} on ${DATE}"  
rm -f $file_path/$fname.txt
rm -f $file_path/$fname.xml
 
TIME=`date +"%H:%M:%S"` 
echo "bye the transfer is complete at ${TIME} on ${DATE}"

cd $HOME

exit 0
