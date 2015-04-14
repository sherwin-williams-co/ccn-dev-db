#!/bin/sh

##############################################################################################
# Script Name   :  CCN_MF_AUDIT_SYNC.sh
# purpose of this script is sync the Terr Emps from CCN to MF
#
# Date Created: SXH 04/10/2015
##############################################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh


PROC="CCN_MF_AUDIT_SYNC"
DATAFILES="$HOME/datafiles"
CUR_DIR="$HOME/batchJobs/backFeed/current"
LOG_DIR="$HOME/batchJobs/backFeed/logs"

DATE=`date +"%Y-%m-%d"`
TIME=`date +"%H:%M:%S"`
TimeStamp=`date '+%Y%m%d%H%M%S'`

echo " Processing Started for $PROC at $TIME on $DATE "

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $HOME/batchJobs/backFeed/CCN_MF_AUDIT_SYNC.log <<END
set heading off;
set verify off;

execute TERR_EMP_SYNC_SP();
drop procedure TERR_EMP_SYNC_SP;
 
exit;
END

echo " return from $PROC at $TIME on $DATE "

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

echo "ending CCN_MF_AUDIT_SYNC.sh script "
exit 0
##############################
#  end of script             #
##############################
