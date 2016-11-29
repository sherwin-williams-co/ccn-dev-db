# Script Name : ftp_royal_bank_rpt_trg.sh
# Description : This Shell Script is creared to generate the royal_bank.trg file that
#               gets ftp'd to app server.
# Created     : gxg192 Royal Bank Report Project
# Changed     :
######################################################################################
# below command will get the path for respective to the environment from which it runs from.

. /app/stordrft/host.sh

File="RUN_ROYAL_BANK_REPORT.TRG"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

cd $HOME/Reports
echo -n "RUN" > $File

printf " Starting FTP Process for RUN_ROYAL_BANK_REPORT.TRG to App server on $DATE at $TIME \n"

# ftp to application server
ftp -n ${appserver_host} <<END_SCRIPT
quote USER ${appserver_user}
quote PASS ${appserver_pw}
cd /app/strdrft/sdReport/reports/
put $File $File
quit
END_SCRIPT

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $File at $TIME on $DATE"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished successfully for $File at ${TIME} on ${DATE}"

exit 0

#############################################################
# END of PROGRAM.
#############################################################