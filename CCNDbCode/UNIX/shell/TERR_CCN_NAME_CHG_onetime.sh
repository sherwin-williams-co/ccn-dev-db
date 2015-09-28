#!/bin/sh

##########################################################################################
# Script Name  : TERR_CCN_NAME_CHG_onetime.sh
# Date Created : 08/25/2015 dxv848 updating the Cost_center table one time run.
#                TERR_CCN_NAME_CHG_onetime.sh calls the TERR_CCN_NAMES_CHG.sql to update the
#                Cost_center_name in the cost_center table.    
##########################################################################################

echo "Starting  TERR_CCN_NAME_CHG_onetime.sh script"

# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

# establish parameter names for this script
PROC="TERR_CCN_NAMES_CHG.sql"

# establish the date and time
DATE=`date +"%Y-%m-%d"`
TIME=`date +"%H:%M:%S"`

cd $HOME/batchJobs/sql
pwd
echo "Processing Started for $PROC at $TIME on $DATE"
sqlplus -s -l $sqlplus_user/$sqlplus_pw <<EOF
set heading off;
set serveroutput on;
set verify off;
 
@$PROC

exit;
EOF


echo "return from $PROC"

TIME=`date +"%H:%M:%S"`
##############################################
#  ERROR STATUS CHECK
##############################################
status=$?
if test $status -ne 0
   then
     
     echo "processing of $PROC failed at ${TIME} on ${DATE}"
     exit 1
else
   echo "processing of $PROC Successful at ${TIME} on ${DATE} "
fi

echo "ending TERR_CCN_NAME_CHG_onetime.sh script"

exit 0

###################################################################################
#                          END OF SCRIPT                                          #
###################################################################################
