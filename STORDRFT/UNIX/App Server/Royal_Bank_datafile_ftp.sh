#! /bin/sh
#######################################################################################
# Script Name : Royal_Bank_datafile_ftp.sh
# Description : This Shell Script ftps the DAREPORT.txt to DB server.
# Created     : 11/20/2017 sxh487 CCN Project
######################################################################################
# below command will get the path for respective to the environment from which it runs from.
. /app/strdrft/storedraft.config

DATAFILES_PATH="/app/stordrft/dev/datafiles/"
ARCHIVE_PATH="/app/strdrft/sdReport/data/Archive/"
SCRIPT_PATH="/app/strdrft/sdReport/scripts/"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
FTPLOG=/app/strdrft/sdReport/logs/Royal_Bank_datafile_ftp.log

printf " Starting FTP Process for DAREPORT file to DB server on $DATE at $TIME \n"
cd $APP_USR_PATH
echo " FTP Process Started "
ftp -inv ${dbserver_host} <<END_SCRIPT > $FTPLOG
quote USER ${dbserver_user}
quote PASS ${dbserver_pw}
cd $DATAFILES_PATH
put DAREPORT.* DAREPORT.txt
quit
END_SCRIPT

############################################################################
#                           ERROR STATUS CHECK
############################################################################
TIME=`date +"%H:%M:%S"`
cd $SCRIPT_PATH
./check_ftp_status.sh $FTPLOG

status=$?
TIME=`date +"%H:%M:%S"`

printf "Moving $APP_USR_PATH/DAREPORT.* file to Archive folder at $TIME on $DATE \n"
mv $APP_USR_PATH/DAREPORT.* $ARCHIVE_PATH

if test $status -ne 0
then
   TIME=`date +"%H:%M:%S"`
   echo "The transfer of $APP_USR_PATH/DAREPORT.* FAILED at ${TIME} on ${DATE}"
   exit 1
else
   echo "The transfer of $APP_USR_PATH/DAREPORT.* completed successfully at ${TIME} on ${DATE}"
fi

printf "FTPing finished for DAREPORT.txt file to the DB server at $TIME on $DATE \n"
exit 0
############################################################################
# END of PROGRAM.
############################################################################