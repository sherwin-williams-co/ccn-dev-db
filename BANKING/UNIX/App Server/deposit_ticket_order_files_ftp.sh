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
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="deposit_ticket_order_files_ftp"
DATE=`date +"%m/%d/%Y"`
archieve_path="$HOME/datafiles/archieve"
file_path="$HOME/datafiles"
FTPLOG=$HOME/logs/dep_tckt_ftplogfile.log

TIME=`date +"%H:%M:%S"`
echo "Process started for $proc_name at $TIME on $DATE"
#move to the datafiles folder
cd $file_path
xml_files=`ls DEPOSIT_TICKET*.xml`
for file in $xml_files
do
  f1=${file:0:21}
  file1=$f1.txt
  if [ -e $file1 ]
  then
     TIME=`date +"%H:%M:%S"`
     echo "FTP Process started for $proc_name at $TIME on $DATE"

ftp -inv <<! > $FTPLOG
open ${mainframe_host}
quote user ${mainframe_user}
quote pass ${mainframe_pw}
cd /FTP/PrintServices/Deposits_Tickets
mput $f1.*
close
quit
!

     TIME=`date +"%H:%M:%S"`
     FTP_SUCCESS_MSG="226 Transfer complete"

     if fgrep "$FTP_SUCCESS_MSG" $FTPLOG ;
     then
        echo "The transfer of $f1 completed successfully at ${TIME} on ${DATE}"
        echo "Archieving Process started for $proc_name at $TIME on $DATE"
        dt=$(date +%Y%m%d%H%M%S)
        mv $file $archieve_path/${f1}_${dt}.xml
        dt=$(date +%Y%m%d%H%M%S)
        mv $file1 $archieve_path/${f1}_${dt}.txt
        TIME=`date +"%H:%M:%S"`
        echo "Archieving Process finished for $proc_name at $TIME on $DATE"
     else
        echo "The transfer of $f1 to mainframe FAILED at ${TIME} on ${DATE}"
        sh $HOME/dpst_tkt_send_mail.sh 'DEPOSIT_TCKT_FTP_FAILED' $f1

        status=$?
        TIME=`date +"%H:%M:%S"`
        if test $status -ne 0
        then
           echo "Sending email for $CC for $f1 FAILED at $TIME on $DATE"
        fi
     fi

  else
     CC=${file:15:6}
     echo "Corresponding deposit ticket file for cost center $CC not found for processing"
     TIME=`date +"%H:%M:%S"`
     echo "Sending email for $CC for corresponding file check at $TIME on $DATE"
     sh $HOME/dpst_tkt_send_mail.sh 'DEPOSIT_TICKET_FILE' $f1

     status=$?
     TIME=`date +"%H:%M:%S"`
     if test $status -ne 0
     then
        echo "Sending email for $CC for $f1 FAILED at $TIME on $DATE"
     fi

     echo "Sending email Process finished at $TIME on $DATE"
  fi
done

TIME=`date +"%H:%M:%S"`
echo "Process completed for $proc_name at $TIME on $DATE"

cd $HOME

exit 0
