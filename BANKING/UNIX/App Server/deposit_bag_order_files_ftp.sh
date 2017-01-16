#!/bin/sh
###########################################################################
# Script name   : deposit_bag_order_files_ftp.sh
#
# Description   : Use to ftp file to STSAPDV (DEV)
#
# Created  : 08/25/2016 nxk927 CCN Project Team.....
# Modified : 01/11/2017 gxg192 CCN Project Team.....
#            Added logic to check Error status after FTP process
###########################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="deposit_bag_order_files_ftp"
DATE=`date +"%m/%d/%Y"`
archieve_path="$HOME/datafiles/archieve"
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
ftp -inv <<! > $FTPLOG
open ${mainframe_host}
quote user ${mainframe_user}
quote pass ${mainframe_pw}
cd /FTP/PrintServices/Deposit_Bags
put $file
close
quit
!

############################################################################
#                           ERROR STATUS CHECK
############################################################################
TIME=`date +"%H:%M:%S"`
FTP_SUCCESS_MSG="226 Transfer complete"
if fgrep "$FTP_SUCCESS_MSG" $FTPLOG ;then
   echo "The transfer of $f1 completed successfully at ${TIME} on ${DATE}"
else
   echo "The transfer of $f1 to mainframe FAILED at ${TIME} on ${DATE}"
fi

f1=${file:0:18}
dt=$(date +%Y%m%d%H%M%S)
mv $file $archieve_path/${f1}_${dt}.xml
fi
done

TIME=`date +"%H:%M:%S"`
echo "Process completed for $proc_name at $TIME on $DATE"

cd $HOME

exit 0
