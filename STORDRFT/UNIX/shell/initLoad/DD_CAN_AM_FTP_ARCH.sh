#!/bin/sh
#################################################################
# Script name   : DD_CAN_AM_FTP_ARCH.sh
#
# Description   : Use to ftp to B2BizLink to be loaded to Mobius manframe
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="DD_CAN_AM_FTP_ARCH"
ARCHIVE=$HOME/dailyLoad/archieve/Daily_bank
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

date=`date +"%Y%m%d%H%M%S"`

# Move to datafiles from where ever you are in
cd $HOME/initLoad

#ftp to B2BizLink to thier respective production name
#ftp -inv ${B2BizLink_host} <<FTP_MF
#quote user ${B2BizLink_user}
#quote pass ${B2BizLink_pw}
#cd /BizLink/Application/CPRPP/RcvFromApp
#put DLY_DRAFT_CAN_AM DLY_DRAFT_CAN_AM
#bye
#END_SCRIPT
#echo "bye the transfer is complete"
#FTP_MF

#Archieve the bank files
mv "DLY_DRAFT_CAN_AM" $ARCHIVE/DLY_DRAFT_CAN_AM"_"$date
echo "DLY_DRAFT_CAN_AM has been archieved to $ARCHIVE path"

#Move back to invoking folder, to continue the rest of the process
cd $HOME/dailyLoad

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################

