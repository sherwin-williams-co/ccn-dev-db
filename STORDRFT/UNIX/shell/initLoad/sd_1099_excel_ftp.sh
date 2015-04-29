#!/bin/sh
#################################################################
# Script name   : sd_1099_excel_ftp.sh
#
# Description   : Use to ftp to mainframe to be loaded to Mobius manframe
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="sd_1099_excel_ftp"
ARCHIVE=$HOME/dailyLoad/archieve/1099_excel
TIME=`date +"%H:%M:%S"`
CURRENT_TIME=`date +"%H%M%S"`
P1=${QTLY_1099_RUNDATE}
TimeStamp=`date -d $P1 +"%Y%m%d"`$CURRENT_TIME 

echo "Processing Started for $proc_name at $TIME for the date $P1"

#Move to STORDRFT from where ever you are in
cd $HOME/initLoad

# ftp to mainframe to thier respective production name
#ftp -inv ${mainframe_host} <<FTP_MF
#quote user ${mainframe_user}
#quote pass ${mainframe_pw}

##quote SITE RECFM=FB,LRECL=100,BLKSIZE=27900,SPACE=(600,60),VOL(GDG350) TRACKS
#put Installer_1099_QRTLY  'SMIS1.STBD4060.ACCOUNT.EXCEL'
#bye
#END_SCRIPT
#echo "bye the transfer is complete"
#FTP_MF

#Archieve the bank files
mv "Installer_1099_QRTLY" $ARCHIVE/Installer_1099_QRTLY"_"$TimeStamp
echo "Installer_1099_QRTLY has been archieved to $ARCHIVE path"

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
P1=${QTLY_1099_RUNDATE}
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} for the date ${P1}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} for the date ${P1}"  

exit 0
############################################################################
