#!/bin/sh

#############################################################################
# Script Name   :  MAIN_AUDIT (Control-M)
#
# Description    :  This shell program will call the CCN Back Feed File Creation Modules 
#
# This shell program will initiate the creation of the CCN Back Feed file created out ot the 
# Oracle Audit file and FTP'd to the mainframe using the following modules:
#    
#                audit_load.sh  -->  Create the Audit Back Feed File
#                audit_ftp.sh     -->  Move and FTP the BackFeed File to the Mainframe
#
# Created           :  MDH 11/19/2012
# Revised           :
############################################################################
. /app/ccn/ccn.config

# proc="initLoad"
# TimeStamp=`date '+%Y/%m/%d%H%M%S'`
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
echo "\n Processing Started for backfeed process at ${TIME} on ${DATE}"

############################################################################
#              execute audit_load.sh shell to create CCN Backfeed File
############################################################################
echo "\n Processing Started for audit_load at ${TIME} on ${DATE}"
/app/ccn/batchJobs/backFeed/audit_load.sh


#############################################
#             ERROR STATUS CHECK  audit_load shell
#############################################
status=$?
if test $status -ne 0 
   then
     TIME=`date +"%H:%M:%S"`
     echo "\n processing FAILED for audit_load at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "\n Processing Finished for audit_load at ${TIME} on ${DATE}"

############################################################################
# execute audit_ftp.sh shell to send CCN Backfeed File to Mainframe
############################################################################
echo "\n Processing Started for audit_ftp at ${TIME} on ${DATE}"
/app/ccn/batchJobs/backFeed/audit_ftp.sh

##############################################
#             ERROR STATUS CHECK  audit_ftp shell
##############################################
status=$?
if test $status -ne 0
   then
     TIME=`date +"%H:%M:%S"`
     echo "\n processing FAILED for audit_ftp at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "\n Processing Finished for audit_ftp at ${TIME} on ${DATE}"
echo "\n Processing finished for backfeed process at ${TIME} on ${DATE}"  

exit 0

############################################################################
#                                                  END  of  PROGRAM  
############################################################################

