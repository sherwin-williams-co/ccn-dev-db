#!/bin/sh

##########################################################################################
#
# purpose of this script will be to control passing the audit log files to main frame
# this script will be called by a job scheduler and perform the following steps:
# 1. establish connection to SQLPLUS
# 2. call the script that will execute an SQL Database Procedure
#    this will unload Audit_Log records to a flat file
# 3. call the script that will copy that flat file to
#    an audit_history file that has a date-time stamp
# 4. call the script that will FTP the time stamped file to the mainframe
#
# Date Created: 10/25/2012 TAL
# Date Updated: 
#
##########################################################################################

echo "\n begin audit_load.sh script"

# link to parameter file
. /app/ccn/ccn.config

# establish parameter names for this script
PROC="audit_load.sql"
DATAFILES="/app/ccn/datafiles"
CUR_DIR="/app/ccn/batchJobs/backFeed/current"
LOG_DIR="/app/ccn/batchJobs/backFeed/logs"

# establish the date and time
DATE=`date +"%Y-%m-%d"`
TIME=`date +"%H:%M:%S"`

ORACLE_HOME=/swstores/oracle/stcprd/product/11g
export ORACLE_HOME

ORACLE_SID=STCPRD
export ORACLE_SID

echo "\nProcessing Started for $PROC at $TIME on $DATE"
$ORACLE_HOME/bin/sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END
set heading off;
set serveroutput on;
set verify off;

@/app/ccn/batchJobs/sql/$PROC
 
exit;
END

echo "\n return from $PROC \n"

##############################################
#  ERROR STATUS CHECK
##############################################
status=$?
if test $status -ne 0
   then
     TIME=`date +"%H:%M:%S"`
     echo "\n processing of $PROC failed at ${TIME} on ${DATE}"
     exit 1;
else
   #move all the datafiles for backFeed to current
   mv `find $DATAFILES/*_backfeed* -type f` $CUR_DIR
   echo "\n Successfully moved datafiles to current at ${TIME} on ${DATE} "
fi

echo "\n ending audit_load.sh script \n"

##############################
#  end of script             #
##############################
