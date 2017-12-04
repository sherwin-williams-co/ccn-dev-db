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
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
printf " Starting FTP Process for DAREPORT file to DB server on $DATE at $TIME \n"

cd $APP_USR_PATH
echo " FTP Process Started "
ftp -n ${dbserver_host} <<END_SCRIPT
quote USER ${dbserver_user}
quote PASS ${dbserver_pw}
cd $DATAFILES_PATH
put DAREPORT.* DAREPORT.txt
quit
END_SCRIPT

printf "Moving DAREPORT.txt file to Archive folder at $TIME on $DATE \n"
mv $APP_USR_PATH/DAREPORT.* $ARCHIVE_PATH

printf "FTPing finished for DAREPORT.txt file to the DB server at $TIME on $DATE \n"
exit 0
#############################################################
# END of PROGRAM.
#############################################################