#!/bin/sh
#################################################################
# Shell script to concatenate the backfeed files created by Audit
# load to be FTP'ed to mainframe
#
#################################################################

CUR_PATH="/app/ccn/batchJobs/backFeed/current"

echo "\n Concatenating files \n"

cd $CUR_PATH
echo "\n concatenating datafiles \n"
cat $CUR_PATH/*_backfeed* > $CUR_PATH/Audit_backfeed.txt
echo "\n Done Concatenating files \n"
