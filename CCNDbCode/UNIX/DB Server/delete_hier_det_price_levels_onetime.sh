#!/bin/sh

##########################################################################################
# Script Name  : delete_hier_det_price_levels_onetime.sh
# Date Created : 05/17/2017 sxp130 deleting the Hierarchy_detail table one time run.
#                delete_hier_det_price_levels_onetime.sh calls the delete_hier_det_price_levels_ASP_788.sql to delete the
#                hierarchy detail levels which are cost center not attached.    
##########################################################################################

echo "Starting  delete_hier_det_price_levels_onetime.sh script"

# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

# establish parameter names for this script
PROC="delete_hier_det_price_levels_ASP_788.sql"

# establish the date and time
DATE=`date +"%Y-%m-%d"`
TIME=`date +"%H:%M:%S"`

cd $HOME/AdhocTaskScripts/sql
pwd
echo "Processing Started for $PROC at $TIME on $DATE"
sqlplus -s -l $sqlplus_user/$sqlplus_pw <<EOF > delete_hier_det_price_levels_ASP_788.log
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

echo "ending delete_hier_det_price_levels_onetime.sh script"

exit 0

###################################################################################
#                          END OF SCRIPT                                          #
###################################################################################
