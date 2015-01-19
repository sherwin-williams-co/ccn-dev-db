#!/bin/sh
#############################################################################
# Script Name : JV_monthly_load.sh
#
# Description : This shell program will initiate the script that 
#    		    loads the Monthly benefits JV with ADP information.
#                   
# Created     : sxh487 10/02/2014
# Modified    : sxt410 01/14/2015 Added P1 parameter to pass into Procedure.
#                                 Added get_param.sh to spool closing date.
##############################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from.
. /app/stordrft/host.sh

#below command will create param.lst file by spooling closing date from storedrft_jv_param table.
. /$HOME/initLoad/get_param.sh

proc="JV_monthly_load"
LOGDIR="$HOME/initLoad/logs"
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
TimeStamp=`date '+%Y%m%d%H%M%S'`
P1=`cat $HOME/initLoad/param.lst`
echo "Processing Started for $proc at $TIME on $DATE for the date $P1"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc"_"$TimeStamp.log <<END
set heading off;
set verify off;

execute SD_BENEFITS_PKG.CREATE_JV(to_date('$P1','MM/DD/YYYY'));

exit;
END

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "Processing FAILED for $proc at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc at ${TIME} on ${DATE} for the date $P1"  

exit 0
############################################################################