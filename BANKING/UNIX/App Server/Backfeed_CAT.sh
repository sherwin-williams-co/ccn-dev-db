#!/bin/sh

#################################################################
# Shell script to concatenate the backfeed files created by Audit
# load to be FTP'ed to CCN DB server
#
# Created : 09/16/2015 jxc517 CCN Project....
# Revised :
#################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/banking/dev/banking.config

CUR_PATH="$HOME/batchJobs/backFeed/current"
cd $CUR_PATH

echo "concatenating datafiles"
cat $CUR_PATH/*_backfeed* > $CUR_PATH/Banking_backfeed.txt
echo " Done Concatenating files "

exit 0
