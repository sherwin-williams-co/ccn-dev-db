#!/bin/sh

#############################################################################
# Script Name   :  INITLOAD
#
# Description    :  This shell program will initiate the INITLOAD.SQL file 
#
# This shell program will initiate the INITLOAD.SQL script to load the CCN
# ORACLE database from files sent from the Legacy IDMS CCN Database.
#
# Created           :  MDH 11/16/2012
############################################################################
. /app/ccn/ccn.config

 proc="initLoad"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "\n Processing Started for $proc at ${TIME} on ${DATE} \n"

# execute Initload.sql file to delete and load all CCN tables
sqlplus -s -l $sqlplus_user/$sqlplus_pw @/app/ccn/initLoad/sql/$proc.sql >> $initLoad_log_dir/$proc"_"$TimeStamp.log <<END

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if  test $status -ne 0
  then
     echo "\n processing FAILED for $proc at ${TIME2} on ${DATE}\n"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "\n Processing finished for $proc at ${TIME} on ${DATE}\n"  

exit 0

############################################################################

#                            END  of  PROGRAM  

############################################################################

