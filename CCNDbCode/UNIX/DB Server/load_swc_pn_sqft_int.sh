#!/bin/sh
#############################################################################
# Script Name   :  load_swc_pn_sqft_int.sh
#
# Description   :  This shell program will initiate the LOAD_SWC_PN_SQFT_INT 
#                    for Footage process  
#
# Created :  kxm302 07/10/2018
############################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 proc="LOAD_SWC_PN_SQFT_INT"
 LOGDIR="$HOME/batchJobs"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc  at $TIME on $DATE"
sqlplus -s -l $sqlplus_user/$sqlplus_pw <<EOF
SET NEWPAGE 0
SET SPACE 0
SET LINESIZE 1000
SET PAGESIZE 0
SET ECHO OFF
SET FEEDBACK OFF
SET HEADING OFF
set TERM OFF

EXECUTE CCN_MARKETING_SQ_FT_LOAD.LOAD_SWC_PN_SQFT_INT();	
 
exit;
EOF
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0

############################################################################
