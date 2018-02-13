#!/bin/sh
###############################################################################
#ccn_ftp_report_trigger.sh
#This script will ftp the status of the completion of reports
#created : 02/08/2018 nxk927
################################################################################
. /app/ccn/ccn_app_server.config

DATE=`date +"%Y%m%d"`
file_name='TRIGGER.FINSYS'
TIME=`date +"%H:%M:%S"`

if [ "$FTP_INDICATOR" == "Y" ]
then
# Generating a TRIGGER.FINSYS file using the redirection command.
echo " " > $file_name

echo $file_name

echo "FTP process starting at $TIME on $DATE\n"

# ftp to mainframe
ftpResult=`ftp -n ${rpt_host} <<FTP_MF
quote USER ${rpt_user}
quote PASS ${rpt_pw}
cd ${rpt_path}
put $file_name
bye
FTP_MF`
echo "End of FTP"

TIME=`date +"%H:%M:%S"`
printf "\nRemoving $file_name from App Server at $TIME on $DATE\n"
rm -f $file_name

else
  echo " FTP for $file_name is ignored in lower enviornments"
fi

exit 0

