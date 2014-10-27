#!/bin/sh
#################################################################
# Script name   : sd_report_query.sh
#
# Description   : This script is to run the SD_REPORT_PKG.STORE_DRAFT_REPORT_QUERY to load the store_draft_report table
#
# Created  : 10/22/2014 jxc517 CCN Project Team.....
# Modified :
#################################################################
# below command will get the path for stordrft.config respective to the environment from which it is run from
. /app/stordrft/host.sh

proc_name="sd_report_query"
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
A=date -d "-1 day" +"%m/%d/%Y"
A1=date +"%m/%d/%Y"

#writing the parameters in the param.lst file
echo "$A|$A1" >> $HOME/Reports/param.lst

#writing the parameters in the param1.lst file for report
R=`date -d "-1 month" +"%Y,%m,%d"`
R1=`date -d "-1 month -1 day" +"%Y,%m,%d"`

echo "$R|$R1" >> $HOME/Reports/param1.lst

P1=`cat $HOME/Reports/param.lst|cut -d"|" -f1`
P2=`cat $HOME/Reports/param.lst|cut -d"|" -f2`

TIME=`date +"%H:%M:%S"`
DATE=`date +"%m/%d/%Y"`

echo "START SD Report Query : Processing Started at $TIME on $DATE "

sqlplus -s -l $sqlplus_user/$sqlplus_pw <<END
set heading off;
set serveroutput on;
set verify off;

exec SD_REPORT_PKG.sd_report_query(to_date('$P1','MM/DD/YYYY'), to_date('$P2','MM/DD/YYYY'));

exit;
END

TIME=`date +"%H:%M:%S"`
echo "END SD Report Query : Processing finished at ${TIME}"  

#ftp the param1.lst to the store draft app server 
./ftp_param.sh

#removing the param.lst so that it can re write on next run with new parameter
rm param.lst
rm param1.lst 

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
