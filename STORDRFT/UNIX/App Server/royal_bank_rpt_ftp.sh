#! /bin/sh
#######################################################################################
# Script Name : royal_bank_rpt_ftp.sh
# Description : This Shell Script FTP the Royal_Bank_Report.txt to Mainframe.
# Created     : nxk927 02/09/2018 CCN Project
# Changed     :
######################################################################################
# below command will get the path for respective to the environment from which it runs from.

. /app/strdrft/dataloadInfo.txt

if [ "$ftp_ind" == "Y" ]
then
cd /app/strdrft/sdReport/reports

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

printf " Starting FTP Process for Royal_Bank_Report.txt to mainframe server on $DATE at $TIME \n"

echo " FTP Process Started "
ftp -n ${mainframe_host} <<END_SCRIPT
quote USER ${mainframe_user}
quote PASS ${mainframe_pw}
cd ${mainframe_path}
put Royal_Bank_Report.txt
quit
END_SCRIPT

printf " End FTPing Royal_Bank_Report.txt file: Process Successful : Process finished at $TIME on $DATE \n"
cd /app/strdrft/sdReport/scripts
else
  echo " FTP is ignored in lower enviornments"
  fi
exit 0

#############################################################
# END of PROGRAM.
#############################################################