#!/bin/sh
#############################################################################
# Script Name   :  JV_monthly_load.sh
#
# Description    : This shell program will initiate the script that 
#    		     loads the Monthy benefits JV with ADP information
#                  
# 
# Created           :  sxh487 10/02/2014
# Modified          :  
############################################################################
# below command will get the path for ccn.config respective to the environment from which it is run from
. /app/ccn/host.sh

 proc="CREATE_JV"
 LOGDIR="$HOME/initLoad/STORDRFT"
 TIME=`date +"%H:%M:%S"`
 DATE=`date +"%m/%d/%Y"`
 TimeStamp=`date '+%Y%m%d%H%M%S'`

echo "\n Processing Started for $proc at $TIME on $DATE \n"

sqlplus -s -l $strdrft_sqlplus_user/$strdrft_sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;

execute SD_BENEFITS_PKG.CREATE_JV();

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
status=$?
if test $status -ne 0
then
     echo "\n processing FAILED for $proc at ${TIME} on ${DATE} \n"
     exit 1;
fi

TIME=`date +"%H:%M:%S"`
echo "\n Processing finished for $proc at ${TIME} on ${DATE} \n"  

exit 0

############################################################################

