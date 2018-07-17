#!/bin/sh

##########################################################################################
# Script Name   :  load_adminorg_file.sh
# purpose of this script will be to send files to Jeffery team on Adminorg_hierarchy_attributes
# details and perform the following steps:
# 1. establish connection to SQLPLUS
# 2. Get details from view with header details
#    and load to XLSX  file
#
# Date Created: 07/05/2018 kxm302
# Date Updated: 
#
##########################################################################################

# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 proc="GEN_ADMINORG_HRCHY_ATTR_FILE"
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
    CCN_BATCH_PROCESS.GEN_ADMINORG_HRCHY_ATTR_FILE();
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
     ./send_mail.sh "ADMINORG_HIERARCHY_MNTHLY_PRCSS" "The Adminorg file generate failed"
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  
exit 0
############################################################################
