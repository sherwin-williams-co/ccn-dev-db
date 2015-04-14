#!/bin/sh

##############################################################################################
# Script Name   :  TERR_EMPS_AUDIT.sh
#
# Description    :  This shell program will call the CCN Back Feed File Creation Modules 
#
# This shell program will initiate the creation of the CCN Back Feed file created out ot the 
# Oracle Audit file and FTP'd to the mainframe 
#
# Created           :  SXH 04/10/2015
##############################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 BACKFEED_PATH="$HOME/batchJobs/backFeed/"
 cd $BACKFEED_PATH

echo "Processing Started for backfeed process at ${TIME} on ${DATE}"
############################################################################
#         execute TERR_EMPS_AUDIT.sh shell to create CCN Backfeed File
############################################################################
echo "Processing Started for TERR_EMPS_AUDIT at ${TIME} on ${DATE}"
./CCN_MF_AUDIT_SYNC.sh


#############################################
#   ERROR STATUS CHECK TERR_EMPS_AUDIT shell
#############################################
status=$?
if test $status -ne 0 
   then
     echo "processing FAILED for TERR_EMPS_AUDIT at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing Finished for TERR_EMPS_AUDIT at ${TIME} on ${DATE}"

##############################################################################
#  Execute Backfeed_CAT.sh to Concatenate all the files in order to send to MF
##############################################################################
echo "Concatenating Started at ${TIME} on ${DATE}"
./Backfeed_CAT.sh

echo "Processing Finished for Backfeed_CAT at ${TIME} on ${DATE}"


##############################################
#    ERROR STATUS CHECK Backfeed_CAT.sh 
##############################################
status=$?
if test $status -ne 0
   then
     echo "processing FAILED for Backfeed_CAT at ${TIME} on ${DATE}"
     exit 1;
fi

############################################################################
#   execute audit_ftp.sh shell to send CCN Backfeed File to Mainframe
############################################################################
echo "Processing Started for audit_ftp at ${TIME} on ${DATE}"
./audit_ftp.sh

##############################################
#    ERROR STATUS CHECK audit_ftp shell
##############################################
status=$?
if test $status -ne 0
   then
     echo "processing FAILED for audit_ftp at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing Finished for audit_ftp at ${TIME} on ${DATE}"
echo "Processing finished for backfeed process at ${TIME} on ${DATE}"  

exit 0

############################################################################
#                     END  of  PROGRAM  
############################################################################

