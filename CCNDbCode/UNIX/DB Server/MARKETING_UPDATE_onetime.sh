#!/bin/sh

##########################################################################################
# Script Name  : MARKETING_UPDATE_onetime.sh
# Date Created : 08/31/2015 dxv848 updating the Marketing table one time run.
#
##########################################################################################

echo "Starting  MARKETING_UPDATE_onetime.sh script"

# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

# establish parameter names for this script
PROC="MARKETING_TABLE_UPDATE.sql"

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
   echo "processing of $PROC Successful at ${TIME} on ${DATE} "
fi

echo "ending MARKETING_UPDATE_onetime.sh script"

##############################
#  end of script             #
##############################
