#!/bin/sh
#################################################################
# Shell script to concatenate the backfeed files created by Audit
# load to be FTP'ed to mainframe
# Revised :09/16/2015 sxh487 Renaming the Banking_backfeed.txt 
#          to Banking_audit.txt
#################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

CUR_PATH="$HOME/batchJobs/backFeed/current"

echo "Concatenating files "

cd $CUR_PATH
echo "Renaming Banking_backfeed.txt to Banking_audit.txt"
mv $CUR_PATH/Banking_backfeed.txt $CUR_PATH/Banking_audit.txt
echo "concatenating datafiles"
cat $CUR_PATH/*_backfeed* > $CUR_PATH/Audit_backfeed.txt
echo " Done Concatenating files "
