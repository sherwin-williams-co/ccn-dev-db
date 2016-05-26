#!/bin/sh
##############################################################################################
# Script Name :  SWC_HR_GEMS_load_ftp.sh
#
# Description :  This shell script will call the SWC_HR_GEMS_load.csh and SWC_HR_GEMS_ftp.sh.
#                SWC_HR_GEMS_load.csh -->  Executing procedure SWC_HR_GENERIC_VIEW 
#                SWC_HR_GEMS_ftp.sh   -->  FTP CCN_GEMS_LOAD.TRG file to Field Pay Roll DB Server.
#
# Created     :  DXV848 07/20/2015
# modified    :  nxk927 05/26/2016 Moved the time variable inside the error check
##############################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

exec &> SWC_HR_GEMS_load_ftp.log

 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`

echo "Processing Started for SWC_HR_GEMS_load_ftp.csh at ${TIME} on ${DATE}"

echo -e "\nProcessing Started for SWC_HR_GEMS_load at ${TIME} on ${DATE}"
./SWC_HR_GEMS_load.csh

##############################################
#    ERROR STATUS CHECK SWC_HR_GEMS_ftp.sh 
##############################################
status=$?
if test $status -ne 0
   then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for SWC_HR_GEMS_load at ${TIME} on ${DATE}"
     exit 1;
else
    TIME=`date +"%H:%M:%S"`
    echo "Processing Finished for SWC_HR_GEMS_load at ${TIME} on ${DATE}"
fi


echo -e "\nProcessing Started for SWC_HR_GEMS_ftp at ${TIME} on ${DATE}"
./SWC_HR_GEMS_ftp.sh

##############################################
#    ERROR STATUS CHECK SWC_HR_GEMS_ftp.sh 
##############################################
status=$?
if test $status -ne 0
   then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for SWC_HR_GEMS_ftp at ${TIME} on ${DATE}"
     exit 1;
else
    TIME=`date +"%H:%M:%S"`
    echo "Processing Finished for SWC_HR_GEMS_ftp at ${TIME} on ${DATE}"
fi

echo -e "\nProcessing Finished for SWC_HR_GEMS_load_ftp.csh at ${TIME} on ${DATE}"

exit 0

############################################################################
#                     END  of  PROGRAM  
############################################################################

