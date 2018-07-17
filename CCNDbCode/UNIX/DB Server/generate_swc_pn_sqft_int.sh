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
sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<EOF
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
    :exitCode := 0;
    CCN_MARKETING_SQ_FT_LOAD.LOAD_SWC_PN_SQFT_INT();
Exception
when others then
    :exitCode := 2;
END;
/
exit :exitCode
EOF
############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     TIME=`date +"%H:%M:%S"`
     cd $HOME
     ./send_mail.sh "LOAD_SWC_PN_SQFT_INT" "Load to CCN_SWC_PN_SQFT_INT failed"
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  
exit 0
############################################################################
