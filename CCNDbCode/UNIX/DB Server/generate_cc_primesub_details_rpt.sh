#!/bin/sh

##########################################################################################
# Script Name   :  generate_cc_primesub_details_rpt.sh
# purpose of this script will be to generate primesub dtails report for Pats Team
# details and perform the following steps:
# 1. establish connection to SQLPLUS
# 2. Execute GENERATE_PRIMESUB_DETAIL_RPT procedure to get report
#    and load to xlsx  file
#
# Date Created: 08/16/2018 kxm302
# Date Updated: 
#
##########################################################################################
# Change directory to home path
cd /app/ccn/dev

# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 proc="GENERATE_PRIMESUB_DETAILS_RPT"
 LOGDIR="$HOME/datafiles/log"
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
    CCN_GL_PS_ACCOUNTS_PKG.GENERATE_PRIMESUB_DETAILS_RPT();
EXCEPTION
WHEN OTHERS THEN
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
     ./send_mail.sh "GENERATE_PRIMESUB_DETAILS_RPT" "The CCN PrimeSub details Report generate failed"
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  
exit 0
############################################################################
