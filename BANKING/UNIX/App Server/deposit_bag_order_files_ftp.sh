#!/bin/sh
#################################################################
# Script name   : deposit_bag_order_files_ftp.sh
#
# Description   : Use to ftp file to STSAPDV (DEV)
#
# Created  : 08/25/2016 nxk927 CCN Project Team.....
# Modified : 
#################################################################
# below command will get the path for banking.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

proc_name="deposit_bag_order_files_ftp"
DATE=`date +"%m/%d/%Y"`
archieve_path="$HOME/datafiles/archieve"
file_path="$HOME/datafiles"

TIME=`date +"%H:%M:%S"`
echo "Process started for $proc_name at $TIME on $DATE"

#move to the datafiles folder
cd $HOME/datafiles

for file in DEPOSIT_BAG_*.xml
do
if [ -e DEPOSIT_BAG_*.xml ]
then
ftp -inv ${mainframe_host} <<FTP_MF
quote user ${mainframe_user}
quote pass ${mainframe_pw}
cd /FTP/PrintServices/Deposit_Bags
put $file
bye
END_SCRIPT
FTP_MF

TIME=`date +"%H:%M:%S"`
echo "bye the transfer is complete at ${TIME} on ${DATE}"

f1=${file:0:18}
dt=$(date +%Y%m%d%H%M%S)
mv $file $archieve_path/${f1}_${dt}.xml
fi
done

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Process started for $proc_name at $TIME on $DATE"

cd $HOME

exit 0
