#!/bin/sh

##############################################################################################
# Script Name   :  MAIN_AUDIT (Control-M)
#
# Description    :  This shell program will call the CCN Back Feed File Creation Modules 
#
# This shell program will initiate the creation of the CCN Back Feed file created out ot the 
# Oracle Audit file and FTP'd to the mainframe using the following modules:
#    
#                audit_load.sh  -->  Create the Audit Back Feed File
#
## Created          :  MDH 11/19/2012
# Revised           :  SH  06/20/2013
#                   :  sxh487 09/16/2015 Added the concatenation for CCN and Banking backfeed 
#                   :  sxh487 09/17/2015 Moved the audit_ftp.sh outside this script
##############################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
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

##############################################################################
#  Execute Backfeed_CAT.sh to Concatenate all the files in order to send to MF
##############################################################################
echo "Concatenating Started at ${TIME} on ${DATE}"
./Backfeed_CAT.sh
##############################################
#    ERROR STATUS CHECK Backfeed_CAT.sh 
##############################################
status=$?
if test $status -ne 0
   then
     echo "processing FAILED for Backfeed_CAT at ${TIME} on ${DATE}"
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing Finished for Backfeed_CAT at ${TIME} on ${DATE}"

############################################################################
#   execute incomplete_cc.sh shell to send Incomplete cost centers to specified people
############################################################################
echo "Processing Started for incomplete_cc at ${TIME} on ${DATE}"
./incomplete_cc.sh

##############################################
#    ERROR STATUS CHECK incomplete_cc shell
##############################################
status=$?
if test $status -ne 0
   then
     echo "processing FAILED for incomplete_cc at ${TIME} on ${DATE}"
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing Finished for incomplete_cc at ${TIME} on ${DATE}"
echo "Processing finished for backfeed process at ${TIME} on ${DATE}" 

exit 0
############################################################################
#                     END  of  PROGRAM  
############################################################################
