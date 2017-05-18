#!/bin/sh
###########################################################################
# Script name   : deposit_bag_order_files_ftp.sh
#
# Description   : Use to ftp file to STSAPDV (DEV)
#
# Created  : 08/25/2016 nxk927 CCN Project Team.....
# Modified : 01/11/2017 gxg192 CCN Project Team.....
#            Added logic to check Error status after FTP process
#          : 01/24/2017 gxg192 CCN Project Team.....
#            1. Changes to call check_ftp_status.sh to check status of FTP process
#            2. Changes to move the file to ftp_failed_files folder if FTP fails
#            3. Changes to send email if FTP process fails
#          : 05/17/2017 nxk927 CCN Project Team.....
#            Added logic to make the background process to wait until current process is complete
###########################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="deposit_bag_order_files_ftp"
DATE=`date +"%m/%d/%Y"`
archieve_path="$HOME/datafiles/archieve"
ftp_failed_files_path="$HOME/datafiles/ftp_failed_files"
FTPLOG=$HOME/logs/dep_bag_ftplogfile.log

# Generating a dep_tkt_proc_hold.trigger file using the redirection command to make sure deposits_order_bp.sh background process will not kick off until one process is completed.
printf "deposit bag Process is runnning" > dep_tkt_proc_hold.trigger

TIME=`date +"%H:%M:%S"`
echo "Process started for $proc_name at $TIME on $DATE"

for file in $HOME/datafiles/DEPOSIT_BAG_*.xml
do
if [ -e $file ]
then
filename=`basename $file`
ftp -inv ${mainframe_host} <<FTP_MF > $FTPLOG
quote user ${mainframe_user}
quote pass ${mainframe_pw}
##cd /FTP/PrintServices/Deposit_Bags
put $file $filename
bye
END_SCRIPT
FTP_MF

############################################################################
#                           ERROR STATUS CHECK
############################################################################
TIME=`date +"%H:%M:%S"`
./check_ftp_status.sh $FTPLOG

status=$?
f1=${filename:0:18}
dt=$(date +%Y%m%d%H%M%S)
TIME=`date +"%H:%M:%S"`

if test $status -ne 0
then
   echo "The transfer of $filename FAILED at ${TIME} on ${DATE}"
   ./dpst_bag_send_mail.sh 'DEPOSIT_BAG_FTP_FAILED' $filename

   status=$?
   TIME=`date +"%H:%M:%S"`
   if test $status -ne 0
   then
      echo "Sending email for $CC for $filename FAILED at $TIME on $DATE"
   fi

   mv $file $ftp_failed_files_path/${f1}_${dt}.xml
   TIME=`date +"%H:%M:%S"`
   echo "File $filename moved to ftp_failed_files folder at $TIME on $DATE"
else
   echo "The transfer of $filename completed successfully at ${TIME} on ${DATE}"
   mv $file $archieve_path/${f1}_${dt}.xml
   echo "File $file Archieved successfully at $TIME on $DATE"
fi
fi
done

TIME=`date +"%H:%M:%S"`
echo "Removing the trigger file at $TIME on $DATE"
rm -f dep_tkt_proc_hold.trigger

TIME=`date +"%H:%M:%S"`
echo "Process completed for $proc_name at $TIME on $DATE"

exit 0
