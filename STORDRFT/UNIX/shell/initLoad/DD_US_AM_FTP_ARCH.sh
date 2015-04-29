#!/bin/sh
#################################################################
# Script name   : DD_US_AM_FTP_ARCH.sh
#
# Description   :  Use to ftp to B2BizLink to be loaded to Mobius manframe
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value to pick the date value from config file
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="DD_US_AM_FTP_ARCH"
ARCHIVE=$HOME/dailyLoad/archieve/Daily_bank
TIME=`date +"%H:%M:%S"`
CURRENT_TIME=`date +"%H%M%S"`
P1=${DAILY_LOAD_RUNDATE}
TimeStamp=`date -d $P1 +"%Y%m%d"`$CURRENT_TIME 

echo "Processing Started for $proc_name at $TIME for the date $P1"

# Move to datafiles from where ever you are in
cd $HOME/initLoad

#ftp to B2BizLink to thier respective production name
ftp -inv ${B2BizLink_host} <<FTP_MF
quote user ${B2BizLink_user}
quote pass ${B2BizLink_pw}
cd /BizLink/Application/CPRPP/RcvFromApp
put DLY_DRAFT_US_AM CPRPP_0275.AUTO_USA_ISSUE.txt
bye
END_SCRIPT
echo "bye the transfer is complete"
FTP_MF

#Archieve the bank files
mv "DLY_DRAFT_US_AM" $ARCHIVE/DLY_DRAFT_US_AM"_"$TimeStamp
echo "DLY_DRAFT_US_AM has been archieved to $ARCHIVE path"

#Move back to invoking folder, to continue the rest of the process
cd $HOME/dailyLoad

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
P1=${DAILY_LOAD_RUNDATE}
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} for the date ${P1}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} for the date ${P1}"  

exit 0
############################################################################
