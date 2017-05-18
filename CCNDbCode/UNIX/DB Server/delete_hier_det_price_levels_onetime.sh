#!/bin/sh

#####################################################################################################################
# script name   : delete_hier_det_price_levels_onetime.sh
#
# description   : script to delete unattached cost center PRICE_DISTRICT hierarchy levels from Hierarchy_Detail table
#		          This script is one-time run.
#   Created     : 05/18/2017 SXP130
#   Modified    : 
#####################################################################################################################


# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
proc_name="delete_hier_det_price_levels_ASP_788"

echo "Processing Started for $PROC at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END > delete_hier_det_price_levels_ASP_788.log
set heading off;
set serveroutput on;
set verify off;
WHENEVER OSERROR EXIT 1
WHENEVER SQLERROR EXIT 1
var EXITCODE number;
exec :EXITCODE := 0;
@$HOME/AdhocTaskScripts/sql/delete_hier_det_price_levels_ASP_788.sql
print :EXITCODE;
exit :EXITCODE;
END

############################################################################
#                           ERROR STATUS CHECK
############################################################################
status=$?
if [ $status -ne 0 ]; then
     TIME=`date +"%H:%M:%S"`
     echo "processing FAILED for $proc_name at $TIME on $DATE"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc_name at ${TIME} on ${DATE}"

exit 0
############################################################################