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

echo " begin audit_load.sh script"

# below command will get the path for ccn.config respective to the environment from which it is run from
. `cut -d/ -f1-4 <<<"${PWD}"`/ccn.config

# establish parameter names for this script
PROC="audit_load_hierarchy.sql"
DATAFILES="$HOME/datafiles"
CUR_DIR="$HOME/batchJobs/backFeed/current"
LOG_DIR="$HOME/batchJobs/backFeed/logs"

# establish the date and time
DATE=`date +"%Y-%m-%d"`
TIME=`date +"%H:%M:%S"`


echo "\nProcessing Started for $PROC at $TIME on $DATE"
sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END
set heading off;
set serveroutput on;
set verify off;

@$HOME/batchJobs/sql/$PROC
 
exit;
END

echo "return from $PROC"

##############################################
#  ERROR STATUS CHECK
##############################################
status=$?
if test $status -ne 0
   then
     TIME=`date +"%H:%M:%S"`
     echo "processing of $PROC failed at ${TIME} on ${DATE}"
     exit 1;
else
   #move all the datafiles for backFeed to current
   mv `find $DATAFILES/*_backfeed* -type f` $CUR_DIR
   echo "Successfully moved datafiles to current at ${TIME} on ${DATE} "
fi

echo "ending audit_load.sh script"

##############################
#  end of script             #
##############################
