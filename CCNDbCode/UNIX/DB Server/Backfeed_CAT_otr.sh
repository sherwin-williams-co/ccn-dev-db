#!/bin/sh
##############################################################################
# Shell script is to concatenate the backfeed files created when audit runs
# Created : 12/02/2015 AXK326 CCN Project Team....
# Revised : 
##############################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

CUR_PATH="$HOME/batchJobs/backFeed/current"
cd $CUR_PATH

echo "concatenating datafiles"
cat $CUR_PATH/*_backfeed* > $CUR_PATH/Audit_backfeed.txt
echo " Done Concatenating files "

exit 0

