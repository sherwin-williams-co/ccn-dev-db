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
#                audit_ftp.sh   -->  Move and FTP the BackFeed File to the Mainframe
#
# Created           :  MDH 11/19/2012
# Revised           :  SH  06/20/2013
##############################################################################################
. /app/ccn/ccn.config

 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 BACKFEED_PATH="/app/ccn/batchJobs/backFeed/"
 cd $BACKFEED_PATH

echo "\n Processing Started for backfeed process at ${TIME} on ${DATE}"
############################################################################
#         execute audit_load.sh shell to create CCN Backfeed File
############################################################################
echo "\n Processing Started for audit_load at ${TIME} on ${DATE}"
./audit_load_hierarchy.sh


#############################################
#   ERROR STATUS CHECK  audit_load shell
#############################################
status=$?
if test $status -ne 0 
   then
     echo "\n processing FAILED for audit_load at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "\n Processing Finished for audit_load at ${TIME} on ${DATE}"

##############################################################################
#  Execute Backfeed_CAT.sh to Concatenate all the files in order to send to MF
##############################################################################
echo "\n Concatenating Started at ${TIME} on ${DATE}"
./Backfeed_CAT.sh

echo "\n Processing Finished for Backfeed_CAT at ${TIME} on ${DATE}"


##############################################
#    ERROR STATUS CHECK Backfeed_CAT.sh 
##############################################
status=$?
if test $status -ne 0
   then
     echo "\n processing FAILED for Backfeed_CAT at ${TIME} on ${DATE}"
     exit 1;
fi

############################################################################
#   execute audit_ftp.sh shell to send CCN Backfeed File to Mainframe
############################################################################
echo "\n Processing Started for audit_ftp at ${TIME} on ${DATE}"
#./audit_ftp.sh

##############################################
#    ERROR STATUS CHECK audit_ftp shell
##############################################
status=$?
if test $status -ne 0
   then
     echo "\n processing FAILED for audit_ftp at ${TIME} on ${DATE}"
     exit 1;
fi

echo "\n Processing Finished for audit_ftp at ${TIME} on ${DATE}"
echo "\n Processing finished for backfeed process at ${TIME} on ${DATE}"  

############################################################################
#   execute incomplete_cc.sh shell to send Incomplete cost centers to specified people
############################################################################
echo "\n Processing Started for incomplete_cc at ${TIME} on ${DATE}"
./incomplete_cc.sh

##############################################
#    ERROR STATUS CHECK incomplete_cc shell
##############################################
status=$?
if test $status -ne 0
   then
     echo "\n processing FAILED for audit_ftp at ${TIME} on ${DATE}"
     exit 1;
fi

echo "\n Processing Finished for audit_ftp at ${TIME} on ${DATE}"
echo "\n Processing finished for backfeed process at ${TIME} on ${DATE}"  

exit 0

############################################################################
#                     END  of  PROGRAM  
############################################################################

