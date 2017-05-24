#!/bin/sh
#################################################################
# Script name   : deposit_ticket_order_files_ftp.sh
#
# Description   : Use to ftp file to STSAPDV (DEV)
#
# Created  : 08/25/2016 nxk927 CCN Project Team.....
# Modified : 08/30/2016 nxk927 CCN Project Team.....
#            sending email and archieving the missing corresponding file
# Modified : 09/14/2016 nxk927 CCN Project Team.....
#            added condition to check if the file exists
#          : 01/11/2017 gxg192 CCN Project Team.....
#            1. Added logic to check Error status after FTP process
#            2. Added logic to send email if FTP process fails
#          : 01/24/2017 gxg192 CCN Project Team.....
#            1. Changes to call check_ftp_status.sh for checking status of FTP process
#          : 05/16/2017 nxk927 CCN Project Team.....
#            Added logic to make the background process to wait until current process is complete
#          : 05/24/2017 nxk927 CCN Project Team.....
#            declaring the file name for the xml before starting the process
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="deposit_ticket_order_files_ftp"
DATE=`date +"%m/%d/%Y"`
archieve_path="$HOME/datafiles/archieve"
FTPLOG=$HOME/logs/dep_tckt_ftplogfile.log
xml_file=`$HOME/datafiles/DEPOSIT_TICKET_*.xml`

# Generating a dep_tkt_proc_hold.trigger file using the redirection command to make sure deposits_order_bp.sh background process will not kick off until one process is completed.
printf "deposit ticket Process is runnning" > dep_tkt_proc_hold.trigger

TIME=`date +"%H:%M:%S"`
echo "Process started for $proc_name at $TIME on $DATE"
for file in $xml_file
do
  file1=`basename $file`
  filename=${file1:0:21}
  file2=$filename.txt
  if [ -e $HOME/datafiles/$file2 ]
  then
     TIME=`date +"%H:%M:%S"`
     echo "FTP Process started for $proc_name at $TIME on $DATE"
ftp -inv ${mainframe_host} <<FTP_MF > $FTPLOG
quote user ${mainframe_user}
quote pass ${mainframe_pw}
cd /FTP/PrintServices/Deposits_Tickets
put $HOME/datafiles/$file1 $file1
put $HOME/datafiles/$file2 $file2
bye
END_SCRIPT
FTP_MF

     ############################################################################
     #                           ERROR STATUS CHECK
     ############################################################################
     TIME=`date +"%H:%M:%S"`
     ./check_ftp_status.sh $FTPLOG
     status=$?
     if test $status -ne 0
     then
        echo "The transfer of $filename to mainframe FAILED at ${TIME} on ${DATE}"
        ./dpst_tkt_send_mail.sh 'DEPOSIT_TCKT_FTP_FAILED' $filename

        status=$?
        TIME=`date +"%H:%M:%S"`
        if test $status -ne 0
        then
           echo "Sending email for $CC for $filename FAILED at $TIME on $DATE"
        fi
     else
        echo "The transfer of $filename completed successfully at ${TIME} on ${DATE}"
        echo "Archieving Process started for $proc_name at $TIME on $DATE"
        dt=$(date +%Y%m%d%H%M%S)
        mv $HOME/datafiles/$file1 $archieve_path/${filename}_${dt}.xml
        mv $HOME/datafiles/$file2 $archieve_path/${filename}_${dt}.txt
        TIME=`date +"%H:%M:%S"`
        echo "Archieving Process finished for $proc_name at $TIME on $DATE"
     fi

  else
     CC=${file:15:6}
     echo "Corresponding deposit ticket file for cost center $CC not found for processing"
     TIME=`date +"%H:%M:%S"`
     echo "Sending email for $CC for corresponding file check at $TIME on $DATE"
     ./dpst_tkt_send_mail.sh 'DEPOSIT_TICKET_FILE' $filename

     status=$?
     TIME=`date +"%H:%M:%S"`
     if test $status -ne 0
     then
        echo "Sending email for $CC for $filename FAILED at $TIME on $DATE"
     fi

     echo "Sending email Process finished at $TIME on $DATE"
  fi
done


TIME=`date +"%H:%M:%S"`
echo "Removing the trigger file at $TIME on $DATE"
rm -f dep_tkt_proc_hold.trigger

TIME=`date +"%H:%M:%S"`
echo "Process completed for $proc_name at $TIME on $DATE"

exit 0
