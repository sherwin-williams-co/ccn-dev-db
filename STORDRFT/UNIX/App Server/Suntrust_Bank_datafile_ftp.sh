#! /bin/sh
#######################################################################################
# Script Name : Suntrust_Bank_datafile_ftp.sh
# Description : This Shell Script ftps the FBX275A.* to DB server.
# Created     : 03/23/2018 nxk927 CCN Project
# Modified    : 
######################################################################################
# below command will get the path for respective to the environment from which it runs from.
. /app/strdrft/storedraft.config

INITLOAD_PATH="/app/stordrft/dev/initLoad"
ARCHIVE_PATH="/app/strdrft/sdReport/data/Archive/"
SCRIPT_PATH="/app/strdrft/sdReport/scripts/"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TIMESTAMP="D`date +"%y%m%d"`_T`date +"%H%M%S"`"
FTPLOG=/app/strdrft/sdReport/logs/Suntrust_Bank_datafile_ftp.log

printf " Starting FTP Process for DAREPORT file to DB server on $DATE at $TIME \n"
cd $APP_USR_PATH
echo " FTP Process Started "
ftp -inv ${dbserver_host} <<END_SCRIPT > $FTPLOG
quote USER ${dbserver_user}
quote PASS ${dbserver_pw}
binary
cd $INITLOAD_PATH
put FBX275A.* STBD0101_PAID_$TIMESTAMP.TXT
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

printf "Moving $APP_USR_PATH/FBX275A.* file to Archive folder at $TIME on $DATE \n"
mv -f $APP_USR_PATH/FBX275A.* $ARCHIVE_PATH
if test $status -ne 0
then
   TIME=`date +"%H:%M:%S"`
   echo "The transfer of $APP_USR_PATH/FBX275A.* FAILED at ${TIME} on ${DATE}"
   exit 1
else
   echo "The transfer of $APP_USR_PATH/FBX275A.* completed successfully at ${TIME} on ${DATE}"
fi

printf "FTPing finished for FBX275A.* file to the DB server at $TIME on $DATE \n"
exit 0
############################################################################
# END of PROGRAM.
############################################################################