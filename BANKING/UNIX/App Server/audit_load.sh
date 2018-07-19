#!/bin/sh

##########################################################################################
# Purpose of this script will be to control passing the audit log files to main frame
# this script will be called by a job scheduler and perform the following steps:
# 1. establish connection to SQLPLUS
# 2. call the script that will execute an SQL Database Procedure
#    this will unload Audit_Log records to a flat file
# 3. call the script that will copy that flat file to
#    an audit_history file that has a date-time stamp
# 4. call the script that will FTP the time stamped file to the CCN DB Server
#
# Created : 09/16/2015 jxc517 CCN Project....
# Revised : 07/19/2018 kxm302 CCN Project....
#           Removed moving backfeed files process as no files created as per audit process
#           cleanup in Banking
##########################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

PROC="audit_load.sh"
DATAFILES="$HOME/initLoad"
CUR_DIR="$HOME/batchJobs/backFeed/current"
DATE=`date +"%Y-%m-%d"`
TIME=`date +"%H:%M:%S"`

echo "Processing Started for $PROC at $TIME on $DATE"
sqlplus -s -l $banking_sqlplus_user@$banking_sqlplus_sid/$banking_sqlplus_pw <<END
set heading off;
set serveroutput on;
set verify off;

EXECUTE BANKING_AUDIT_PKG.SELECT_AUDIT_LOG();
 
exit;
END
##############################################
#  ERROR STATUS CHECK
##############################################
status=$?
if test $status -ne 0
   then
     TIME=`date +"%H:%M:%S"`
     echo " processing of $PROC failed at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing Finished for $PROC at $TIME on $DATE"
exit 0
##############################
#  end of script             #
##############################
