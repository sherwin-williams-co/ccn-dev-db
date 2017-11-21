#! /bin/sh
#######################################################################################
# Script Name : Royal_Bank_datafile_ftp.sh
# Description : This Shell Script ftps the DAREPORT.txt to DB server.
# Created     : 11/20/2017 sxh487 CCN Project
######################################################################################
# below command will get the path for respective to the environment from which it runs from.
. /app/strdrft/storedraft.config

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
printf " Starting FTP Process for DAREPORT file to DB server on $DATE at $TIME \n"

cd /app/strdrft/sdReport/data
echo " FTP Process Started "
ftp -n ${dbserver_host} <<END_SCRIPT
quote USER ${dbserver_user}
quote PASS ${dbserver_pw}
cd /app/stordrft/dev/datafiles/
put DAREPORT.* DAREPORT.txt
quit
END_SCRIPT

printf "Moving DAREPORT.txt file to Archive folder at $TIME on $DATE \n"
mv /app/strdrft/sdReport/data/DAREPORT.* /app/strdrft/sdReport/data/Archive

printf "FTPing finished for DAREPORT.txt file to the DB server at $TIME on $DATE \n"
exit 0
#############################################################
# END of PROGRAM.
#############################################################