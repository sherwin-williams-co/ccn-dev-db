#!/bin/sh

##########################################################################################
# Script Name   :  generate_cc_numeric_seq_roster_rpt.sh
# purpose of this script will be to generate cc_numeric_seq_roster_rpt for Mobius Team
# details and perform the following steps:
# 1. establish connection to SQLPLUS
# 2. Execute CC_NUMERIC_SEQ_ROSTER_RPT procedure to get report
#    and load to CSV  file
#
# Date Created: 08/09/2018 kxm302
# Date Updated: 
#
##########################################################################################
# Change directory to home path
cd /app/ccn/dev

# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/BMChost.sh

 proc="CC_NUMERIC_SEQ_ROSTER_RPT"
 LOGDIR="$HOME/datafiles/log"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc  at $TIME on $DATE"
sqlplus -s -l $sqlplus_user/$sqlplus_pw@$sqlplus_host >> $LOGDIR/$proc"_"$TimeStamp.log <<EOF
set heading off;
set verify off;
set serveroutput on;
var exitCode number;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
BEGIN
    :exitCode := 0;
    CCN_BATCH_PROCESS.CC_NUMERIC_SEQ_ROSTER_RPT();
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
     ./send_mail.sh "CC_NUMERIC_SEQ_ROSTER_RPT" "The CCN NUmeric Sequence Roster Report generate failed"
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  
exit 0
############################################################################
