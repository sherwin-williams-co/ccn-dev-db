#!/bin/sh

##########################################################################################
#
# purpose of this script is to pull all the records that did not go through as part of
# previous changes for the employee 'term' status and also records which came in for the first
# time into audit_log table whose previous records were NULL
# Date Created: 12/02/2015 AXK326 CCN Project Team....
#
##########################################################################################

echo " begin audit_load_otr_one.sh script"

# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

# establish parameter names for this script
PROC="audit_load_otr_one.sql"
DATAFILES="$HOME/datafiles"
CUR_DIR="$HOME/batchJobs/backFeed/current"
LOGDIR="$HOME/batchJobs/backFeed/logs"

# establish the date and time
DATE=`date +"%Y-%m-%d"`
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $PROC at $TIME on $DATE"
sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$PROC"_"$TimeStamp.log <<END
set heading off;
set serveroutput on;
set define off;
set verify off;

@$HOME/batchJobs/sql/$PROC
 
exit;
END

echo " return from $PROC at $TIME on $DATE \n"

##############################################
#  ERROR STATUS CHECK
##############################################
status=$?
if test $status -ne 0
   then
     TIME=`date +"%H:%M:%S"`
     echo " processing of $PROC failed at ${TIME} on ${DATE}"
     exit 1;
else
   #move all the datafiles for backFeed to current
   mv `find $DATAFILES/*_backfeed* -type f` $CUR_DIR
   echo " Successfully moved datafiles to current at ${TIME} on ${DATE} "
fi

echo "ending audit_load_otr_one.sh script "

##############################
#  end of script             #
##############################
