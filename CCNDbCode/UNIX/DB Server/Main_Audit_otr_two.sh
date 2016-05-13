#!/bin/sh

####################################################################################################################################
# Script Name    :  MAIN_AUDIT_OTR_TWO (Control-M)
#
# Description    :  This shell program is for one time run that will call the CCN Back Feed File Creation Modules 
#
# This shell program will initiate the creation of the CCN Back Feed file created out as part 
# of one time run (OTR) 
# Oracle Audit file and FTP'd to the mainframe using the following modules:
#    
# audit_load_otr_two.sh   -->  Creates the Audit Back Feed File 
# Backfeed_CAT_otr.sh -->  Creates the concatenated file
# Created         :  AXK326 12/02/2015 CCN Project Team....
###################################################################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 BACKFEED_PATH="$HOME/batchJobs/backFeed/"
 cd $BACKFEED_PATH

echo "Processing Started for backfeed process at ${TIME} on ${DATE}"
############################################################################
#         execute audit_load_otr_two.sh shell to create CCN Backfeed File
############################################################################
echo "Processing Started for audit_load_otr_two at ${TIME} on ${DATE}"
./audit_load_otr_two.sh
#############################################
#   ERROR STATUS CHECK  audit_load_otr_two shell
#############################################
status=$?
if test $status -ne 0 
   then
     echo "processing FAILED for audit_load_otr_two at ${TIME} on ${DATE}"
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing Finished for audit_load_otr_two at ${TIME} on ${DATE}"

##############################################################################
#  Execute Backfeed_CAT_otr.sh to Concatenate all the files in order to send to MF
##############################################################################
echo "Concatenating Started at ${TIME} on ${DATE}"
./Backfeed_CAT_otr.sh
##############################################
#    ERROR STATUS CHECK Backfeed_CAT_otr.sh 
##############################################
status=$?
if test $status -ne 0
   then
     echo "processing FAILED for Backfeed_CAT_otr at ${TIME} on ${DATE}"
     exit 1;
fi
TIME=`date +"%H:%M:%S"`
echo "Processing Finished for Backfeed_CAT_otr at ${TIME} on ${DATE}"
echo "Processing finished for backfeed process at ${TIME} on ${DATE}" 

exit 0
############################################################################
#                     END  of  PROGRAM  
############################################################################





