#!/bin/sh
#################################################################
# Script name   : deposit_ticket_order_files_ftp.sh
#
# Description   : Use to ftp file to STSAPDV (DEV)
#
# Created  : 08/25/2016 nxk927 CCN Project Team.....
# Modified : 08/30/2016 nxk927 CCN Project Team.....
#            sending email and archieving the missing corresponding file
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
cd $file_path
for file in DEPOSIT_TICKET_*.xml
do
  f1=${file:0:21}
  file1=$f1.txt
  if [ -e $file1 ]
  then
TIME=`date +"%H:%M:%S"`
echo "FTP Process started for $proc_name at $TIME on $DATE"
ftp -inv ${mainframe_host} <<FTP_MF
quote user ${mainframe_user}
quote pass ${mainframe_pw}
cd /FTP/PrintServices/Deposits_Tickets
mput $f1.*
bye
END_SCRIPT
echo "bye the transfer is complete"
FTP_MF
TIME=`date +"%H:%M:%S"`
echo "bye the transfer is complete at ${TIME} on ${DATE}"

TIME=`date +"%H:%M:%S"`
echo "Archieving Process started for $proc_name at $TIME on $DATE"
dt=$(date +%Y%m%d%H%M%S)
mv $file $archieve_path/${f1}_${dt}.xml
dt=$(date +%Y%m%d%H%M%S)
mv $file1 $archieve_path/${f1}_${dt}.txt
TIME=`date +"%H:%M:%S"`
echo "Archieving Process finished for $proc_name at $TIME on $DATE"
else
CC=${file:15:6}
echo "Corresponding deposit ticket file for cost center $CC not found for processing"
TIME=`date +"%H:%M:%S"`
echo "Sending email for $CC for corresponding file check at $TIME on $DATE"
sh $HOME/dpst_tkt_send_mail.sh $f1
TIME=`date +"%H:%M:%S"`
echo "Sending email Process finished at $TIME on $DATE"
fi
done
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
echo "Process completed for $proc_name at $TIME on $DATE"

cd $HOME

exit 0
