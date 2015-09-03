#!/bin/sh
######################################################################################
# Script Name     :  price_district_ftp.sh
# Description     :  Use to ftp PRICING_DISTRICT_FILE file to mainframe 
#
# Created    Date : nxk927 08/31/2015 
#######################################################################################

# Get the credentials for all applications from below file
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.csh

date=`date +"%Y%m%d%H%M%S"`


# Move to datafiles from where ever you are in
cd $HOME/datafiles/

# ftp to mainframe 'SMIS1.ORACLE.PRC06260(+1)' 
ftp -inv ${mainframe_host} <<FTP_MF
quote user ${mainframe_user}
quote pass ${mainframe_pw}
quote SITE RECFM=FB,LRECL=100,BLKSIZE=27900,SPACE=(600,60),VOL(GDG354) TRACKS
put PRICE_DISTRICT_FILE 'SMIS1.ORACLE.PRC06260(+1)'
bye
END_SCRIPT
echo "bye the transfer is complete"
FTP_MF


##############################################
#    ERROR STATUS CHECK FTP the CCN_GEMS_LOAD.TRG file
##############################################
 TIME=`date +"%H:%M:%S"`
status=$?
if test $status -ne 0
   then
     echo "processing FAILED to FTP  PRICE_DISTRICT_FILE at ${TIME} on ${DATE}"
     exit 1;
else
    echo "Processing Finished to FTP PRICE_DISTRICT_FILE at ${TIME} on ${DATE}"
fi
exit 0