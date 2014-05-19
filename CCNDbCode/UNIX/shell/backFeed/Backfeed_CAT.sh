#!/bin/sh
#################################################################
# Shell script to concatenate the backfeed files created by Audit
# load to be FTP'ed to mainframe
#
#################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. `cut -d/ -f1,2,3,4 <<<"${PWD}"`/ccn.config

CUR_PATH="$HOME/batchJobs/backFeed/current"

echo "Concatenating files "

cd $CUR_PATH
echo "concatenating datafiles"
cat $CUR_PATH/*_backfeed* > $CUR_PATH/Audit_backfeed.txt
echo " Done Concatenating files "
