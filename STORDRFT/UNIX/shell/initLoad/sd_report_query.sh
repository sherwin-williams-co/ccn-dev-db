#!/bin/sh
#################################################################
# Script name   : sd_report_query.sh
#
# Description   : This script is to run the SD_REPORT_PKG.STORE_DRAFT_REPORT_QUERY to load the store_draft_report table
#
# Created  : 01/02/2015 nxk927 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="sd_report_query"
LOGDIR=$HOME/Reports/log
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
echo "Processing Started for $proc_name at $TIME on $DATE"

#############################################################
# BELOW PROCESS WILL TRUNCATE CCN_HIERARCHY_INFO TABLE AND PULL
# DATA FROM HIERARCHY_DETAIL_VIEW TO UPDATE ANY CHANGES MADE
# FOR FURTHER PROCESSING
#############################################################
./ccn_hierarchy_info.sh

##setting up the parameters to run
P=`cat $HOME/Reports/param.lst`

echo "START SD Report Query : Processing Started at $TIME on $DATE for the date $P"

sqlplus -s -l $sqlplus_user/$sqlplus_pw >> $LOGDIR/$proc_name"_"$TIME.log <<END
set heading off;
set serveroutput on;
set verify off;

exec SD_REPORT_PKG.sd_report_query(to_date('$P','MM/DD/YYYY'));

exit;
END

TIME=`date +"%H:%M:%S"`
echo "END SD Report Query : Processing finished at ${TIME}"  

############################################################################
#                           ERROR STATUS CHECK 
############################################################################
TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`
status=$?
if test $status -ne 0
then
     echo "processing FAILED for $proc_name at ${TIME} on ${DATE}"
     exit 1;
fi

echo "Processing finished for $proc_name at ${TIME} on ${DATE}"  

exit 0
############################################################################
