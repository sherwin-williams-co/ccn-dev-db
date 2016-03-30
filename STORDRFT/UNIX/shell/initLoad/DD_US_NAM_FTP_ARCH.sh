#!/bin/sh
#################################################################
# Script name   : DD_US_NAM_FTP_ARCH.sh
#
# Description   : 
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified : 04/27/2015 axk326 CCN Project Team.....
#            Substituted hard coded date value with the date value from date_param.config file
#          : 03/18/2016 nxk927 CCN Project Team.....
#            Changed the order of declaring variables after capturing the STATUS to avoid the scenario where
#            the ERROR CODE that needs to be captured, will not be overwritten in the ERROR STATUS CHECK block
#            ADDED the error check for the ftp and removed the error check at the end
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="DD_US_NAM_FTP_ARCH"
ARCHIVE=$HOME/dailyLoad/archieve/Daily_bank
TIME=`date +"%H:%M:%S"`
DATE=${DAILY_LOAD_RUNDATE}
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc_name at $TIME on $DATE"

#Move to datafiles from where ever you are in
cd $HOME/initLoad

# ftp to B2BizLink to thier respective production name
ftp -inv ${B2BizLink_host} <<FTP_MF
quote user ${B2BizLink_user}
quote pass ${B2BizLink_pw}
cd /BizLink/Application/CPRPP/RcvFromApp
put DLY_DRAFT_US_NAM CPRPP_0275.PSG_USA_ISSUE.txt
bye
END_SCRIPT
FTP_MF

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED to ftp for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi
echo "bye the transfer is complete"

#Archieve the bank files
mv "DLY_DRAFT_US_NAM" $ARCHIVE/DLY_DRAFT_US_NAM"_"$TimeStamp
echo "DLY_DRAFT_US_NAM has been archieved to $ARCHIVE path"

#Move back to invoking folder, to continue the rest of the process
cd $HOME/dailyLoad


TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
