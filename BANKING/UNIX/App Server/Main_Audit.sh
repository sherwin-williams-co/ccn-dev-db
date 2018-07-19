#!/bin/sh

##############################################################################################
# Script Name   :  MAIN_AUDIT (Control-M)
#
# Description    :  This shell program will call the Banking Back Feed File Creation Modules 
#
# This shell program will initiate the creation of the Banking Back Feed file created out ot the 
# Oracle Audit file and FTP'd to the CCN database server using the following modules:
#    
#                audit_load.sh  -->  Create the Audit Back Feed File
#                audit_ftp.sh   -->  Move and FTP the BackFeed File to the CCN DB Server
#
# Created : 09/16/2015 jxc517 CCN Project....
# Revised : 7/19/2018  kxm302 CCN Project...
#           Removed Concate Backfeed files and FTP to CCN DB Server as per audit process cleanup
#           in Banking
##############################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

DATE=`date +"%m/%d/%Y"`
TIME=`date +"%H:%M:%S"`
BACKFEED_PATH="$HOME/batchJobs/backFeed/"
cd $BACKFEED_PATH

echo "Processing Started for backfeed process at ${TIME} on ${DATE}"
############################################################################
#         execute audit_load.sh shell to create CCN Backfeed File
############################################################################
echo "Processing Started for audit_load at ${TIME} on ${DATE}"
./audit_load.sh
#############################################
#   ERROR STATUS CHECK  audit_load shell
#############################################
status=$?
if test $status -ne 0 
   then
     echo "processing FAILED for audit_load at ${TIME} on ${DATE}"
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing Finished for audit_load at ${TIME} on ${DATE}"

############################################################################
#                     END  of  PROGRAM  
############################################################################

