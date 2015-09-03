#!/bin/sh
#############################################################################
# Script Name   :  price_distrinct_hier_load.sh
#
# Description    :  This shell program will initiate the PRICE_DSTRCT_HIER_LOAD_MAIN_SP 
#
# This shell program will initiate the LOAD_HIERARCHY script that 
#   * Disables all the Triggers for HIERARCHY_DETAIL Table
#   * Loads the HIERARCHY_HEADER,HIERARCHY_DESCRIPTION, INTERMEDIATE  tables
#   * Loads the HIERARCHY_DETAIL table with the price district data
#   * Re-Enables the Triggers
#
# Created :  nxk927 09/03/2015
############################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. `cut -d/ -f1-4 <<<"${PWD}"`/ccn.config

 proc="price_distrinct_hier_load"
 LOGDIR="$HOME/hier"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "Processing Started for $proc at $TIME on $DATE"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;

execute PRICE_DIST_HRCHY_LOAD.PRICE_DSTRCT_HIER_LOAD_MAIN_SP;

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "Processing finished for $proc at ${TIME} on ${DATE}"  

exit 0

############################################################################

