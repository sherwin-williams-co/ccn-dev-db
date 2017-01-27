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
###########################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="deposit_bag_order_files_ftp"
DATE=`date +"%m/%d/%Y"`
archieve_path="$HOME/datafiles/archieve"
ftp_failed_files_path="$HOME/datafiles/ftp_failed_files"
file_path="$HOME/datafiles"
FTPLOG=$HOME/logs/dep_bag_ftplogfile.log

TIME=`date +"%H:%M:%S"`
echo "Process started for $proc_name at $TIME on $DATE"

#move to the datafiles folder
cd $HOME/datafiles

for file in DEPOSIT_BAG_*.xml
do
if [ -e DEPOSIT_BAG_*.xml ]
then
ftp -inv ${mainframe_host} <<FTP_MF > $FTPLOG
quote user ${mainframe_user}
quote pass ${mainframe_pw}
cd /FTP/PrintServices/Deposit_Bags
put $file
bye
END_SCRIPT
FTP_MF

############################################################################
#                           ERROR STATUS CHECK
############################################################################
TIME=`date +"%H:%M:%S"`
sh $HOME/check_ftp_status.sh $FTPLOG

status=$?
if test $status -ne 0
then
   echo "The transfer of $file FAILED at ${TIME} on ${DATE}"
   sh $HOME/dpst_bag_send_mail.sh 'DEPOSIT_BAG_FTP_FAILED' $file

   status=$?
   TIME=`date +"%H:%M:%S"`
   if test $status -ne 0
   then
      echo "Sending email for $CC for $file FAILED at $TIME on $DATE"
   fi

   f1=${file:0:18}
   dt=$(date +%Y%m%d%H%M%S)
   mv $file $ftp_failed_files_path/${f1}_${dt}.xml
   TIME=`date +"%H:%M:%S"`
   echo "File $file moved to ftp_failed_files folder at $TIME on $DATE"
else
   echo "The transfer of $file completed successfully at ${TIME} on ${DATE}"
   f1=${file:0:18}
   dt=$(date +%Y%m%d%H%M%S)
   mv $file $archieve_path/${f1}_${dt}.xml
   TIME=`date +"%H:%M:%S"`
   echo "File $file Archieved successfully at $TIME on $DATE"
fi
fi
done

TIME=`date +"%H:%M:%S"`
echo "Process completed for $proc_name at $TIME on $DATE"

cd $HOME

exit 0
